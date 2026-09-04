# =====================================================================
# LAB 3 · FASE 5 — Relaciones bivariadas
# Proyecto: Analisis de metricas de software y DevOps
# Autor: Benjamin Herrera
# =====================================================================

library(tidyverse)

# ---- 1. Cargar el dataset limpio -----------------------------------
df <- read_csv("devops_metrics_clean.csv")

# ---- 2. Correlacion entre variables NUMERICAS ----------------------
# La correlacion mide si dos variables numericas se mueven juntas.
# Va de -1 (opuestas) a 1 (juntas); 0 = sin relacion lineal.
numericas <- df %>%
  select(build_time_min, deploy_time_min, commit_size_loc,
         num_bugs, test_coverage_pct, ticket_resolution_h)

# use = "complete.obs" -> ignora los faltantes que decidimos conservar
matriz_cor <- cor(numericas, use = "complete.obs")
cat("=== Matriz de correlacion ===\n")
print(round(matriz_cor, 2))

# Las dos relaciones mas fuertes (por si quieres resaltarlas)
cat("\ncommit_size_loc vs num_bugs :",
    round(cor(df$commit_size_loc, df$num_bugs, use = "complete.obs"), 2), "\n")
cat("test_coverage_pct vs num_bugs:",
    round(cor(df$test_coverage_pct, df$num_bugs, use = "complete.obs"), 2), "\n")

# ---- 3. Tabla de contingencia entre variables CUALITATIVAS ---------
# Cruza dos categorias y cuenta cuantos casos hay en cada combinacion.
cat("\n=== Tabla de contingencia: equipo x estado del deploy ===\n")
print(table(df$team, df$deploy_status))
