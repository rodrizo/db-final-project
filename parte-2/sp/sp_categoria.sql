USE [Olimpicos]
GO

/*
Creador: Rodney Rizo
Funcionalidad: SP para retornar información de categorías según distintas opciones
*/
CREATE PROCEDURE sp_categorias (@categoria INT = NULL, @option SMALLINT = NULL)
AS
BEGIN
	SET NOCOUNT ON;

	IF @option = 1
	BEGIN
		--Países participantes en esa categoría
		SELECT p.nombre [Paises participantes]
		FROM Competidor comp WITH(NOLOCK)
		LEFT JOIN CategoriaCompetidor catc WITH(NOLOCK) ON catc.idCompetidor = comp.idCompetidor
		LEFT JOIN Categoria cat WITH(NOLOCK) ON cat.idCategoria = catc.idCategoria
		LEFT JOIN EquipoCompetidor eqc WITH(NOLOCK) ON eqc.idCompetidor = comp.idCompetidor
		LEFT JOIN Equipo eq WITH(NOLOCK) ON eq.idEquipo = eqc.idEquipo
		INNER JOIN Pais p WITH(NOLOCK) ON p.idPais = comp.idPais
			AND cat.idCategoria = ISNULL(@categoria, cat.idCategoria)
		GROUP BY p.nombre
		ORDER BY p.nombre ASC
		
		PRINT('Países participantes en esta categoría')
	END

	
	IF @option = 2
	BEGIN
		--Deportistas y equipos participantes
		SELECT STRING_AGG(ISNULL(comp.nombre, ''), ', ') [Deportistas], STRING_AGG(ISNULL(eq.nombre, ''), ', ') [Equipos]
		FROM Competidor comp WITH(NOLOCK)
		LEFT JOIN CategoriaCompetidor catc WITH(NOLOCK) ON catc.idCompetidor = comp.idCompetidor
		LEFT JOIN EquipoCompetidor eqc WITH(NOLOCK) ON eqc.idCompetidor = comp.idCompetidor
		LEFT JOIN Equipo eq WITH(NOLOCK) ON eq.idEquipo = eqc.idEquipo
		LEFT JOIN Categoria cat WITH(NOLOCK) ON cat.idCategoria = catc.idCategoria
		INNER JOIN Deporte dep WITH(NOLOCK) ON dep.idDeporte = cat.idDeporte
			AND cat.idCategoria = ISNULL(@categoria, cat.idCategoria)

		PRINT('Deportistas participantes en esta categoría')
	END

		IF @option = 3
	BEGIN
		--Ranking de países participantes y medallas obtenidas
		SELECT 
			p.nombre [Pais],
			COUNT(p.idPais) [Cantidad de medallas],
			STRING_AGG((CASE WHEN med.oro = 1 THEN 'Oro' WHEN med.plata = 1 THEN 'Plata' WHEN med.bronce = 1 THEN 'Bronce' END), ', ') [Tipo de medalla]
		FROM Competidor comp WITH(NOLOCK) 
		INNER JOIN MedallaCompetidor mc WITH(NOLOCK) ON mc.idCompetidor = comp.idCompetidor
		INNER JOIN Medalla med WITH(NOLOCK) ON mc.idMedalla = med.idMedalla
		INNER JOIN Pais p WITH(NOLOCK) ON p.idPais = comp.idPais
		INNER JOIN CategoriaCompetidor catc WITH(NOLOCK) ON catc.idCompetidor = comp.idCompetidor
		INNER JOIN Categoria cat WITH(NOLOCK) ON cat.idCategoria = catc.idCategoria
		INNER JOIN Deporte dep WITH(NOLOCK) ON dep.idDeporte = cat.idDeporte
			AND cat.idCategoria = ISNULL(@categoria, cat.idCategoria)
		GROUP BY p.nombre, p.idPais 
		ORDER BY [Cantidad de medallas] DESC

		PRINT('Ranking de países y medallas obtenidas en esta categoría')
	END
END