USE [Olimpicos]
GO

/*
Creador: Rodney Rizo
Funcionalidad: SP para retornar información de países según distintas opciones
*/
CREATE PROCEDURE [dbo].[sp_paises](@pais INT = NULL, @option SMALLINT = NULL)
AS
BEGIN
	SET NOCOUNT ON;

	IF @option = 1
	BEGIN
		--Cuántas medallas (y tipo) y en qué deporte o categoría ha ganado
		SELECT 
			COUNT(p.idPais) [Cantidad de medallas], 
			p.nombre [Pais],
			STRING_AGG((CASE WHEN med.oro = 1 THEN 'Oro' WHEN med.plata = 1 THEN 'Plata' WHEN med.bronce = 1 THEN 'Bronce' END), ', ') [Tipo de medalla],
			STRING_AGG(cat.nombre, ', ')  [Categorias]
		FROM Competidor comp WITH(NOLOCK) 
		INNER JOIN MedallaCompetidor mc WITH(NOLOCK) ON mc.idCompetidor = comp.idCompetidor
		INNER JOIN Medalla med WITH(NOLOCK) ON mc.idMedalla = med.idMedalla
		INNER JOIN Pais p WITH(NOLOCK) ON p.idPais = comp.idPais
		LEFT JOIN CategoriaCompetidor catc WITH(NOLOCK) ON catc.idCompetidor = comp.idCompetidor
		LEFT JOIN EquipoCompetidor eqc WITH(NOLOCK) ON eqc.idCompetidor = comp.idCompetidor
		INNER JOIN Categoria cat WITH(NOLOCK) ON cat.idCategoria = catc.idCategoria
			AND p.idPais = ISNULL(@pais, p.idPais) --Filtro de país
		GROUP BY p.idPais, p.nombre

		PRINT('Medallas y en qué deporte o categoría ha ganado')
	END

	IF @option = 2
	BEGIN
		--Cuáles deportes/categorias están asociados a él
		SELECT p.nombre [Pais], dep.nombre [Deporte], STRING_AGG(cat.nombre, ', ') [Categorias] 
		FROM Competidor comp WITH(NOLOCK)
		LEFT JOIN CategoriaCompetidor catc WITH(NOLOCK) ON catc.idCompetidor = comp.idCompetidor
		LEFT JOIN EquipoCompetidor eqc WITH(NOLOCK) ON eqc.idCompetidor = comp.idCompetidor
		INNER JOIN Pais p WITH(NOLOCK) ON p.idPais = comp.idPais
		INNER JOIN Categoria cat WITH(NOLOCK) ON cat.idCategoria = catc.idCategoria
		INNER JOIN Deporte dep WITH(NOLOCK) ON dep.idDeporte = cat.idDeporte
			AND p.idPais = ISNULL(@pais, p.idPais) --Filtro de país
		GROUP BY p.nombre, dep.nombre
		
		PRINT('Deportes y categorías asociados al país')
	END

	IF @option = 3
	BEGIN
		--Deportistas y equipos participantes
		SELECT p.nombre [Pais], STRING_AGG(comp.nombre, ', ') [Deportistas], STRING_AGG(ISNULL(eq.nombre, ''), ', ') [Equipos] 
		FROM Competidor comp WITH(NOLOCK)
		LEFT JOIN CategoriaCompetidor catc WITH(NOLOCK) ON catc.idCompetidor = comp.idCompetidor
		LEFT JOIN CategoriaEquipo cate WITH(NOLOCK) ON cate.idCategoria = catc.idCategoria
		LEFT JOIN Equipo eq WITH(NOLOCK) ON eq.idEquipo = cate.idEquipo
		INNER JOIN Pais p WITH(NOLOCK) ON p.idPais = comp.idPais
			AND p.idPais = ISNULL(@pais, p.idPais) --Filtro de país
		GROUP BY p.idPais, p.nombre

		PRINT('Deportistas y equipos participantes')
	END


END