DROP TABLE IF EXISTS Lager;
DROP TABLE IF EXISTS Bestilling;
DROP TABLE IF EXISTS Stoffrull;
DROP TABLE IF EXISTS SpesialStol;
DROP TABLE IF EXISTS StandardStol;
DROP TABLE IF EXISTS Ordre;
DROP TABLE IF EXISTS Stol;
DROP TABLE IF EXISTS Deltype;
DROP TABLE IF EXISTS Arbeidsstasjon;
DROP TABLE IF EXISTS Kunde;

CREATE TABLE Kunde (
    kundeId INT PRIMARY KEY AUTO_INCREMENT,
    navn VARCHAR(255) NOT NULL,
    adresse VARCHAR(255) NOT NULL
);

CREATE TABLE Ordre (
    ordreId INT PRIMARY KEY AUTO_INCREMENT,
    kundeId INT NOT NULL,
    ordreDato DATE NOT NULL,
    antattLevering DATE,
    reelLevering DATE,
    betalingsStatus VARCHAR(255),
    rabatt DECIMAL(10,2),
    FOREIGN KEY (kundeId) REFERENCES Kunde(kundeId)
);

CREATE TABLE Stol (
    stolId INT PRIMARY KEY AUTO_INCREMENT,
    modellNavn VARCHAR(255) NOT NULL,
    stolType VARCHAR(255) NOT NULL
);

CREATE TABLE StandardStol (
    stolId INT PRIMARY KEY,
    pris DECIMAL(10,2) NOT NULL,
    lagerBeholdning INT NOT NULL,
    FOREIGN KEY (stolId) REFERENCES Stol(stolId)
);

CREATE TABLE SpesialStol (
    stolId INT PRIMARY KEY,
    pris DECIMAL(10,2) NOT NULL,
    lagerBeholdning INT NOT NULL,
    FOREIGN KEY (stolId) REFERENCES Stol(stolId)
);

CREATE TABLE Bestilling (
    bestillingId INT PRIMARY KEY AUTO_INCREMENT,
    ordreId INT NOT NULL,
    stolId INT NOT NULL,
    antall INT NOT NULL,
    FOREIGN KEY (ordreId) REFERENCES Ordre(ordreId),
    FOREIGN KEY (stolId) REFERENCES Stol(stolId)
);

CREATE TABLE Deltype (
    deltypeId INT PRIMARY KEY AUTO_INCREMENT,
    navn VARCHAR(255) NOT NULL,
    farge VARCHAR(255) NOT NULL,
    pris DECIMAL(10,2) NOT NULL,
    beskrivelse VARCHAR(255),
    stoffBehov BOOLEAN NOT NULL
);

CREATE TABLE Stoffrull (
    stoffrullId INT PRIMARY KEY AUTO_INCREMENT,
    deltypeId INT NOT NULL,
    antallMeter DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (deltypeId) REFERENCES Deltype(deltypeId)
);

CREATE TABLE Arbeidsstasjon (
    arbeidsstasjonId INT PRIMARY KEY AUTO_INCREMENT,
    plassering VARCHAR(255) NOT NULL
);

CREATE TABLE Lager (
    deltypeId INT NOT NULL,
    arbeidsstasjonId INT NOT NULL,
    antall INT NOT NULL,
    PRIMARY KEY (deltypeId, arbeidsstasjonId),
    FOREIGN KEY (deltypeId) REFERENCES Deltype(deltypeId),
    FOREIGN KEY (arbeidsstasjonId) REFERENCES Arbeidsstasjon(arbeidsstasjonId)
);

INSERT INTO Kunde (navn, adresse) VALUES
('Ola Nordmann', 'Oslo'),
('Kari Nordmann', 'Bergen'),
('Per Hansen', 'Trondheim'),
('Lise Johansen', 'Stavanger'),
('Morten Olsen', 'Tromsø');

INSERT INTO Ordre (kundeId, ordreDato, antattLevering, reelLevering, betalingsStatus, rabatt) VALUES
(1, '2024-03-01', '2024-03-10', NULL, 'Ubetalt', 10.00),
(2, '2024-03-02', '2024-03-12', '2024-03-13', 'Betalt', 5.00),
(3, '2024-03-05', '2024-03-15', NULL, 'Ubetalt', 15.00),
(4, '2024-03-07', '2024-03-17', NULL, 'Ubetalt', 8.00),
(5, '2024-03-10', '2024-03-20', '2024-03-21', 'Betalt', 12.00);

INSERT INTO Stol (modellNavn, stolType) VALUES
('Model A', 'Kontor'),
('Model B', 'Spisestue'),
('Model C', 'Kontor'),
('Model D', 'Spisestue'),
('Model E', 'Lounge'),
('Model F', 'Lounge');

INSERT INTO StandardStol (stolId, pris, lagerBeholdning) VALUES
(1, 1500.00, 10),
(2, 1200.00, 15),
(3, 1800.00, 20);

INSERT INTO SpesialStol (stolId, pris, lagerBeholdning) VALUES
(4, 2500.00, 5),
(5, 3000.00, 8),
(6, 3200.00, 6);

INSERT INTO Bestilling (ordreId, stolId, antall) VALUES
(1, 1, 4),
(1, 2, 2),
(2, 1, 1),
(3, 3, 5),
(3, 4, 6),
(4, 2, 3),
(4, 5, 4),
(5, 1, 2),
(5, 6, 3);