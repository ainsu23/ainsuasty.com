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


```{.r .blocks_style}
library(skimr) # skimr::skim() nos brinda el resumen estadística de una tabla
library(ggplot2) #ggplot2::ggplot(),geom_text(),geom_polygon(),annotation_custom(), datos: map_data()
library(dplyr) #dplyr::select(), group_by(),summarise(), mutate()
library(stringr) # stringr::str_replace_all(),
# library(ggimage) # ggimage::geom_image()
library(glue) # glue:glue()
library(gganimate) #
library(gifski)
```

## Lectura de datos

Las anteriores librerías son exclusivas para este blog, sin embargo, existen paquetes para leer archivos pdf, word, xls o también para extraer y enviar información a bases de datos. La función **read.csv** nos permite leer datos *csv* tal como lo vemos a continuación


```{.r .blocks_style}
Evol_Agrope_Colombia<-read.csv(params$Evol_Agrope_Colombia)

ColombiaMap <- map_data("world", region = "Colombia")

MapaColombia<-read.csv(params$MapaColombia)
```

### Resumen de los datos

La función skim (`skim(Evol_Agrope_Colombia)`) brinda un resumen muy detallado de los datos. A continuación lo explico: 1. Data Summary: resumen de la tabla, número de filas y columnas. 2. Tipo de datos: determina el número de columnas con tipo carácter, factor, numérico, entre otros. 3. Genera estadística descriptiva de cada variable

## Manejo de datos

Ya que hay una mayor claridad de los datos, empecemos a *"jugar"* un poco con ellos. El paquete `dplyr` nos permite hacer análisis de datos de una manera muy intuitiva.

El código de abajo asigna a la tabla **MapaColombia** con el signo "\<- o =" la misma tabla *MapaColombia* pero con modificaciones en el contenido con el siguiente operador `%>%` (ctrl + shift + m)

-   seleccionar columnas especificas (select)
-   agrupar por departamento (group_by)
-   tomar la media de longitud y latitud (para asignar el nombre dentro del mapa) (summarise)
-   los departamentos que tengan espacios entre sus palabras, juntarlas con un "\_", ejemplo "Valle del Cauca" por "Valle_del_Cauca" (mutate)
-   Por último, reemplazar nombres (mutate)


```{.r .blocks_style}
 MapaColombia<-MapaColombia %>%
  select(longitud,latitud,codigo_departamento,nombre_departamento) %>%
  group_by(nombre_departamento,codigo_departamento) %>%
  summarise(longitud=mean(longitud,na.rm = TRUE),
            latitud=mean(latitud,na.rm = TRUE)) %>%
  mutate(nombre_departamento=str_replace_all(nombre_departamento," ","_")) %>%
  mutate(nombre_departamento=
           ifelse(nombre_departamento=="ARCHIPIELAGO_DE_SAN_ANDRES,
                  _PROVIDENCIA_Y_SANTA_CATALINA","SAN_ANDRES_Y_PROVIDENCIA",
                  nombre_departamento))


MapaColombia %>% 
  head(5) %>% 
  as.data.frame()
```

La tabla ***Evol_Agrope_Colombia*** necesita las siguientes modificaciones para poder tener los datos perfectos para la construcción del mapa.:

-   Total área cosechada por departamento, cultivo y año.
-   Con la anterior agrupación, quedarse con el cultivo más cosechado.
-   Adicionar coordenadas en el mapa. Se hace un left_join() (tip excel: *buscarv*) con la tabla Mapa Colombia.
-   Columna image hace referencia al nombre del png a usar en la gráfica.


```{.r .blocks_style}
Evol_Agrope_Colombia <- Evol_Agrope_Colombia %>% 
  group_by(DEPARTAMENTO,CULTIVO,AÑO) %>%
  summarise(Area_Cosechada=sum(Área.Cosechada..ha.)) %>% 
  ungroup() %>%
  group_by(DEPARTAMENTO,AÑO) %>%
  filter(Area_Cosechada==max(Area_Cosechada)) %>% 
  ungroup() %>%
  mutate_if(is.factor,~str_replace_all(.," ","_")) %>%
  left_join(MapaColombia %>% rename(DEPARTAMENTO=nombre_departamento),
                       by = "DEPARTAMENTO") %>% filter(!is.na(Area_Cosechada)) %>%
  rename(long=longitud,lat=latitud) %>%
  select(DEPARTAMENTO,AÑO,Area_Cosechada,CULTIVO,long,lat) %>%
  ungroup() %>%
  as.data.frame() %>% 
  mutate(image = 
           glue::glue(
             "{here::here('content','post')}/{rmarkdown::metadata$date}-{stringr::str_to_lower(rmarkdown::metadata$slug)}/images/{CULTIVO}.png"))
```

Para situar los nombres de los departamentos, se creó la tabla `_region.lab.data_`, la cual contiene las coordenadas promedio de los departamentos de Colombia.


```{.r .blocks_style}
region.lab.data <- MapaColombia %>%
  group_by(nombre_departamento) %>%
  summarise(long = mean(longitud), lat = mean(latitud)) %>% 
  ungroup() %>%
  filter(nombre_departamento!="BOGOTA,_D._C.")
```

## Construcción de la grafica

El siguiente código es una combinación de paquetes muy poderosos para la construcción de gráficos. A continuación explico cada línea del código

1.  Tomar como: + eje x: longitud + eje y: latitud
2.  Dibujar el contorno del mapa de Colombia con geom_polygon, las líneas son dibujadas por las coordenadas dadas en la tabla ColombiaMap
3.  Con la tabla *Evol_Agrope_Colombia*, agregar las imágenes usando las coordenadas y la columna image
4.  Con la tabla *Evol_Agrope_Colombia*, agregar los nombres de cultivos en rojo usando las coordenadas y la columna CULTIVO
5.  Usando el paquete gganimate y la función transition_time, se crea un video respecto al tiempo. Las siguientes 3 líneas de código hacen referencia a efectos del video
6.  Con geom_text, se agrega el nombre del departamento.


```{.r .blocks_style}
 p <- ggplot(ColombiaMap,aes(x = long, y = lat)) +
   geom_polygon(aes(group = group, fill = subregion),
                color = "orange",
                fill = "white") +
   geom_image(data = Evol_Agrope_Colombia,
              aes(x = long,y = lat,image = image),
              size = 0.07) +
   geom_text(data = Evol_Agrope_Colombia,
             aes(x = long, y = lat, label = CULTIVO),
             size = 3, vjust = -0.5, color = "red", fontface = "italic") +
   transition_time(AÑO)+
   labs(title = "Año: {frame_time}")+
   enter_fade() +
   exit_shrink() +
   geom_text(aes(label = nombre_departamento),
             data = region.lab.data,  size = 4, hjust = 0.5,
             color = "black", family = "Courier", fontface = "bold" ) +
   scale_colour_manual( values = c("#FFFFFF", "#FFFFFF")) +
   theme(legend.position = "none")


 animate(p, height = 1200, width = 1000,fps=30,duration=15)

 

 ## Guardar gif con la siguiente linea de comando
 # anim_save(animation = p,"images/evolucionAgropecuaria.gif")
```

![](images/plot-1.gif){width="548"}
