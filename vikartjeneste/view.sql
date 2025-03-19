-- 1. Skriv ut alle bedrifter
SELECT navn, telefon, epost FROM Bedrift;

-- 2. Skriv ut alle oppdrag og bedrifter som har oppdrag
SELECT oppdragsnr, bedriftsnavn, telefon FROM Oppdrag
LEFT JOIN Bedrift ON Oppdrag.bedriftsnavn = Bedrift.navn
ORDER BY oppdragsnr;

-- 3. Skriv ut kandidater og deres kvalifikasjoner
SELECT 
    CONCAT(a.fornavn, ' ', a.etternavn) AS kandidatnavn,
    a.kandidatnr,
    b.kvalifikasjonsnr, 
    b.beskrivelse AS kvalifikasjon
FROM Kandidat a
INNER JOIN Kvalifikasjon b  -- Ekskluderer kandidater uten kvalifikasjoner
ON a.kandidatnr = b.kandidatnr
ORDER BY a.kandidatnr, b.kvalifikasjonsnr;

-- 4. Som oppgave 4 med også kandidater uten kvalifikasjoner
SELECT 
    CONCAT(a.fornavn, ' ', a.etternavn) AS kandidatnavn,
    a.kandidatnr,
    b.kvalifikasjonsnr, 
    b.beskrivelse AS kvalifikasjon
FROM Kandidat a
LEFT JOIN Kvalifikasjon b -- Endret INNER til LEFT for å inkludere kandidater uten kvalifikasjoner
ON a.kandidatnr = b.kandidatnr
ORDER BY a.kandidatnr, b.kvalifikasjonsnr;

-- 5. Skriv ut jobbhistorikken til en bestemt vikar (kandidat)
SELECT 
    CONCAT(b.fornavn, ' ', b.etternavn) AS kandidatnavn,
    a.virkelig_sluttdato,
    a.oppdragsnr,
    c.bedriftsnavn
FROM Jobbhistorikk a
JOIN Kandidat b ON a.kandidatnr = b.kandidatnr
JOIN Oppdrag c ON a.oppdragsnr = c.oppdragsnr
WHERE b.kandidatnr = 1;