# Del Dato Crudo a la Decisión
**Mini-proyecto Data Analytics: Desempleo Juvenil en España**

> Una experiencia completa del ciclo de datos: desde la carga hasta la decisión. Diseñado como recurso pedagógico para formadores y estudiantes de Data Analytics.

---

## ¿Qué es esto?

Un análisis completo del desempleo juvenil en España (2015-2025) que demuestra:
- Cómo **cargar y explorar** datos reales
- Cómo **limpiar y estructurar** información
- Cómo **hacer preguntas** con SQL
- Cómo **analizar estadísticamente** con rigor
- Cómo **comunicar resultados** a decisores
- Cómo **pensar críticamente** sobre datos

**Para quién:** Formadores y estudiantes de Data Analytics 

**Duración:** 90-120 minutos de clase

---

## Cómo ejecutar (5 min)

### Requisitos previos
- Python 3.9+
- Git
- 30 minutos libres

### Pasos

```bash
# 1. Clonar
git clone https://github.com/almaramirez5/dato-crudo-decision.git
cd dato-crudo-decision

# 2. Instalar dependencias
pip3 install -r requirements.txt

# 3. Abrir notebook
jupyter notebook notebook.ipynb

# 4. Ejecutar celda por celda (Shift + Enter)
```

**Eso es todo.** No hay más configuración.

---

## Qué encontrarás en este repositorio

data/
   ├── raw/        (datos originales bien archivados)
   └── processed/  (datos limpios, trazable)
sql/            (consultas documentadas)
visualizaciones/ (outputs organizados)
notebook.ipynb  # Análisis completo (START HERE)
.gitignore + LICENSE


---

## Descripción del Dataset

### Fuente
- **Eurostat** (Oficina Estadística de la UE)
- Desempleo por edad y sexo
- España, 2015-2025 (anual)

### Estructura
- **Dataset General:** Desempleo 15-74 años (población activa)
- **Dataset Juvenil:** Desempleo 15-24 años (primeros años laborales)

### Columnas finales

year → Año (2015-2025)
sex → Sexo (Mujer, Hombre, Total)
unemployment_rate → Tasa de desempleo (%)
age_group → Grupo de edad (General o Jóvenes)

---

## Qué hace el código, paso a paso

### SECCIÓN 1: Carga y Exploración (Celdas 1-4)

**Objetivo:** Familiaridad con los datos

```python
# Lo que ves:
df_general = pd.read_csv('data/raw/...')
df_general.head()  # Primeras filas
df_general.shape   # Tamaño
df_general.isnull().sum()  # ¿Qué falta?
```

**Qué aprenden:**
- Primer contacto con datos REALES (no limpios)
- Tipos de datos en Python
- Pensamiento crítico: "¿Estos datos son confiables?"
- Preguntas de negocio: "¿Por qué los jóvenes tienen más desempleo?"

**Tiempo:** 10 minutos

---

### SECCIÓN 2: Limpieza de Datos (Celdas 5-14)

**Objetivo:** Datos listos para análisis

```python
# Decisiones clave:
1. Columnas irrelevantes → Eliminadas
2. Nulos → Analizados y eliminados
3. Tipos de datos → Convertidos
4. Nombres → Estandarizados (Females → Mujer)
5. Outliers → Analizados (son reales, no errores)
```

**Qué aprenden:**
- Los datos REALES son sucios
- Cada decisión de limpieza tiene consecuencias
- Documentar el "por qué" es tan importante como el "cómo"
- Pérdida de datos ≠ Corrupción de datos

**Tabla antes/después:**

ANTES: 33 filas × 11 columnas (con columnas irrelevantes)
DESPUÉS: 66 filas × 4 columnas (limpio, combinado)
Nulos: 0 (eliminadas filas nulas)


**Tiempo:** 15 minutos

---

### SECCIÓN 3: SQL - Preguntas a Datos (Celdas 15-22)

**Objetivo:** Resolver preguntas de negocio con SQL

**4 Consultas:**

#### Consulta 1: Desempleo por edad (GROUP BY)
```sql
SELECT age_group, AVG(unemployment_rate) FROM desempleo GROUP BY age_group
```
**Pregunta:** ¿Cuál es el desempleo promedio por grupo?
**Respuesta:** Jóvenes 34.7%, Adultos 15.1%

#### Consulta 2: Brecha de género (GROUP BY múltiple)
```sql
SELECT sex, AVG(unemployment_rate) FROM desempleo 
WHERE age_group = 'Jóvenes (15-24)' GROUP BY sex
```
**Pregunta:** ¿Existe brecha de género en jóvenes?
**Respuesta:** Mujeres 35.1%, Hombres 34.3% (diferencia: 0.9pp, casi nula)

