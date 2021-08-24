####
#' @title Asignación de clientes a asesores
#' @description Modelo de optimización que mínimiza el costo asociado de 
#' asignación de clientes a asesores teniendo en cuenta restricciones.
#' @param Clients Tabla de clientes por ciudad y sector
#' @param Workforce Tabla de asesores por ciudad, sector y jerarquía de 
#' asignación
#' @param assign_structure Estructura de asignación con límites para las 
#' retricciones
#' @return Tabla de clientes asignados
#' @example assign_solution(Clients = Call_1, workforce = workers)

assign_solution <- function(Clients, Workforce, assign_structure) {
 
  #Cargue de paquetes y conexiones
  source("R/global.R")
  
  
  tabla <- conn %>% tbl("Clients") %>% collect()
  
  
  
  
}