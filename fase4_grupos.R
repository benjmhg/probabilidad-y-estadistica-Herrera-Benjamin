# =====================================================================
# LAB 3 · FASE 4 — Analisis por grupos
# Proyecto: Analisis de metricas de software y DevOps
# Autor: Benjamin Herrera
# =====================================================================

library(tidyverse)

# ---- 1. Cargar el dataset limpio -----------------------------------
df <- read_csv("devops_metrics_clean.csv")

# ---- 2. Comparacion por EQUIPO -------------------------------------
# Para cada grupo calculamos: cuantos hay, la mediana del build,
# el promedio de bugs y la tasa de despliegues fallidos.
por_equipo <- df %>%
  group_by(team) %>%
  summarise(
    n           = n(),
    build_md    = median(build_time_min, na.rm = TRUE),
    bugs_prom   = mean(num_bugs, na.rm = TRUE),
    tasa_fallos = mean(deploy_status == "failed")
  ) %>%
  mutate(across(where(is.numeric), ~round(.x, 3)))
cat("=== Por equipo ===\n"); print(por_equipo)

# ---- 3. Comparacion por PRIORIDAD ----------------------------------
por_prioridad <- df %>%
  group_by(priority) %>%
  summarise(
    n           = n(),
    build_md    = median(build_time_min, na.rm = TRUE),
    bugs_prom   = mean(num_bugs, na.rm = TRUE),
    tasa_fallos = mean(deploy_status == "failed")
  ) %>%
  mutate(across(where(is.numeric), ~round(.x, 3)))
cat("\n=== Por prioridad ===\n"); print(por_prioridad)

# ---- 4. Comparacion por MODULO -------------------------------------
por_modulo <- df %>%
  group_by(module) %>%
  summarise(
    n           = n(),
    build_md    = median(build_time_min, na.rm = TRUE),
    bugs_prom   = mean(num_bugs, na.rm = TRUE),
    tasa_fallos = mean(deploy_status == "failed")
  ) %>%
  mutate(across(where(is.numeric), ~round(.x, 3)))
cat("\n=== Por modulo ===\n"); print(por_modulo)
