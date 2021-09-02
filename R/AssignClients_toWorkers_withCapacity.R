# Asignacion de clientes a vendedores con capacidad

# Cargue  librerías y conexión a PostrSQL---------------------------------------
rm(list = ls())
source("R/global.R")

# Parámetros del modelo ----
n_clientes <- 1000
n_trabajadores <- 20
n_oficinas <- 4
n_servicios <- 4
n_subservicios <- 10
n_cargos <- 4

# Creación de datos ----
#### Trabajadores ####a
trabajadores <- list(
  "base" = data.frame()
)

trabajadores$base <- data.frame(
  "id_tr" = sample(1:n_trabajadores,replace = TRUE),
  "oficina" = 1:n_trabajadores %>% 
    purrr::map(function(x){
      rep(sample(1:n_oficinas,replace = FALSE),1)[1]
    }) %>% unlist(),
  "cargo" = 1:n_trabajadores %>% 
    purrr::map(function(x){
      sample(LETTERS[1:n_cargos],1,replace = TRUE)
    }) %>% 
    unlist()
) %>% 
  left_join(
    data.frame(
      "cargo" = LETTERS[1:n_cargos],
      "capacidad" = 1:n_cargos %>% purrr::map(function(x){
        sample(seq(50,100,10),1,replace = FALSE)
      }) %>% unlist(),
      "costo" = 1:n_cargos %>% purrr::map(function(x){
        sample(seq(10,50,5),1,replace = FALSE)
      }) %>% unlist()
    ),
    by = "cargo"
  )

#### Clientes ####
clientes <- list(
  "base" = data.frame()
)

clientes$base <- data.frame(
  "id_cl" = sample(1:n_clientes,replace = FALSE),
  "oficina" = rep(sample(1:n_oficinas,replace = TRUE)),
  "servicio" = 1 %>% purrr::map(function(x){
    paste("servicio_",sample(1:n_servicios,replace = TRUE),sep = "")
  }) %>% unlist(),
  "sub_servicio" = 1 %>% purrr::map(function(x){
    paste("sub_servicio_",sample(1:n_subservicios,replace = TRUE),sep = "")
  }) %>% unlist()
) %>% ungroup()

#### servicios ####
servicios <- list(
  "estructura" = data.frame()
)

servicios$estructura <- data.frame(
  "sub_servicio" = paste("sub_servicio_",1:n_subservicios,sep = ""),
  "servicio" = 1:n_subservicios %>% purrr::map(function(x){
    paste("servicio_",sample(1:(n_servicios*2),replace = TRUE),sep = "")
  }) %>% unlist(),
  "cargo" = 1:(n_subservicios*n_servicios) %>% purrr::map(function(x){
    sample(LETTERS[1:n_cargos],1,replace = TRUE)
  }) %>% unlist()
) %>% distinct()

## Modelo a optimizar ----
tic()
future::plan("multiprocess")


modelo <-
  MILPModel() %>%
  add_variable(ship[tr, cl],
               tr = 1:n_trabajadores, cl = 1:n_clientes,
               type = "binary") %>%
  add_constraint(sum_expr(ship[tr, cl], cl = 1:n_clientes) <=
                   colwise(
                     tr %>% furrr::future_map(function(x){
                       trabajadores$base %>%
                         filter(id_tr == x) %>%
                         pull("capacidad")
                     }) %>% unlist()
                   ), tr = 1:n_trabajadores
                 ) %>%
  add_constraint(sum_expr(ship[tr, cl], tr = 1:n_trabajadores) == 1,
                 cl = 1:n_clientes) %>%
  set_objective(sum_expr(ship[tr, cl] *
                  colwise(
                    cl %>% furrr::future_map(function(cl){
                      tr %>% furrr::future_map(function(tr){
                        clientes$base %>%
                          inner_join(servicios$estructura,
                                     by = c("servicio","sub_servicio")) %>% 
                          inner_join(trabajadores$base,
                                     by = c("oficina", "cargo")) %>% 
                          dplyr::filter(id_tr == tr & id_cl == cl) %>%
                            pull(costo) %>% {if (is_empty(.)) 0 else .}
                          }) %>% 
                          purrr::keep(~length(.x)>0)
                        }) %>% 
                      purrr::keep(~length(.x)>0) %>% unlist()
                    ),
                tr = 1:n_trabajadores, cl = 1:n_clientes
                ),"min") %>%
  ompr::objective_function()
  solve_model(with_ROI(solver = "lp"))

toc()  
