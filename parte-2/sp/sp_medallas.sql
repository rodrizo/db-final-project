USE [Olimpicos]
GO

/*
Creador: Rodney Rizo
Funcionalidad: SP para asignar medallas ya sea en competencias por equipos o medallas individuales
*/
CREATE PROCEDURE sp_medallas (@tipoMedalla SMALLINT = NULL, @option SMALLINT = NULL , @equipo INT = NULL, @competidor INT = NULL)
AS
BEGIN
	SET NOCOUNT ON;
	
	--@tipoMedalla ayudará a hacer el INSERT, se harán condiciones (oro = 1, plata = 2, bronce = 3) para asignar el tipo dinámicamente
	--Gold medal
	IF @tipoMedalla = 1
	BEGIN
		INSERT INTO Medalla VALUES(1, 0, 0)
	END

	--Silver medal
	IF @tipoMedalla = 2
	BEGIN
		INSERT INTO Medalla VALUES(0, 1, 0)
	END

	--Bronze medal
	IF @tipoMedalla = 3
	BEGIN
		INSERT INTO Medalla VALUES(0, 0, 1)
	END

	--Se obtiene el id de la última medalla creada en una variable
	DECLARE @lastId INT 
	EXEC @lastId = dbo.fn_getIdMedalla
	
	--Opción 1, asignar medallas por equipos
	IF @option = 1 
	BEGIN
		--Obtener todos los integrantes del equipo y asignarles la medalla creada
		INSERT INTO MedallaCompetidor(idMedalla, idCompetidor)
		SELECT @lastId, comp.idCompetidor
		FROM Competidor comp WITH(NOLOCK)
		INNER JOIN EquipoCompetidor eqc WITH(NOLOCK) ON eqc.idCompetidor = comp.idCompetidor
			AND eqc.idEquipo = ISNULL(@equipo, eqc.idEquipo)

		PRINT('Se le asignó la medalla a los jugadores')
	END

	--Opción 2, asignar medalla a un competidor
	IF @option = 2 
	BEGIN
		INSERT INTO MedallaCompetidor VALUES(@lastId, @competidor)
	END
END