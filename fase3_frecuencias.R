# =====================================================================
# LAB 3 · FASE 3 — Frecuencias y agrupacion
# Proyecto: Analisis de metricas de software y DevOps
# Autor: Benjamin Herrera
# =====================================================================

library(tidyverse)

# ---- 1. Cargar el dataset limpio -----------------------------------
df <- read_csv("devops_metrics_clean.csv")

# Variable a agrupar (la misma del ejemplo del profe)
x <- df$build_time_min

# ---- 2. Numero de clases con la regla de Sturges -------------------
# Sturges decide cuantos intervalos usar segun el tamano de la muestra.
k <- ceiling(1 + 3.322 * log10(length(x)))
cat("Numero de clases (Sturges):", k, "\n")

# ---- 3. Tabla de frecuencias ---------------------------------------
# cut() parte la variable en k intervalos de igual ancho.
tabla <- df %>%
  mutate(clase = cut(build_time_min, breaks = k)) %>%
  count(clase, name = "fa") %>%              # fa = frecuencia absoluta
  mutate(
    fr  = round(fa / sum(fa), 3),            # fr = frecuencia relativa
    fac = cumsum(fa)                         # fac = frecuencia acumulada
  )

print(tabla)

# ---- 4. Clase modal ------------------------------------------------
# Es la clase con mayor frecuencia absoluta (la barra mas alta).
modal <- tabla %>% filter(fa == max(fa))
cat("\nClase modal:\n")
print(modal)
