USE Olimpicos
GO

/*
Carmelo
Rankings de países, por medallas en distintos deportes/categorías, posiblemente agregados por regiones
*/

CREATE PROCEDURE sp_ranking_pais (@pais INT = NULL) 
AS
BEGIN
	SELECT 
		p.nombre [Nombre], 
		COUNT(p.idPais) [Medallas], 
		STRING_AGG((CASE WHEN med.oro = 1 THEN 'Oro' WHEN med.plata = 1 THEN 'Plata' WHEN med.bronce = 1 THEN 'Bronce' END), ', ') [Tipo de medalla],
		STRING_AGG(cat.nombre, ', ')  [Categorias],   
		STRING_AGG(dep.nombre, ', ')  [Deporte]   
	FROM Competidor comp
	INNER JOIN MedallaCompetidor mc ON mc.idCompetidor = comp.idCompetidor
	INNER JOIN Medalla med ON mc.idMedalla = med.idMedalla
	INNER JOIN Pais p ON p.idPais = comp.idPais
	LEFT JOIN CategoriaCompetidor catc  ON catc.idCompetidor = comp.idCompetidor
	LEFT JOIN EquipoCompetidor eqc  ON eqc.idCompetidor = comp.idCompetidor
	INNER JOIN Categoria cat ON cat.idCategoria = catc.idCategoria
	INNER JOIN Deporte dep ON dep.idDeporte = cat.idDeporte
	GROUP BY p.idPais, p.nombre
	ORDER BY medallas DESC
	PRINT('Rankings de países')
END