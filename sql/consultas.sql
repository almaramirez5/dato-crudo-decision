
-- CONSULTA 1: Desempleo medio por grupo de edad
SELECT 
    age_group,
    COUNT(*) as num_registros,
    ROUND(AVG(unemployment_rate), 2) as tasa_media,
    ROUND(MIN(unemployment_rate), 2) as tasa_minima,
    ROUND(MAX(unemployment_rate), 2) as tasa_maxima
FROM desempleo
WHERE sex = 'Total'
GROUP BY age_group
ORDER BY tasa_media DESC;

-- CONSULTA 2: Brecha de género en jóvenes
SELECT 
    age_group,
    sex,
    COUNT(*) as num_años,
    ROUND(AVG(unemployment_rate), 2) as tasa_media
FROM desempleo
WHERE age_group = 'Jóvenes (15-24)'
GROUP BY age_group, sex
ORDER BY tasa_media DESC;

-- CONSULTA 3: Impacto COVID-19
SELECT 
    year,
    sex,
    ROUND(unemployment_rate, 2) as tasa_desempleo
FROM desempleo
WHERE age_group = 'Jóvenes (15-24)'
ORDER BY unemployment_rate DESC
LIMIT 10;

-- CONSULTA 4: Clasificación de riesgo (JOIN)
SELECT 
    d.age_group,
    c.descripcion,
    c.es_vulnerable,
    COUNT(*) as num_años,
    ROUND(AVG(d.unemployment_rate), 2) as tasa_media,
    CASE 
        WHEN AVG(d.unemployment_rate) > 30 THEN 'CRÍTICO'
        WHEN AVG(d.unemployment_rate) > 15 THEN 'ALTO'
        WHEN AVG(d.unemployment_rate) > 8 THEN 'MEDIO'
        ELSE 'BAJO'
    END as nivel_riesgo
FROM desempleo d
JOIN contexto c ON d.age_group = c.age_group
WHERE d.sex = 'Total'
GROUP BY d.age_group, c.descripcion, c.es_vulnerable
ORDER BY tasa_media DESC;
