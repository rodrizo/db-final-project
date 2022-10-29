USE [Olimpicos]
GO

/*
Creador: Wilson Morales
Funcionalidad: SP para mostrar datos relevantes, deporte/categoria, medallas
y equipos a los que pertenece un competidor
*/

CREATE PROCEDURE sp_competidores (@competidor INT = NULL, @option SMALLINT = NULL)
AS
BEGIN

	
	IF @option = 1
	--Datos Relevantes del Competidor
	BEGIN
		SELECT com.nombre as Nombre,
		com.dpi as Identificacion,
		com.fecha_nacimiento as Nacimiento,
		p.nombre as Pais
		FROM Competidor com WITH(NOLOCK)
		INNER JOIN Pais p WITH(NOLOCK) ON com.idPais = p.idPais
		AND com.idCompetidor = ISNULL(@competidor, com.idCompetidor)
	END

	IF @option = 2
	--Deporte y Categoria de un Competidor
	BEGIN 
		SELECT com.nombre as Nombre,
		STRING_AGG(cat.nombre, ', ') as Categoria,
		STRING_AGG(dep.nombre, ', ') as Deporte,
		STRING_AGG(CONVERT(Decimal(18,2),mar.puntaje), ', ') as Marca,
		STRING_AGG(tip.denominacion, ', ') as Denominacion
		FROM Competidor com WITH(NOLOCK)
		INNER JOIN CategoriaCompetidor cc WITH(NOLOCK) ON cc.idCompetidor = com.idCompetidor
		INNER JOIN Categoria cat WITH(NOLOCK) ON cc.idCategoria = Cat.idCategoria
		INNER JOIN Deporte dep WITH(NOLOCK) ON cat.idDeporte = dep.idDeporte
		INNER JOIN Marca mar WITH(NOLOCK) ON mar.idCompetidor=Com.idCompetidor
		INNER JOIN TipoMarca tip WITH(NOLOCK) ON tip.idTipo=cat.idTipo
			AND com.idCompetidor=ISNULL(@competidor, com.idCompetidor)
		GROUP BY com.nombre
	END 

	IF @option = 3
	--Medallas Obtenidas por Competidor
	BEGIN 
		SELECT 
			com.nombre as Nombre,
			COUNT(com.idCompetidor) [Medallas],
			STRING_AGG((
			CASE
				WHEN med.oro = 1 THEN 'Oro'
				WHEN med.plata = 1 THEN 'Plata'
				WHEN med.bronce = 1 THEN 'Bronce'
			END),',')[Tipo Medalla]
		FROM Competidor com WITH(NOLOCK)
		INNER JOIN MedallaCompetidor mc WITH(NOLOCK) ON mc.idCompetidor = com.idCompetidor
		INNER JOIN Medalla med WITH(NOLOCK) ON mc.idMedalla = med.idMedalla
			AND com.idCompetidor=ISNULL(@competidor, com.idCompetidor)
		GROUP BY com.nombre
	END

	IF @Option = 4
	--Equipos En los que participa el Competidor
	BEGIN 
		SELECT com.nombre as Nombre,
		STRING_AGG(e.nombre, ', ') as Equipo,
		p.nombre as Pais
		FROM Competidor com WITH(NOLOCK)
		INNER JOIN Pais p WITH(NOLOCK) ON com.idPais=p.idPais
		INNER JOIN EquipoCompetidor eq WITH(NOLOCK) ON eq.idCompetidor=com.idCompetidor
		INNER JOIN Equipo e WITH(NOLOCK) ON eq.idEquipo=e.idEquipo
			AND com.idCompetidor=ISNULL(@competidor, com.idCompetidor)
		GROUP BY com.nombre, p.nombre
	END
END

--EXEC sp_Competidores 1,4






