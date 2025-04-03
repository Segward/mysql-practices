-- 1. Antall stolmodeller per stoltype
SELECT stolType, COUNT(*) AS antallModeller 
FROM Stol 
GROUP BY stolType;

-- 2. Gjennomsnittlig antall bestilte stoler per stoltype
SELECT s.stolType, AVG(b.antall) AS gjennomsnittAntall 
FROM Bestilling b 
JOIN Stol s ON b.stolId = s.stolId 
GROUP BY s.stolType;

-- 3. Totalt antall uleverte stoler
SELECT SUM(b.antall) AS totaltUleverteStoler 
FROM Bestilling b 
JOIN Ordre o ON b.ordreId = o.ordreId 
WHERE o.reelLevering IS NULL;

-- 4. Antall standardstoler i uleverte bestillinger
SELECT SUM(b.antall) AS antallStandardUleverte 
FROM Bestilling b 
JOIN Ordre o ON b.ordreId = o.ordreId 
JOIN StandardStol ss ON b.stolId = ss.stolId 
WHERE o.reelLevering IS NULL;