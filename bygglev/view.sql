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

-- 5. Finn alle bygninger i borrettslaget "Tertitten".
SELECT * FROM bygning WHERE bolag_navn = 'Tertitten';

-- 6. Lag en liste som viser antall bygninger i hvert enkelt borettslag.
SELECT bo.bolag_navn, COUNT(b.bygn_id) AS antall_bygninger FROM borettslag bo
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