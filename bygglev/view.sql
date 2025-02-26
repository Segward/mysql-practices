-- 1. Finn alle borettslag etablert i årene 1975-1985.
SELECT * FROM borettslag WHERE etabl_aar BETWEEN 1975 AND 1985;

-- 2. Skriv ut en liste over andelseiere. 
SELECT CONCAT(fornavn, ' ', etternavn, ', ansiennitet: ', ansiennitet, ' år') FROM andelseier
ORDER BY ansiennitet DESC;

-- 3. Skriv ut det eldste borettslaget. LIMIT 1 returns only the first row
SELECT bolag_navn, etabl_aar FROM borettslag
ORDER BY etabl_aar ASC
LIMIT 1;

-- 4. Skriv ut bygninger med leilighet på minst 3 rom.
SELECT bygn_adr FROM bygning
WHERE bygn_id IN (SELECT bygn_id FROM leilighet WHERE ant_rom >= 3);

-- 5. Finn alle bygninger i borettslaget "Tertitten".
SELECT * FROM bygning WHERE bolag_navn = 'Tertitten';

-- 6. Lag en liste som viser antall bygninger i hvert enkelt borettslag.
SELECT bo.bolag_navn, COUNT(b.bygn_id) AS antall_bygninger
FROM borettslag bo
LEFT JOIN bygning b ON bo.bolag_navn = b.bolag_navn
GROUP BY bo.bolag_navn;

-- 7. Finn alle leiligheter i borettslaget "Tertitten".
SELECT * FROM leilighet
WHERE bygn_id IN (SELECT bygn_id FROM bygning WHERE bolag_navn = 'Tertitten');

-- 8. Finn hvor høyt du kan bo i borettslaget "Tertitten".
SELECT ant_etasjer FROM bygning
WHERE bolag_navn = 'Tertitten' 
ORDER BY ant_etasjer DESC
LIMIT 1;

-- 9. Finn navn og nummer til andelseiere som ikke har leilighet.
SELECT fornavn, etternavn, and_eier_nr FROM andelseier
WHERE and_eier_nr NOT IN (SELECT and_eier_nr FROM leilighet);

-- 10. Finn antall andelseiere pr borettslag, sortert etter antallet. 
SELECT bo.bolag_navn, COUNT(a.and_eier_nr) AS antall_andelseiere
FROM borettslag bo
LEFT JOIN andelseier a ON bo.bolag_navn = a.bolag_navn
GROUP BY bo.bolag_navn
ORDER BY antall_andelseiere DESC;

-- 11. Skriv ut en liste over alle andelseiere. 
SELECT CONCAT(fornavn, ' ', etternavn, IFNULL(CONCAT(', leilighet: ', leil_nr), '')) AS andelseier_info
FROM andelseier
LEFT JOIN leilighet ON andelseier.and_eier_nr = leilighet.and_eier_nr;

-- 12. Hvilke borettslag har leiligheter med eksakt 4 rom?
SELECT bo.bolag_navn FROM borettslag bo
JOIN bygning b ON bo.bolag_navn = b.bolag_navn
JOIN leilighet l ON b.bygn_id = l.bygn_id
WHERE l.ant_rom = 4;

-- 13. Skriv ut en liste over antall andelseiere pr postnr og poststed.
SELECT ps.postnr, ps.poststed, COUNT(a.and_eier_nr) AS antall_andelseiere
FROM andelseier a
JOIN leilighet l ON a.and_eier_nr = l.and_eier_nr
JOIN bygning b ON l.bygn_id = b.bygn_id
JOIN poststed ps ON b.postnr = ps.postnr
GROUP BY ps.postnr, ps.poststed
HAVING COUNT(a.and_eier_nr) > 0;

-- a) Finn alle ordre som er levert av leverandør 44.
SELECT oh.ordrenr, oh.dato, oh.levnr, oh.status, od.delnr, od.kvantum
FROM ordrehode oh
JOIN ordredetalj od ON oh.ordrenr = od.ordrenr
WHERE oh.levnr = 44;

-- b) Finn navn og by "LevBy" for leverandører som kan levere del nummer 1.
SELECT li.navn, li.levby
FROM levinfo li
JOIN prisinfo pi ON li.levnr = pi.levnr
WHERE pi.delnr = 1;

-- c) Finn nummer, navn og pris for den leverandør som kan levere del nummer 201 til billigst pris.
SELECT pi.levnr, li.navn, pi.pris
FROM prisinfo pi
JOIN levinfo li ON pi.levnr = li.levnr
WHERE pi.delnr = 201
ORDER BY pi.pris ASC
LIMIT 1;

-- d) Lag fullstendig oversikt over ordre nr 16.
SELECT oh.ordrenr, oh.dato, od.delnr, di.beskrivelse, od.kvantum, pi.pris, (pi.pris * od.kvantum) AS belop
FROM ordrehode oh
JOIN ordredetalj od ON oh.ordrenr = od.ordrenr
JOIN delinfo di ON od.delnr = di.delnr
JOIN prisinfo pi ON od.delnr = pi.delnr AND oh.levnr = pi.levnr
WHERE oh.ordrenr = 16;

-- e) Finn delnummer og leverandørnummer for deler som har en pris som er høyere enn prisen for del med katalognr X7770.
SELECT pi.delnr, pi.levnr
FROM prisinfo pi
WHERE pi.pris > (SELECT pris FROM prisinfo WHERE katalognr = 'X7770');

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
    postnr INTEGER NOT NULL,
    CONSTRAINT ny_levinfo_fk FOREIGN KEY (levby) REFERENCES by_fylke (levby)
);

INSERT INTO ny_levinfo (levnr, navn, adresse, levby, postnr)
SELECT levnr, navn, adresse, levby, postnr FROM levinfo;

-- f) ii) Lag en virtuell tabell (view) slik at brukerne i størst mulig grad kan jobbe på samme måte mot de to nye tabellene som den gamle.
DROP VIEW IF EXISTS levinfo_view;
CREATE VIEW levinfo_view AS
SELECT nl.levnr, nl.navn, nl.adresse, nl.levby, bf.fylke, nl.postnr
FROM ny_levinfo nl
JOIN by_fylke bf ON nl.levby = bf.levby;

-- g) Finn ut hvilke byer en i tilfelle ikke får leverandør i hvis leverandører som ikke er representert i Prisinfo-tabellen slettes.
SELECT li.levby
FROM levinfo li
LEFT JOIN prisinfo pi ON li.levnr = pi.levnr
WHERE pi.levnr IS NULL;

-- h) Finn leverandørnummer for den leverandør som kan levere ordre nr 18 til lavest totale beløp.
DROP VIEW IF EXISTS leverandor_full_ordre;
DROP VIEW IF EXISTS leverandor_deler;
CREATE VIEW leverandor_deler AS
SELECT od.ordrenr, od.delnr, pi.levnr, pi.pris, od.kvantum, (pi.pris * od.kvantum) AS total_pris
FROM ordredetalj od
JOIN prisinfo pi ON od.delnr = pi.delnr
WHERE od.ordrenr = 18;

CREATE VIEW leverandor_full_ordre AS
SELECT ld.levnr, SUM(ld.total_pris) AS total_belop
FROM leverandor_deler ld
GROUP BY ld.levnr
HAVING COUNT(ld.delnr) = (SELECT COUNT(*) FROM ordredetalj WHERE ordrenr = 18);

SELECT levnr, total_belop
FROM leverandor_full_ordre
ORDER BY total_belop ASC
LIMIT 1;