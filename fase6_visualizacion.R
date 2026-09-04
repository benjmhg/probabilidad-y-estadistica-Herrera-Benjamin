# =====================================================================
# LAB 3 · FASE 6 — Visualizacion
# Autor: Benjamin Herrera
# =====================================================================
library(tidyverse)
df <- read_csv("devops_metrics_clean.csv")

# 1) Histograma: distribucion de build_time_min
ggplot(df, aes(build_time_min)) +
  geom_histogram(bins = 14, fill = "steelblue", color = "white") +
  labs(title = "Histograma de build_time_min", x = "Minutos", y = "Frecuencia")
ggsave("hist_build.png", width = 6, height = 4)

# 2) Boxplot: build_time_min por equipo (compara grupos y muestra outliers)
ggplot(df, aes(team, build_time_min)) +
  geom_boxplot(fill = "steelblue") +
  labs(title = "Build time por equipo", x = "Equipo", y = "Minutos")
ggsave("box_build_team.png", width = 6, height = 4)

# 3) Barras: cantidad de despliegues por prioridad
ggplot(df, aes(priority)) +
  geom_bar(fill = "steelblue") +
  labs(title = "Frecuencia por prioridad", x = "Prioridad", y = "Casos")
ggsave("barras_priority.png", width = 6, height = 4)

# 4) Dispersion: commit_size_loc vs num_bugs (la correlacion 0.42)
ggplot(df, aes(commit_size_loc, num_bugs)) +
  geom_point(alpha = 0.2, color = "steelblue") +
  labs(title = "Commit size vs bugs", x = "Lineas de codigo", y = "Bugs")
ggsave("disp_commit_bugs.png", width = 6, height = 4)
