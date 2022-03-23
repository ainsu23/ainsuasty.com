---
title: Tips de procesos de Excel en R
author: Andres Insuasty
date: '2021-08-23'
slug: []
categories:
  - Excel
tags:
  - Excel
  - tips
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




## Procesos de excel realizados en R

### 1. Guardar en varias pestañas de un libro

Dividir una base de un libro de excel en varias pestañas teniendo en cuenta una columna, resulta facil con el uso de **purrr**.

-   separar archivo por columna


```{.r .blocks_style}
library(dplyr)

archivo <-readxl::read_excel(
  glue::glue("{here::here()}/datos/50_Mejores_Canciones_Latinas.xlsx"))
```

-   Seleccionar columna a separar y convierte a lista


```{.r .blocks_style}
columna <- archivo %>% 
  select(País) %>% 
  distinct() %>% as.data.frame()

lista <- as.list(columna$País)
```

-   Crea lista vacía para almacenar bases


```{.r .blocks_style}
bases = list()
```

-   Guarda cada base filtrada con el registro de la lista en una lista de dataframes, adiciona nombres a los elementos de la lista y mantiene las bases que contengan registros




