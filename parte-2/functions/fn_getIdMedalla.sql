USE Olimpicos
GO
/*
Creador: Rodney Rizo
Funcionalidad: Funci�n para retornar el id de la �ltima medalla creada
*/
CREATE FUNCTION fn_getIdMedalla()
RETURNS INT AS
BEGIN
	DECLARE @Id INT

	--Getting the last created medal
	SELECT TOP 1 @Id = idMedalla FROM Medalla ORDER BY idMedalla DESC

	RETURN @Id;
END