USE [Olimpicos]
GO

/*
Creadora: Diana Gutiérrez
Funcionalidad: SP para realizar CRUD de Deporte
*/

CREATE PROCEDURE sp_crud_deporte (
		@action VARCHAR (3) = NULL,
		@idDeporte INT = NULL,
		@nombre VARCHAR (25) = NULL
	)
AS
BEGIN

SET NOCOUNT ON;

	IF (@action = 'C') --Create
	BEGIN
		INSERT INTO Deporte VALUES (@nombre)
	END
	IF (@action = 'R') --Read
	BEGIN
		SELECT dep.idDeporte [Id] ,dep.nombre [Nombre]
		FROM Deporte dep WITH(NOLOCK)  
		
	END
	IF (@action = 'U') --Update
	BEGIN
		UPDATE Deporte
		SET  nombre = @nombre
		WHERE idDeporte = @idDeporte
	END
	IF (@action = 'D') --Delete
	BEGIN
		DELETE Deporte WHERE idDeporte = @idDeporte
	END


END