# =====================================================================
# LAB 3 · FASE 2 — Descriptiva univariada
# Proyecto: Analisis de metricas de software y DevOps
# Autor: Benjamin Herrera
# =====================================================================

# La primera vez, instala 'moments' (solo una vez):
# install.packages("moments")
library(tidyverse)
library(moments)   # para asimetria (skewness) y curtosis (kurtosis)

# ---- 1. Cargar el dataset ya limpio de la Fase 1 -------------------
df <- read_csv("devops_metrics_clean.csv")

# ---- 2. Funcion que describe una variable numerica -----------------
# Calcula las tres familias que pide el profe:
#   - tendencia central: media, mediana
#   - dispersion: desviacion estandar, coef. de variacion, rango intercuartilico
#   - forma: asimetria y curtosis
# Usamos na.rm = TRUE porque en la Fase 1 decidimos CONSERVAR los faltantes.
describir <- function(x) {
  tibble(
    media     = mean(x, na.rm = TRUE),
    mediana   = median(x, na.rm = TRUE),
    desv_est  = sd(x, na.rm = TRUE),
    coef_var  = sd(x, na.rm = TRUE) / mean(x, na.rm = TRUE),
    rango_iq  = IQR(x, na.rm = TRUE),
    asimetria = skewness(x, na.rm = TRUE),
    curtosis  = kurtosis(x, na.rm = TRUE)
  )
}

# ---- 3. Aplicar la funcion a cada variable numerica ----------------
numericas <- c("build_time_min", "deploy_time_min", "commit_size_loc",
               "num_bugs", "test_coverage_pct", "ticket_resolution_h")

resumen <- bind_rows(
  describir(df$build_time_min),
  describir(df$deploy_time_min),
  describir(df$commit_size_loc),
  describir(df$num_bugs),
  describir(df$test_coverage_pct),
  describir(df$ticket_resolution_h)
) %>%
  mutate(variable = numericas, .before = 1) %>%
  mutate(across(where(is.numeric), ~round(.x, 2)))

# ---- 4. Mostrar la tabla resumen -----------------------------------
print(resumen)
