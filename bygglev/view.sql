SELECT * FROM ordredetalj;
SELECT * FROM prisinfo;
SELECT * FROM ordrehode;
SELECT * FROM delinfo;
SELECT * FROM levinfo;

-- 1. Finn alle borettslag etablert i årene 1975-1985.
SELECT * FROM borettslag 
WHERE etabl_aar BETWEEN 1975 AND 1985;

-- 2. Skriv ut en liste over andelseiere. 
SELECT fornavn, etternavn, ansiennitet
FROM andelseier
ORDER BY ansiennitet DESC;

-- 3. Skriv ut det eldste borettslaget. LIMIT 1 returns only the first row
SELECT bolag_navn, etabl_aar 
FROM borettslag
ORDER BY etabl_aar ASC
LIMIT 1;

-- 4. Skriv ut bygninger med leilighet på minst 3 rom.
SELECT DISTINCT b.bygn_adr
FROM bygning b
JOIN leilighet l ON b.bygn_id = l.bygn_id
WHERE l.ant_rom >= 3;

-- 5. Finn alle bygninger i borettslaget "Tertitten".
SELECT * FROM bygning WHERE bolag_navn = 'Tertitten';

-- 6. Lag en liste som viser antall bygninger i hvert enkelt borettslag.
SELECT bo.bolag_navn, COUNT(b.bygn_id) AS antall_bygninger
FROM borettslag bo
LEFT JOIN bygning b ON bo.bolag_navn = b.bolag_navn
GROUP BY bo.bolag_navn;

-- 7. Finn alle leiligheter i borettslaget "Tertitten".
SELECT * FROM leilighet
WHERE bygn_id IN 
(SELECT bygn_id FROM bygning WHERE bolag_navn = 'Tertitten');

-- 8. Finn hvor høyt du kan bo i borettslaget "Tertitten".
SELECT ant_etasjer FROM bygning
WHERE bolag_navn = 'Tertitten' 
ORDER BY ant_etasjer DESC
LIMIT 1;

-- 9. Finn navn og nummer til andelseiere som ikke har leilighet.
SELECT fornavn, etternavn, andelseier.and_eier_nr 
FROM andelseier
WHERE andelseier.and_eier_nr NOT IN 
      (SELECT leilighet.and_eier_nr FROM leilighet);

-- 10. Finn antall andelseiere pr borettslag, sortert etter antallet. 
SELECT bo.bolag_navn, COUNT(a.and_eier_nr) AS antall_andelseiere
FROM borettslag bo
LEFT JOIN andelseier a ON bo.bolag_navn = a.bolag_navn
GROUP BY bo.bolag_navn
ORDER BY antall_andelseiere DESC;

-- 11. Skriv ut en liste over alle andelseiere. 
SELECT a.fornavn, a.etternavn, l.leil_nr
FROM andelseier a
LEFT JOIN leilighet l ON a.and_eier_nr = l.and_eier_nr;

-- 12. Hvilke borettslag har leiligheter med eksakt 4 rom?
SELECT DISTINCT bo.bolag_navn
FROM borettslag bo
JOIN bygning b ON bo.bolag_navn = b.bolag_navn
JOIN leilighet l ON b.bygn_id = l.bygn_id
WHERE l.ant_rom = 4;

-- 12. ii) Hvilke leiligheter har eksakt 4 rom? sjeke om det er riktig
SELECT * FROM leilighet;

-- 13. Skriv ut en liste over antall andelseiere pr postnr og poststed.
SELECT ps.postnr, ps.poststed, COUNT(a.and_eier_nr) AS antall_andelseiere
FROM andelseier a
JOIN leilighet l ON a.and_eier_nr = l.and_eier_nr
JOIN bygning b ON l.bygn_id = b.bygn_id
JOIN poststed ps ON b.postnr = ps.postnr
GROUP BY ps.postnr, ps.poststed
HAVING antall_andelseiere > 0;

-- a) Finn alle ordre som er levert av leverandør 44.
SELECT oh.ordrenr, oh.dato, oh.levnr, oh.status, od.delnr, od.kvantum
FROM ordrehode oh
JOIN ordredetalj od ON oh.ordrenr = od.ordrenr
WHERE oh.levnr = 44;

-- b) Finn navn og by "LevBy" for leverandører som kan levere del nummer 1.
SELECT li.navn, li.levby
FROM levinfo li
JOIN prisinfo p ON li.levnr = p.levnr
WHERE p.delnr = 1;

-- c) Finn nummer, navn og pris for den leverandør som kan levere del nummer 201 til billigst pris.
SELECT p.levnr, li.navn, p.pris
FROM prisinfo p
JOIN levinfo li ON p.levnr = li.levnr
WHERE p.delnr = 201
ORDER BY p.pris ASC
LIMIT 1;

-- d) Lag fullstendig oversikt over ordre nr 16.
SELECT oh.ordrenr, oh.dato, od.delnr, di.beskrivelse, od.kvantum, p.pris, (p.pris * od.kvantum) AS belop
FROM ordrehode oh
JOIN ordredetalj od ON oh.ordrenr = od.ordrenr
JOIN delinfo di ON od.delnr = di.delnr
JOIN prisinfo p ON od.delnr = p.delnr AND oh.levnr = p.levnr
WHERE oh.ordrenr = 16;

-- e) Finn delnummer og leverandørnummer for deler som har en pris som er høyere enn prisen for del med katalognr X7770.
SELECT p.delnr, p.levnr
FROM prisinfo p
WHERE p.pris > (SELECT pris FROM prisinfo WHERE katalognr = 'X7770');

-- f) Lag én ny tabell som inneholder byer og fylker, og en tabell som er lik levinfo unntatt kolonnen Fylke.
SELECT * FROM ny_levinfo;
SELECT * FROM by_fylke;

-- f) ii) Lag en virtuell tabell (view) slik at brukerne i størst mulig grad kan jobbe på samme måte mot de to nye tabellene som den gamle.
SELECT * FROM levinfo_view;

-- g) Finn ut hvilke byer en i tilfelle ikke får leverandør i hvis leverandører som ikke er representert i Prisinfo-tabellen slettes.
SELECT lev.levby
FROM levinfo lev
WHERE levby NOT IN 
( SELECT levby FROM levinfo le JOIN prisinfo p ON le.levnr = p.levnr);


-- h) Finn leverandørnummer for den leverandør som kan levere ordre nr 18 til lavest totale beløp.
SELECT levnr, total_belop
FROM leverandor_full_ordre
ORDER BY total_belop ASC
LIMIT 1;