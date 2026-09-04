# =====================================================================
# LAB 3 · FASE 1 — Carga y limpieza de datos
# Proyecto: Analisis de metricas de software y DevOps
# Autor: Benjamin Herrera
# =====================================================================

setwd("E:/Documents/probabilidad y estadistica")
df <- read_csv("devops_metrics.csv")

# ---- 1. Cargar el archivo ------------------------------------------
df <- read_csv("E:/Documents/probabilidad y estadistica/devops_metrics.csv")

# ---- 2. Inspeccionar como vienen los datos -------------------------
glimpse(df)          # tipo de cada variable
summary(df)          # rangos y valores extremos
colSums(is.na(df))   # cuantos faltantes (NA) hay por columna

# ---- 3. Eliminar filas duplicadas ----------------------------------
# Justificacion: filas repetidas exactas inflarian los conteos.
df <- distinct(df)

# ---- 4. Corregir la prioridad mal escrita --------------------------
# Viene como "Alta", " media", "CRITICA". La dejamos en minusculas y
# sin espacios para que quede una sola categoria por nivel.
df <- df %>%
  mutate(priority = trimws(tolower(priority)))

# ---- 5. Poner los tipos correctos (categoricas -> factor) ----------
# priority es ORDINAL, por eso lleva un orden explicito.
df <- df %>%
  mutate(
    priority      = factor(priority,
                           levels = c("baja", "media", "alta", "critica"),
                           ordered = TRUE),
    team          = as.factor(team),
    module        = as.factor(module),
    deploy_status = as.factor(deploy_status)
  )

# ---- 6. Corregir valores imposibles de cobertura -------------------
# La cobertura solo puede ir de 0 a 100. Lo que este fuera es un error
# de captura, asi que lo convertimos en faltante (NA).
df <- df %>%
  mutate(test_coverage_pct = ifelse(
    test_coverage_pct < 0 | test_coverage_pct > 100,
    NA, test_coverage_pct))

# ---- 7. Decision sobre los faltantes: CONSERVARLOS -----------------
# No imputamos ni eliminamos filas. Justificacion:
#  - Imputar (ej. con la mediana) inventaria datos y reduciria la
#    dispersion real de las variables.
#  - Eliminar la fila completa descartaria informacion valida de las
#    demas columnas de ese evento.
# Por eso conservamos los NA y en las fases siguientes calculamos cada
# estadistico sobre los datos disponibles usando na.rm = TRUE.
cat("\nFaltantes que se conservan por columna:\n")
print(colSums(is.na(df)))

# ---- 8. Resultado final --------------------------------------------
glimpse(df)

# Guardar el dataset limpio (con los faltantes conservados)
write_csv(df, "metricas_limpias.csv")
