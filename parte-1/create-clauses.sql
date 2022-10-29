CREATE DATABASE Olimpicos

USE Olimpicos
GO

--Tables without FK
CREATE TABLE Pais(
	idPais INT IDENTITY PRIMARY KEY,
	nombre VARCHAR(25)
);


CREATE TABLE Deporte(
	idDeporte INT IDENTITY PRIMARY KEY,
	nombre VARCHAR(25)
);

CREATE TABLE TipoMarca(
	idTipo INT IDENTITY PRIMARY KEY,
	nombre VARCHAR(25),
	denominacion VARCHAR(25)
);

CREATE TABLE Medalla(
	idMedalla INT IDENTITY PRIMARY KEY,
	oro BIT,
	plata BIT,
	bronce BIT
);


--Tables with FK
CREATE TABLE Competidor(
	idCompetidor INT IDENTITY PRIMARY KEY,
	nombre VARCHAR(25),
	dpi VARCHAR(25),
	fecha_nacimiento DATETIME,
	idPais INT FOREIGN KEY REFERENCES Pais(idPais)
);

CREATE TABLE Equipo(
	idEquipo INT IDENTITY PRIMARY KEY,
	nombre VARCHAR(25),
	idPais INT FOREIGN KEY REFERENCES Pais(idPais)
);

CREATE TABLE Categoria(
	idCategoria INT IDENTITY PRIMARY KEY,
	nombre VARCHAR(25),
	idTipo INT FOREIGN KEY REFERENCES TipoMarca(idTipo),
	idDeporte INT FOREIGN KEY REFERENCES Deporte(idDeporte)
);

CREATE TABLE CategoriaCompetidor(
	idCategoria INT FOREIGN KEY REFERENCES Categoria(idCategoria),
	idCompetidor INT FOREIGN KEY REFERENCES Competidor(idCompetidor)
);

CREATE TABLE CategoriaEquipo(
	idCategoria INT FOREIGN KEY REFERENCES Categoria(idCategoria),
	idEquipo INT FOREIGN KEY REFERENCES Equipo(idEquipo)
);

CREATE TABLE Marca(
	idMarca INT IDENTITY PRIMARY KEY,
	puntaje DECIMAL(12,8) NULL,
	idCompetidor INT FOREIGN KEY REFERENCES Competidor(idCompetidor)
);

CREATE TABLE EquipoCompetidor(
	idEquipo INT FOREIGN KEY REFERENCES Equipo(idEquipo),
	idCompetidor INT FOREIGN KEY REFERENCES Competidor(idCompetidor)
);

CREATE TABLE MedallaCompetidor(
	idMedalla INT FOREIGN KEY REFERENCES Medalla(idMedalla),
	idCompetidor INT FOREIGN KEY REFERENCES Competidor(idCompetidor)
);





