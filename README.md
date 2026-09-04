# Lab 3 · Análisis de métricas de software y DevOps

Proyecto integrador del curso **Probabilidad y Estadística Computacional**.
Análisis estadístico descriptivo en **R** sobre un histórico de métricas de DevOps.

**Autor:** Benjamín Herrera
**Lenguaje:** R · **Modalidad:** individual

---

## Descripción

Se analiza el archivo `devops_metrics.csv` (~5.000 eventos de integración/despliegue,
11 variables). El trabajo cubre las 7 fases del análisis descriptivo: carga y limpieza,
descripción univariada, frecuencias, comparación por grupos, relaciones bivariadas,
visualización y un reporte reproducible. Todo el flujo se puede regenerar de principio a fin.

## Requisitos

- R (≥ 4.2) y RStudio
- Paquetes: `tidyverse`, `moments`, `rmarkdown`, `knitr`

Instalación (una sola vez):

```r
install.packages(c("tidyverse", "moments", "rmarkdown", "knitr"))
```

## Estructura del repositorio

| Archivo | Contenido |
|---|---|
| `devops_metrics.csv` | Datos crudos (entrada) |
| `devops_metrics_clean.csv` | Datos limpios (lo genera la Fase 1) |
| `fase1_carga_limpieza.R` | Carga, inspección y limpieza |
| `fase2_descriptiva.R` | Descriptiva univariada (media, dispersión, forma) |
| `fase3_frecuencias.R` | Tabla de frecuencias y regla de Sturges |
| `fase4_grupos.R` | Comparación por equipo, prioridad y módulo |
| `fase5_bivariado.R` | Correlaciones y tabla de contingencia |
| `fase6_visualizacion.R` | Histograma, boxplot, barras y dispersión |
| `reporte.Rmd` | Reporte reproducible (Fase 7) |
| `README.md` | Este archivo |

## Cómo ejecutar

1. Abrir el proyecto en RStudio (o fijar la carpeta con `setwd("ruta/del/proyecto")`).
2. Correr los scripts **en orden**, empezando por la Fase 1:

   ```r
   source("fase1_carga_limpieza.R")   # genera metricas_limpias.csv
   source("fase2_descriptiva.R")
   source("fase3_frecuencias.R")
   source("fase4_grupos.R")
   source("fase5_bivariado.R")
   source("fase6_visualizacion.R")    # genera los .png de los gráficos
   ```

   > La Fase 1 debe correrse primero: crea `devops_metrics_clean.csv`, que usan todas las demás.

3. Para el reporte final: abrir `reporte.Rmd` en RStudio y presionar **Knit** (salida HTML o PDF).

## Resumen de las fases

1. **Carga y limpieza** — duplicados, tipos, valores imposibles y faltantes.
2. **Descriptiva univariada** — tendencia central, dispersión y forma (asimetría, curtosis).
3. **Frecuencias y agrupación** — frecuencia absoluta, relativa y acumulada; clases con Sturges.
4. **Análisis por grupos** — comparación de métricas entre equipos, módulos y prioridades.
5. **Relaciones bivariadas** — correlaciones y tabla de contingencia.
6. **Visualización** — histograma, boxplot, barras y dispersión.
7. **Reporte reproducible** — todo integrado en `reporte.Rmd`.

## Decisiones de análisis

- Los **valores faltantes se conservan** (no se imputan ni se eliminan) y cada
  estadístico se calcula con `na.rm = TRUE` (análisis de casos disponibles).
- Los **valores imposibles** de cobertura (fuera de 0–100 %) se marcan como `NA`.
- La variable `priority` se trata como **factor ordinal** (baja < media < alta < crítica).

## Bitácora de prompts (uso de IA)

La IA se usó como asistente, verificando y entendiendo cada resultado:

| # | Objetivo | Refinamiento | Verificación |
|---|---|---|---|
| 1 | Generar el dataset DevOps | Añadir faltantes, valores fuera de rango y duplicados | Tipos y rangos de las variables |
| 2 | Script de carga y limpieza | Usar funciones básicas y conservar los NA | Conteo de NA y duplicados |
| 3 | Descriptiva univariada | Dejar solo lo pedido, en español | Fórmulas de asimetría y curtosis |
| 4 | Tabla de frecuencias | Formato decimal y todas las clases | Clase modal |
| 5 | Grupos y correlaciones | Distinguir correlación de causalidad | Coincidencia con los hallazgos |
