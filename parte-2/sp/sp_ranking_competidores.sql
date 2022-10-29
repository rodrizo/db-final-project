USE Olimpicos
GO

/* 
Creador: Wilson Morales
Ranking de Medallas por competidor por deporte/categoria
*/

CREATE PROCEDURE sp_ranking_competidor (@competidor INT = NULL)
AS
BEGIN
SELECT com.nombre as Nombre,
	COUNT(com.idCompetidor) [Medallas],
		STRING_AGG((
		CASE
			WHEN med.oro = 1 THEN 'Oro'
			WHEN med.plata = 1 THEN 'Plata'
			WHEN med.bronce = 1 THEN 'Bronce'
		END),',')[Tipo Medalla],
		STRING_AGG(dep.nombre,',') as Deporte,
		STRING_AGG(cat.nombre,',') as Categoria
	FROM Competidor com
	INNER JOIN MedallaCompetidor mc WITH(NOLOCK) ON mc.idCompetidor = com.idCompetidor
	INNER JOIN Medalla med WITH(NOLOCK) ON mc.idMedalla = med.idMedalla
	INNER JOIN CategoriaCompetidor cc WITH(NOLOCK) ON cc.idCompetidor = com.idCompetidor
	INNER JOIN Categoria cat WITH(NOLOCK) ON cc.idCategoria = Cat.idCategoria
	INNER JOIN Deporte dep WITH(NOLOCK) ON cat.idDeporte = dep.idDeporte
	GROUP BY com.nombre 
	ORDER BY Medallas DESC

END
--EXEC sp_raking_competidor 1

