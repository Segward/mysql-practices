DROP TABLE IF EXISTS Sluttattest;
DROP TABLE IF EXISTS Jobbhistorikk;
DROP TABLE IF EXISTS Oppdrag;
DROP TABLE IF EXISTS Kvalifikasjon;
DROP TABLE IF EXISTS Bedrift;
DROP TABLE IF EXISTS Kandidat;

CREATE TABLE Kandidat (
    kandidatnr INT PRIMARY KEY AUTO_INCREMENT,
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
    kvalifikasjonsnr INT PRIMARY KEY AUTO_INCREMENT,
    kandidatnr INT,
    beskrivelse VARCHAR(255),
    FOREIGN KEY (kandidatnr) REFERENCES Kandidat(kandidatnr)
);

CREATE TABLE Oppdrag (
    oppdragsnr INT PRIMARY KEY AUTO_INCREMENT,
    kandidatnr INT,
    bedriftsnavn VARCHAR(255),
    kvalifikasjon VARCHAR(255),
    startdato DATE,
    sluttdato DATE,
    FOREIGN KEY (kandidatnr) REFERENCES Kandidat(kandidatnr),
    FOREIGN KEY (bedriftsnavn) REFERENCES Bedrift(navn)
);

CREATE TABLE Jobbhistorikk (
    jobbhistorikk_id INT PRIMARY KEY AUTO_INCREMENT,
    kandidatnr INT,
    oppdragsnr INT,
    virkelig_startdato DATE,
    virkelig_sluttdato DATE,
    timer_arbeidet INT,
    FOREIGN KEY (kandidatnr) REFERENCES Kandidat(kandidatnr),
    FOREIGN KEY (oppdragsnr) REFERENCES Oppdrag(oppdragsnr)
);

CREATE TABLE Sluttattest (
    attest_id INT PRIMARY KEY AUTO_INCREMENT,
    oppdragsnr INT,
    kandidatnr INT,
    beskrivelse VARCHAR(255),
    FOREIGN KEY (oppdragsnr) REFERENCES Oppdrag(oppdragsnr),
    FOREIGN KEY (kandidatnr) REFERENCES Kandidat(kandidatnr)
);

-- Insert filler data into Kandidat
INSERT INTO Kandidat (fornavn, etternavn, telefon, epost)
VALUES
('Ola', 'Nordmann', '12345678', 'ola.nordmann@example.com'),
('Kari', 'Nordmann', '87654321', 'kari.nordmann@example.com'),
('Per', 'Hansen', '11223344', 'per.hansen@example.com'),
('Anne', 'Larsen', '44332211', 'anne.larsen@example.com'),
('Jon', 'Johansen', '99887766', 'jon.johansen@example.com'),
('Mona', 'Johansen', '66778899', 'mona.johansen@example.com');

-- Insert filler data into Bedrift
INSERT INTO Bedrift (navn, organisasjonsnr, telefon, epost)
VALUES
('TechCorp', 123456789, '55512345', 'contact@techcorp.com'),
('BuildIt', 987654321, '55554321', 'info@buildit.com'),
('HealthCare AS', 456789123, '55567890', 'support@healthcare.com'),
('EduLearn', 789123456, '55598765', 'hello@edulearn.com'),
('GreenEnergy', 321654987, '55545678', 'info@greenenergy.com');

-- Insert filler data into Kvalifikasjon
INSERT INTO Kvalifikasjon (kandidatnr, beskrivelse)
VALUES
(1, 'Java Developer'),
(1, 'Scrum Master'),
(3, 'Data Analyst'),
(3, 'Data Scientist'),
(3, 'Data Engineer'),
(4, 'Graphic Designer'),
(5, 'Electrical Engineer'),
(5, 'Mechanical Engineer'),
(5, 'Civil Engineer'),
(6, 'Software Developer'),
(6, 'Software Engineer');

-- Insert filler data into Oppdrag
INSERT INTO Oppdrag (kandidatnr, bedriftsnavn, kvalifikasjon, startdato, sluttdato)
VALUES
(1, 'TechCorp', 'Java Developer', '2025-01-01', '2025-06-30'),
(2, 'BuildIt', 'Project Manager', '2025-02-01', '2025-07-31'),
(3, 'HealthCare AS', 'Data Analyst', '2025-03-01', '2025-08-31'),
(4, 'EduLearn', 'Graphic Designer', '2025-04-01', '2025-09-30'),
(5, 'GreenEnergy', 'Electrical Engineer', '2025-05-01', '2025-10-31');

-- Insert filler data into Jobbhistorikk
INSERT INTO Jobbhistorikk (kandidatnr, oppdragsnr, virkelig_startdato, virkelig_sluttdato, timer_arbeidet)
VALUES
(1, 1, '2025-01-01', '2025-06-30', 800),
(2, 2, '2025-02-01', '2025-07-31', 900),
(3, 3, '2025-03-01', '2025-08-31', 850),
(4, 4, '2025-04-01', '2025-09-30', 750),
(5, 5, '2025-05-01', '2025-10-31', 950);

-- Insert filler data into Sluttattest
INSERT INTO Sluttattest (oppdragsnr, kandidatnr, beskrivelse)
VALUES
(1, 1, 'Excellent performance as a Java Developer.'),
(2, 2, 'Great leadership as a Project Manager.'),
(3, 3, 'Outstanding analytical skills as a Data Analyst.'),
(4, 4, 'Creative and efficient as a Graphic Designer.'),
(5, 5, 'Highly skilled in electrical engineering.');