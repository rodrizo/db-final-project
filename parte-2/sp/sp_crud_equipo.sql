USE [Olimpicos]
GO
/*
Creador: Rodney Rizo
Funcionalidad: SP para realizar CRUD de Equipo
*/
CREATE PROCEDURE sp_crud_equipo
   @action VARCHAR(3) = NULL,
   @idEquipo INT = NULL,
   @nombre VARCHAR(25) = NULL,
   @idPais INT = NULL
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@action = 'C') --Create
	BEGIN
		INSERT INTO Equipo VALUES(@nombre, @idPais)
	END
	
	IF (@action = 'R') --Read
	BEGIN
		SELECT eq.idEquipo [Id], eq.nombre [Nombre], p.nombre [Pais]  
		FROM Equipo eq WITH(NOLOCK)  
		INNER JOIN Pais p WITH(NOLOCK) ON p.idPais = eq.idPais
	END
	
	IF (@action = 'U') --Update
	BEGIN
		UPDATE Equipo
		SET nombre = @nombre, idPais = @idPais
		WHERE idEquipo = @idEquipo
	END
	
	IF (@action = 'D') --DELETE
	BEGIN
		DELETE Equipo where idEquipo = @idEquipo 
	END
END