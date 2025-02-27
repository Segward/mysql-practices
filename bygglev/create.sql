-- f) Lag én ny tabell som inneholder byer og fylker, og en tabell som er lik levinfo unntatt kolonnen Fylke.
DROP TABLE IF EXISTS ny_levinfo;
DROP TABLE IF EXISTS by_fylke;

CREATE TABLE by_fylke (
    levby VARCHAR(20) PRIMARY KEY,
    fylke VARCHAR(20) NOT NULL
);

INSERT INTO by_fylke (levby, fylke)
SELECT DISTINCT levby, fylke FROM levinfo;

CREATE TABLE ny_levinfo (
    levnr INTEGER PRIMARY KEY,
    navn VARCHAR(20) NOT NULL,
    adresse VARCHAR(20) NOT NULL,
    levby VARCHAR(20) NOT NULL,
    postnr INTEGER NOT NULL
);

INSERT INTO ny_levinfo (levnr, navn, adresse, levby, postnr)
SELECT levnr, navn, adresse, levby, postnr FROM levinfo;

-- f) ii) Lag en virtuell tabell (view) slik at brukerne i størst mulig grad kan jobbe på samme måte mot de to nye tabellene som den gamle.
DROP VIEW IF EXISTS levinfo_view;

CREATE VIEW levinfo_view AS
SELECT nl.levnr, nl.navn, nl.adresse, nl.levby, bf.fylke, nl.postnr
FROM ny_levinfo nl
JOIN by_fylke bf ON nl.levby = bf.levby;

-- h) Finn leaverandørnummer for den leverandør som kan levere ordre nr 18 til lavest totale beløp.
DROP VIEW IF EXISTS leverandor_full_ordre;
DROP VIEW IF EXISTS leverandor_deler;

CREATE VIEW leverandor_deler AS
SELECT od.ordrenr, od.delnr, pi.levnr, pi.pris, od.kvantum, (pi.pris * od.kvantum) AS total_pris
FROM ordredetalj od
JOIN prisinfo pi ON od.delnr = pi.delnr
WHERE od.ordrenr = 18;

-- Using HAVING to filter out leverandorer that can't deliver all deler in ordre 18
CREATE VIEW leverandor_full_ordre AS
SELECT ld.levnr, SUM(ld.total_pris) AS total_belop
FROM leverandor_deler ld
GROUP BY ld.levnr
HAVING COUNT(ld.delnr) = (SELECT COUNT(*) FROM ordredetalj WHERE ordrenr = 18);