#### Consulta 3: Impacto COVID (WHERE + LIMIT)
```sql
SELECT year, unemployment_rate FROM desempleo 
WHERE age_group = 'Jóvenes (15-24)' 
ORDER BY unemployment_rate DESC LIMIT 10
```
**Pregunta:** ¿Cuál fue el pico histórico de desempleo juvenil?
**Respuesta:** 2015 (48.6%), no 2020. COVID subió +5.8pp

#### Consulta 4: Clasificación de riesgo (JOIN)
```sql
SELECT d.age_group, AVG(d.unemployment_rate), 
  CASE WHEN AVG(...) > 30 THEN 'CRÍTICO' ELSE 'ALTO' END
FROM desempleo d
JOIN contexto c ON d.age_group = c.age_group
GROUP BY d.age_group
```
**Pregunta:** ¿Cuál es el nivel de riesgo por grupo?
**Respuesta:** Jóvenes = CRÍTICO, Adultos = ALTO

**Qué aprenden:**
- SQL no es abstracto, resuelve PREGUNTAS reales
- GROUP BY agrupa y calcula
- WHERE filtra
- JOIN combina tablas
- LIMIT limita resultados

**Tiempo:** 20 minutos

---

### SECCIÓN 4: Análisis Estadístico (Celdas 23-25)

**Objetivo:** Interpretación rigurosa, NO sesgada

```python
# Estadística descriptiva
media, mediana, desv_std, min, max

# Test t-student
¿Diferencia = Azar o Realidad?
p-value < 0.05 → SIGNIFICATIVA
p-value >= 0.05 → Podría ser azar
```

**Qué aprenden:**
- La media NO es todo (desviación estándar importa)
- p-value NO es "probabilidad de ser verdad"
- p-value = "probabilidad de ver esto por azar"
- Diferencia ≠ Causalidad

**Hallazgo clave:**
- Jóvenes vs Adultos: **Diferencia significativa** (p < 0.05)
- Mujer vs Hombre en jóvenes: **Diferencia NO significativa** (p >= 0.05)

**Tiempo:** 15 minutos

---

### SECCIÓN 5: Visualizaciones (Celdas 26-29)

**Objetivo:** Comunicar con gráficos claros

#### Visualización 1: Línea temporal
- **Qué muestra:** Evolución 2015-2025
- **Por qué:** Historias necesitan contexto temporal
- **Quién:** Todos (es intuitiva)
- **Insight:** COVID fue un quiebre, pero 2015 fue peor

#### Visualización 2: Box plot
- **Qué muestra:** Distribución, rango, outliers
- **Por qué:** Variabilidad tan importante como media
- **Quién:** Técnicos, analistas
- **Insight:** Jóvenes tienen mucha más variabilidad

#### Visualización 3: Barras comparativas
- **Qué muestra:** Diferencia Hombre-Mujer en jóvenes
- **Por qué:** Conclusión específica
- **Quién:** Decisores, públicos generales
- **Insight:** Brecha de género es MÍNIMA, no es el problema

**Qué aprenden:**
- Cada gráfico = Una pregunta
- No sobrecargues con colores/formas
- Etiqueta valores (no hagas adivinar)
- Elige el tipo de gráfico correcto para la pregunta

**Tiempo:** 20 minutos

---

## Cómo usarlo en una clase real

Este proyecto es **Semana 1-2** del bootcamp:
- Demuestra todo el ciclo en pequeño
- Luego: proyectos más complejos
- Final: análisis real de empresa

---

## Qué puede salir mal (y cómo solucionarlo)

### Problema 1: "ModuleNotFoundError: No module named 'pandas'"
```bash
# Solución:
pip3 install -r requirements.txt
```

### Problema 2: "FileNotFoundError: data/raw/..."
```bash
# Verificar rutas:
ls data/raw/  # ¿Existen los CSV?

# Si no están:
# Descarga desde: https://ec.europa.eu/eurostat
```

### Problema 3: "SQL error: no such table 'desempleo'"
```python
# Asegúrate de ejecutar esta celda ANTES de SQL:
df_clean.to_sql('desempleo', conn, if_exists='replace', index=False)
```

### Problema 4: "Jupyter no reconoce cambios en archivo"
```bash
# Reinicia kernel:
# En VS Code: Ctrl+Shift+P → "Restart Kernel"
```

### Problema 5: "Los gráficos no se muestran"
```python
# Añade al principio del notebook:
%matplotlib inline
```

---

## Ideas para adaptar a diferentes niveles

