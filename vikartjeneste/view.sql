-- 1. Skriv ut alle bedrifter
SELECT navn, telefon, epost FROM Bedrift;

-- 2. Skriv ut alle oppdrag og bedrifter som har oppdrag
SELECT oppdragsnr, bedriftsnavn, telefon FROM Oppdrag
LEFT JOIN Bedrift ON Oppdrag.bedriftsnavn = Bedrift.navn
ORDER BY oppdragsnr;