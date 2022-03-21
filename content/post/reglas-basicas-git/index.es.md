---
title: "Reglas basicas Git"
author: "Andrés Felipe Insuasty"
date: '2021-08-10'
slug: []
categories: Git
tags: Git
---



# Reglas en  *Git* 🎯
## <span style='color: blue;'>Regla #1:</span>

*El master debe siempre estar actualizado con upstream/master. En este, no se pueden hacer cambios ni commits. Mantener actualizado siguiente el paso #1.*

En caso de saltarse la Regla #1, realizar paso #3.

## <span style='color: blue;'>Regla #2:</span>

Se debe abrir una rama por cada issue, en esta rama se realiza el paso \#2.

## <span style='color: blue;'>Regla #3:</span>
Seguir el conventional commits del siguiente link:
[conventional commits](https://www.conventionalcommits.org/en/v1.0.0/)

### Paso # 1: Traer el trabajo de otro colaborador

  - **git remote add `Colaborador` enlace_bifurcacion**: Adiciona bifurcación a mi repositorio
  - **git remote -v: ** bifurcaciones conectadas.
  - **git fetch `Colaborador`**: Busca cambios en ramas del colaborador 
  - **git merge `Colaborador`/rama**:  Trae cambios de la rama del colaborador sin quitar mis cambios realizados
  - **git rebase `upstream`/master**: Trae los cambios del upstream/master eliminando mis cambios realizados.
  
### Paso # 2: Cargar modificaciones a bifurcaciones

  - **git status**: ilustra los cambios realizados
  - **git add `ruta con cambio``: ** adiciona los cambios a realizar commit
  - **git commit `presionar i para insertar`**: realizar comentarios de acuerdo a conventional commits,
  no olvidar referenciar el número del caso. **para salir presionar** *esc y :x*
  - **git push**:  Envía los cambios realizados a la bifurcación
  - **Pull Request (PR) en github**
  
### Paso # 3: GIT RESET (tener mucho cuidado!)

Permite volver commits en el tiempo, se puede perder la información dependiendo de como se escriba el git reset.

  - git whatchanged: Muestra los commits realizados, de aquí se debe tomar el #id del commit al que se requiere devolver.

  - git reset –hard #idcommit: devuelve a la rama con ese commit perdiendo todo lo después realizado.

  - git push -f: fuerza cambios con un push

  
Git Fin !  
