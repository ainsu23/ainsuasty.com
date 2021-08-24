

# separar archivos por columna
library(dplyr)
archivo <- readxl::read_excel("Datos/separar.xlsx")

columna <- archivo %>% 
  select(VERTICAL) %>% 
  distinct() %>% as.data.frame()

lista <- as.list(columna$VERTICAL)

bases = list()

bases <- lista %>% purrr::map(function(x){
  archivo %>% filter(VERTICAL == x)
}) %>% 
  purrr::set_names(columna[,1]) %>% purrr::keep(~nrow(.)>0)

writexl::write_xlsx(x = bases,path = "Datos/separado.xlsx",col_names = TRUE)