### NIVEL 1: Principiantes (Sin experiencia)
**Duración:** 60 minutos
**Simplificación:**
- Solo Celdas 1-4 (Carga + Exploración)
- 1 consulta SQL simple (SELECT + WHERE)
- 1 gráfico (línea temporal)
- 2 conclusiones claras

**Objetivo:** "Entiendo cómo van datos → gráfico → decisión"

---

### NIVEL 2: Intermedio (Conocen Python básico)
**Duración:** 120 minutos
**Lo que hacemos:**
- Celdas 1-29 COMPLETO
- Código scaffold (rellena los huecos)
- Guía paso a paso

**Objetivo:** "Puedo hacer análisis completo solo"

---

### NIVEL 3: Avanzado (Conocen Python/SQL)
**Duración:** 180-240 minutos
**Aumento de complejidad:**
- Mismo proyecto pero con otro dataset (ellos eligen)
- Añadir regresión lineal (¿desempleo mejora con años?)
- Dashboard interactivo (Streamlit)
- Presentación formal (slides)

**Objetivo:** "Proyecto profesional, listo para portafolio"

---

## Preguntas de reflexión para facilitar en clase

Usadas para promover **pensamiento crítico**:

### Pregunta 1: Contexto
**"¿Por qué crees que los jóvenes tienen más desempleo?"**
- Respuestas esperadas: Falta de experiencia, discriminación, crisis
- Profundizar: ¿Es de verdad por edad o hay otros factores?
- Reflexión: Correlación ≠ Causalidad

### Pregunta 2: Datos
**"¿Qué datos nos FALTAN para tomar decisiones mejores?"**
- Respuestas esperadas: Educación, ubicación, habilidades, sector
- Profundizar: ¿El dato "limpio" es siempre completo?
- Reflexión: Siempre hay información que no vemos

### Pregunta 3: Acción
**"Si fueras el alcalde, ¿qué harías con estos datos?"**
- Respuestas esperadas: Subvenciones, formación, políticas públicas
- Profundizar: ¿Cuánto cuesta? ¿Quién lo paga? ¿Funciona?
- Reflexión: Toda decisión tiene trade-offs (coste, equidad, efectividad)

### Pregunta 4: Ética
**"¿A quién beneficia este análisis? ¿A quién le perjudica?"**
- Respuestas esperadas: Debate sobre impacto social
- Profundizar: ¿Invisibiliza a alguien? ¿Qué sesgos ves?
- Reflexión: Los datos son políticos, nunca neutrales

### Pregunta 5: Crítica
**"¿Qué está MAL en este análisis?"**
- Respuestas esperadas: Sesgos, limitaciones, asunciones falsas
- Profundizar: ¿Cómo lo mejorarías?
- Reflexión: El analista es responsable de la verdad

---

## Criterios de éxito para el estudiante

Después de esta actividad, el estudiante será capaz de:

- [ ] Cargar un CSV en Pandas sin documentación
- [ ] Hacer 5+ consultas SQL sin error
- [ ] Interpretar una distribución (media, mediana, IQR)
- [ ] Diferenciar "diferencia" de "diferencia significativa"
- [ ] Crear un gráfico que REVELE un patrón
- [ ] Contar una historia CON DATOS a una audiencia no técnica
- [ ] Identificar sesgos éticos en un análisis
- [ ] Hacer preguntas sobre datos (no solo responder)

**Evaluación:**
- Si logra ≥6/8 → ÉXITO

---

## Recursos adicionales para el docente

### Documentación oficial
- [Pandas docs](https://pandas.pydata.org/docs/)
- [SQLite tutorial](https://www.sqlite.org/lang.html)
- [Matplotlib](https://matplotlib.org/stable/gallery/index.html)

---

## Preguntas frecuentes

### "¿Cuándo ejecuto cada celda?"
Secuencialmente. El notebook está pensado para ejecutar de arriba a abajo.

### "¿Puedo saltarme la limpieza?"
No. Es la parte más importante pedagógicamente (datos reales son sucios).

### "¿Puedo usar otro dataset?"
Sí, pero elige uno con:
- Mínimo 100 filas
- 3-4 columnas relevantes
- Contexto social claro

### "¿Cuánto dura en total?"
- Primera vez: 120 minutos
- Veces siguientes: 60 minutos (ya dominas el flujo)

### "¿Se puede hacer online?"
Sí, exactamente igual. Comparte pantalla, ejecuta en vivo.

---

## Licencia

MIT License - Libre para usar, modificar, compartir (ver LICENSE)

---

## Autora

Alma Ramírez, creado para la prueba técnica: **Formador/a Data Analytics - Somos F5**

**Enero 2026**

*Último update: Sept 24, 2026*