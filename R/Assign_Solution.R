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
#' @example assign_solution(Clients = STC, workforce = base_planta)

assign_solution <- function(Clients, Workforce, assign_structure) {
  
  # Cargue librerías ---------------------
  library(ompr)
  library(dplyr)
  library(ROI)
  library(ompr.roi)
  
  
  # Manejo de información ----------------
  
  
  
  
  
}