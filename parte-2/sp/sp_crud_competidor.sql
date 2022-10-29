USE [Olimpicos]
GO

/*
Creador: Rodney Rizo
Funcionalidad: SP para realizar CRUD de Competidores
*/
CREATE PROCEDURE sp_crud_competidor (
	@action VARCHAR(3) = NULL, 
	@idCompetidor INT = NULL, 
	@nombre VARCHAR(25) = NULL, 
	@dpi VARCHAR(25) = NULL,
	@fecha_nacimiento DATETIME = NULL,
	@idPais INT = NULL
)
AS
BEGIN
	SET NOCOUNT ON;

	IF (@action = 'C') --Create
	BEGIN
		INSERT INTO Competidor VALUES(@nombre, @dpi, @fecha_nacimiento, @idPais)
	END
	IF (@action = 'R') --Read
	BEGIN
		SELECT comp.idCompetidor [Id] ,comp.nombre [Nombre], comp.dpi [DPI], CAST(comp.fecha_nacimiento AS DATE) [Fecha de nacimiento], p.nombre [Pais]  
		FROM Competidor comp WITH(NOLOCK)  
		INNER JOIN Pais p WITH(NOLOCK) ON p.idPais = comp.idPais
	END
	IF (@action = 'U') --Update
	BEGIN
		UPDATE Competidor 
		SET nombre = @nombre, dpi = @dpi, fecha_nacimiento = @fecha_nacimiento, idPais = @idPais
		WHERE idCompetidor = @idCompetidor
	END
	IF (@action = 'D') --Delete
	BEGIN
		DELETE Competidor WHERE idCompetidor = @idCompetidor
	END
END