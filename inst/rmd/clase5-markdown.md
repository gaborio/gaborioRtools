---
title: "Métodos cuantitativos RRII Javeriana - Clase 5"
author: "Gabriel N. Camargo-Toledo"
date: "Febrero 27, 2025"
output: 
  html_document:
    toc: true
    toc_float: true
    theme: united
    highlight: tango
    code_folding: show
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Introducción a R - Primera sesión

Este documento contiene el código para la primera sesión de introducción a R en el curso de Métodos Cuantitativos para Relaciones Internacionales.

## Creado por: Gabriel N. Camargo-Toledo
## Modificado: Feb/27/2025

## Carpetas y Proyectos

```{r folders}
getwd()
setwd("./figure")
setwd("..")
```

## Objetos Básicos

```{r basic-objects}
x_str <- "Hello World"
print(x_str)
summary(x_str)
print("Hello World")
a_num <- 1
b_num <- 2
c_num <- a_num+b_num
summary(a_num)
p_vec <- c(a_num, b_num, c_num)
p_dat <- cbind(a_num, b_num, c_num)
d_dat <- rbind(a_num, b_num,c_num)
x_dat <- rbind(p_vec, p_vec*2)
```

## Obteniendo Ayuda

```{r help}
help(print)
help(summary)
help(lm)
?lm
??l
```

## Paquetes

```{r packages, eval=FALSE}
install.packages("pastecs")
install.packages("tidyverse")
# PAQUETE DE LA CLASE
install.packages("devtools")
devtools::install_github("gaborio/gaborioRtools")
```
