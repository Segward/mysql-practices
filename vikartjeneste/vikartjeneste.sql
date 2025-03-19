DROP TABLE IF EXISTS Sluttattest;
DROP TABLE IF EXISTS Jobbhistorikk;
DROP TABLE IF EXISTS Oppdrag;
DROP TABLE IF EXISTS Kvalifikasjon;
DROP TABLE IF EXISTS Bedrift;
DROP TABLE IF EXISTS Kandidat;

CREATE TABLE Kandidat (
    kandidatnr INT PRIMARY KEY,
    fornavn VARCHAR(255),
    etternavn VARCHAR(255),
    telefon VARCHAR(20),
    epost VARCHAR(255)
);

CREATE TABLE Bedrift (
    navn VARCHAR(255) PRIMARY KEY,
    organisasjonsnr INT UNIQUE,
    telefon VARCHAR(20),
    epost VARCHAR(255)
);

CREATE TABLE Kvalifikasjon (
    kvalifikasjonsnr INT PRIMARY KEY,
    kandidatnr INT,
    beskrivelse VARCHAR(255),
    FOREIGN KEY (kandidatnr) REFERENCES Kandidat(kandidatnr)
);

CREATE TABLE Oppdrag (
    oppdragsnr INT PRIMARY KEY,
    kandidatnr INT,
    bedriftsnavn VARCHAR(255),
    kvalifikasjon VARCHAR(255),
    startdato DATE,
    sluttdato DATE,
    FOREIGN KEY (kandidatnr) REFERENCES Kandidat(kandidatnr),
    FOREIGN KEY (bedriftsnavn) REFERENCES Bedrift(navn)
);

CREATE TABLE Jobbhistorikk (
    jobbhistorikk_id INT PRIMARY KEY,
    kandidatnr INT,
    oppdragsnr INT,
    virkelig_startdato DATE,
    virkelig_sluttdato DATE,
    timer_arbeidet INT,
    FOREIGN KEY (kandidatnr) REFERENCES Kandidat(kandidatnr),
    FOREIGN KEY (oppdragsnr) REFERENCES Oppdrag(oppdragsnr)
);

CREATE TABLE Sluttattest (
    attest_id INT PRIMARY KEY,
    oppdragsnr INT,
    kandidatnr INT,
    beskrivelse VARCHAR(255),
    FOREIGN KEY (oppdragsnr) REFERENCES Oppdrag(oppdragsnr),
    FOREIGN KEY (kandidatnr) REFERENCES Kandidat(kandidatnr)
);