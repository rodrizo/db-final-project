

-- INSERCIÓN DE DATOS 
INSERT INTO Pais VALUES ('Guatemala');
INSERT INTO Pais VALUES ('Dinamarca');
INSERT INTO Pais VALUES ('Argentina');
INSERT INTO Pais VALUES ('Alemania');
INSERT INTO Pais VALUES ('Brasil');
INSERT INTO Pais VALUES ('Belgica');
INSERT INTO Pais VALUES ('Nicaragua');
--SELECT * FROM Pais

INSERT INTO Deporte VALUES ('Natación');
INSERT INTO Deporte VALUES ('Atletismo');
INSERT INTO Deporte VALUES ('Fútbol');
INSERT INTO Deporte VALUES ('Baloncesto');
INSERT INTO Deporte VALUES ('Tenis');
INSERT INTO Deporte VALUES ('Ciclismo');
--SELECT * FROM Deporte

INSERT INTO TipoMarca VALUES ('Altura', 'mts');
INSERT INTO TipoMarca VALUES ('Tiempo', 'min');
INSERT INTO TipoMarca VALUES ('Distancia', 'km');
INSERT INTO TipoMarca VALUES ('Puntos', 'pts');
INSERT INTO TipoMarca VALUES ('Velocidad', 'km/h');
--SELECT * FROM TipoMarca;

INSERT INTO Medalla VALUES (1,0,0);
INSERT INTO Medalla VALUES (0,1,0);
INSERT INTO Medalla VALUES (0,0,1);
--SELECT * FROM Medalla;

INSERT INTO Competidor VALUES ('Diana Gutierrez', '1390-20-1842', '2002-07-21', 1);
INSERT INTO Competidor VALUES ('Julio Perez', '1390-00-1231', '2002-07-21', 1);
INSERT INTO Competidor VALUES ('Mario Perez', '1390-54-1234', '1999-01-12', 1);
INSERT INTO Competidor VALUES ('Carmelo Mendoza', '1390-20-0000', '2001-11-11', 2);
INSERT INTO Competidor VALUES ('Juan Perez', '1390-20-18170', '2002-01-01', 2);
INSERT INTO Competidor VALUES ('Wilson Morales', '1390-20-18170', '2002-05-16', 3);
INSERT INTO Competidor VALUES ('Lionel Messi', '1390-20-1234', '2000-10-12', 4);
INSERT INTO Competidor VALUES ('Rodney Rizo', '1390-20-0000', '2001-08-31', 7);
INSERT INTO Competidor VALUES ('Pedro Perez', '1390-54-1234', '1999-01-12', 7);
INSERT INTO Competidor VALUES ('Xavi Hernandez', '000', '1999-01-15', NULL);
--SELECT * FROM Competidor; 

INSERT INTO Equipo VALUES ('Equipo de Voleibol',1);
INSERT INTO Equipo VALUES ('Equipo de Futbol',2);
INSERT INTO Equipo VALUES ('Equipos de Atletismo',3);
INSERT INTO Equipo VALUES ('Equipo de Natacion',4);
INSERT INTO Equipo VALUES ('Equipo de Ciclismo',5);
INSERT INTO Equipo VALUES ('Equipo de Billar',7);
--SELECT * FROM Equipo

INSERT INTO Categoria VALUES ('100 mts planos', 5, 3);
INSERT INTO Categoria VALUES ('Valla', 1, 3);
INSERT INTO Categoria VALUES ('Libre', 1, 3);
INSERT INTO Categoria VALUES ('Espalda', 2, 4);
INSERT INTO Categoria VALUES ('Pool 8', 4, 6);
--SELECT * FROM Categoria


INSERT INTO CategoriaCompetidor VALUES (1, 1);
INSERT INTO CategoriaCompetidor VALUES (1, 2);
INSERT INTO CategoriaCompetidor VALUES (1, 4);
INSERT INTO CategoriaCompetidor VALUES (2, 3);
INSERT INTO CategoriaCompetidor VALUES (2, 5);
INSERT INTO CategoriaCompetidor VALUES (3, 6);
INSERT INTO CategoriaCompetidor VALUES (3, 7);
INSERT INTO CategoriaCompetidor VALUES (5, 8);
--SELECT * FROM CategoriaCompetidor


INSERT INTO CategoriaEquipo VALUES (1, 3);
INSERT INTO CategoriaEquipo VALUES (2, 3);
INSERT INTO CategoriaEquipo VALUES (3, 3);
INSERT INTO CategoriaEquipo VALUES (4, 4);
INSERT INTO CategoriaEquipo VALUES (5, 6);
--SELECT * FROM CategoriaEquipo

INSERT INTO Marca VALUES (21.3, 1);
INSERT INTO Marca VALUES (10.4, 2);
INSERT INTO Marca VALUES (23.2, 4);
INSERT INTO Marca VALUES (25.2, 3);
INSERT INTO Marca VALUES (30, 5);
--SELECT * FROM Marca

INSERT INTO EquipoCompetidor VALUES (2, 7);
INSERT INTO EquipoCompetidor VALUES (2, 10);
INSERT INTO EquipoCompetidor VALUES (3, 1);
INSERT INTO EquipoCompetidor VALUES (3, 2);
INSERT INTO EquipoCompetidor VALUES (3, 3);
INSERT INTO EquipoCompetidor VALUES (3, 4);
INSERT INTO EquipoCompetidor VALUES (4, 9);
INSERT INTO EquipoCompetidor VALUES (6, 8);
--SELECT * FROM EquipoCompetidor

INSERT INTO MedallaCompetidor VALUES (1, 1);
INSERT INTO MedallaCompetidor VALUES (1, 8);
INSERT INTO MedallaCompetidor VALUES (1, 4);
INSERT INTO MedallaCompetidor VALUES (1, 6);
INSERT INTO MedallaCompetidor VALUES (2, 2);
INSERT INTO MedallaCompetidor VALUES (2, 3);
INSERT INTO MedallaCompetidor VALUES (3, 7);
--SELECT * FROM MedallaCompetidor


--DBCC CHECKIDENT ('Medalla', RESEED, 0);