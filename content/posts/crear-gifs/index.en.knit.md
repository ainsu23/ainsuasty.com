---
title: 'Crear GIFs con R: Evaluacion agricultura Colombia'
author: "Andrés Felipe Insuasty"
date: '2021-05-09'
slug: Crear-Gifs
categories:
- Colombia
- Agricultura
tags:
- gganimate
- ggplot
- tidyverse
params:
  Evol_Agrope_Colombia: data/Evaluaciones_Agropecuarias_Municipales_EVA.csv
  MapaColombia: data/MapaColombia.csv
---

<style type="text/css">
.blocks_style {
  font-weight: bold;
  background-color: whitesmoke;
  color: black;
  font-style: italic;
  font-family: Monospace;
}
</style>





# Aprende *R* con datos de <span style='color: yellow;'>Co</span><span style='color: blue;'>lom</span><span style='color: red;'>bia</span> !!

![](images/plot-1.gif){width="548"}

En esta ocasión revisamos la evolución agropecuaria de Colombia por departamentos a partir del año 2006 hasta el año 2018. Los datos fueron extraídos de los [*Datos Abiertos*](https://www.datos.gov.co/) de Colombia.

------------------------------------------------------------------------

R es un software estadístico OpenSource, esto quiere decir que el mundo entero está aportando al conocimiento y desarrollo de este mismo. **Por ejemplo: esta página Web y blog fueron creados sólo con código R.**

Lo primero que debes saber es que hay que instalar los paquetes que vas a necesitar (`install.packages("nombre_paquete")`), lo segundo es que estos paquetes contienen funciones.

***Por Ejemplo:*** `dplyr::arrange()` El paquete es *dplyr* (paquete para manejo de datos en tablas) y la función es *arrange* (función para ordenar columnas). El paquete puede contener una o más funciones, para el caso de dplyr tiene funciones que sirven para: seleccionar, borrar, filtrar, agregar, entre otras.

------------------------------------------------------------------------

## Cargue de Librerías

Las librerías y funciones a usar son:













