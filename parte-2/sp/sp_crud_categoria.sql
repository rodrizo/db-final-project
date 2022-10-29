USE [Olimpicos]
GO
/*
Carmelo
Funcionalidad: SP para realizar CRUD de Categoria
*/
CREATE PROCEDURE sp_crud_categoria
   @action VARCHAR(3) = NULL,
   @idCategoria INT = NULL,
   @nombre VARCHAR(25) = NULL,
   @idTipo INT = NULL,
   @idDeporte INT = NULL
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@action = 'C') --Create
	BEGIN
		INSERT INTO Categoria VALUES(@nombre, @idTipo , @idDeporte)
	END
	
	IF (@action = 'R') --Read
	BEGIN
		SELECT cat.idCategoria [Id], cat.nombre [Nombre], tm.nombre [Tipo], dep.nombre[Deporte]
		FROM Categoria cat WITH(NOLOCK) 
		INNER JOIN TipoMarca tm WITH(NOLOCK) ON tm.idTipo = cat.idTipo
		INNER JOIN Deporte dep WITH(NOLOCK) ON dep.idDeporte = cat.idDeporte
	END
	
	IF (@action = 'U') --Update
	BEGIN
		UPDATE Categoria
		SET nombre = @nombre, idTipo = @idTipo, idDeporte = @idDeporte
		WHERE idCategoria = @idCategoria
	END
	
	IF (@action = 'D') --DELETE
	BEGIN
		DELETE Categoria where idCategoria = @idCategoria 
	END
END