/*
    Oppgave 1 a
*/
SELECT fornavn, etternavn FROM forfatter 
ORDER BY etternavn ASC;

/*
    Oppgave 1 b subquery to get all forlag that are not in bok
*/
SELECT forlag_navn, forlag_id FROM forlag 
WHERE forlag_id NOT IN (SELECT DISTINCT forlag_id FROM bok);

/*
    Oppgave 1 c
*/
SELECT fornavn, etternavn, fode_aar FROM forfatter 
WHERE fode_aar < 1900;

/*
    Oppgave 1 d forlag heter nå f "aka et alias"
*/
SELECT f.forlag_navn, f.adresse FROM forlag f
JOIN bok b ON f.forlag_id = b.forlag_id
WHERE b.tittel = "Sult";

/*
    Oppgave 1 e
*/
SELECT b.tittel, f.fornavn, f.etternavn FROM bok b 
JOIN bok_forfatter bf ON b.bok_id = bf.bok_id
JOIN forfatter f ON bf.forfatter_id = f.forfatter_id
WHERE f.etternavn = "Hamsund";

/*
    Oppgave 1 f using left join to get all forlag on the left side then join with bok where forlag_id is the same
    her kan man også bruke INNER JOIN
*/
SELECT b.tittel, b.utgitt_aar, f.forlag_navn, f.telefon, f.adresse FROM forlag f
LEFT JOIN bok b ON b.forlag_id = f.forlag_id;

/*
    Oppgave 2 a

SELECT g.player, g.teamid, ga.mdate FROM goal g
JOIN game ga ON g.matchid = ga.id WHERE g.teamid = 'GER';

*/
SELECT g.player, g.teamid, ga.mdate FROM goal g
JOIN game ga ON g.matchid = ga.id
JOIN eteam e ON g.teamid = e.id WHERE e.teamname = "Germany";

/*
    Oppgave 2 b where we create a new column called goals and count the number of goals each player has scored
*/
SELECT g.player, COUNT(*) AS goals FROM goal g 
WHERE g.teamid = 'GER' 
GROUP BY g.player 
ORDER BY goals DESC;

/*
    Oppgave 2 c
*/
SELECT g.player, g.teamid, e.coach, g.gtime FROM goal g
JOIN eteam e ON g.teamid = e.id
WHERE g.gtime <= 10;

/*
    Oppgave 2 d
*/
SELECT ga.mdate, e.teamname FROM game ga
JOIN eteam e ON (ga.team1 = e.id) WHERE e.coach = "Fernando Santos";

/*
    Oppgave 2 e using OR to get the team name from the game table where the coach is Fernando Santos
*/
SELECT ga.mdate, e.teamname FROM game ga
JOIN eteam e ON (ga.team1 = e.id) OR (ga.team2 = e.id) WHERE e.coach = "Fernando Santos";

/*
    Kan lære mer om referense og diferense
*/