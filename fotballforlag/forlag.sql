/*
** bok-script-mysql.txt
/*
** DROP TABLE-setninger som sletter gamle tabeller
*/

DROP TABLE IF EXISTS bok_forfatter;
DROP TABLE IF EXISTS forfatter;
DROP TABLE IF EXISTS bok;
DROP TABLE IF EXISTS forlag;
DROP TABLE IF EXISTS konsulent; 

/*
** Oppretter tabeller med entitetsintegritet
*/
CREATE TABLE forlag
(
forlag_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
forlag_navn VARCHAR(30),
adresse VARCHAR(30),
telefon CHAR(15),
PRIMARY KEY(forlag_id)
)ENGINE=INNODB;

CREATE TABLE bok
(
bok_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
tittel VARCHAR(30),
utgitt_aar INT,
forlag_id INT UNSIGNED,
PRIMARY KEY(bok_id)
)ENGINE=INNODB;

CREATE TABLE forfatter
(
forfatter_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
fornavn VARCHAR(20),
etternavn VARCHAR(30),
fode_aar INT,
dod_aar INT,
nasjonalitet VARCHAR(20),
PRIMARY KEY(forfatter_id)
)ENGINE=INNODB;

CREATE TABLE bok_forfatter
(
bok_id INT UNSIGNED NOT NULL,
forfatter_id INT UNSIGNED NOT NULL,
PRIMARY KEY(bok_id, forfatter_id)
)ENGINE=INNODB;

CREATE TABLE konsulent
(
kons_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
fornavn VARCHAR(20),
etternavn VARCHAR(30),
epost VARCHAR(30),
PRIMARY KEY(kons_id)
)ENGINE=INNODB;

/*
** Legger på referanseintegritet (fremmednøkler)
*/
ALTER TABLE bok
 ADD FOREIGN KEY(forlag_id)REFERENCES forlag(forlag_id);

ALTER TABLE bok_forfatter
 ADD FOREIGN KEY(bok_id)REFERENCES bok(bok_id);
 
ALTER TABLE bok_forfatter
 ADD FOREIGN KEY(forfatter_id)REFERENCES forfatter(forfatter_id);


/*
** Legger inn gyldige data i tabellene
*/
INSERT INTO forlag VALUES(NULL,'Tapir','Trondheim','73590000');
INSERT INTO forlag VALUES(NULL, 'Gyldendal','Oslo','22220000');
INSERT INTO forlag VALUES(NULL, 'Cappelen','Oslo','22200000');
INSERT INTO forlag VALUES(NULL, 'Universitetsforlaget','Oslo','23230000');
INSERT INTO forlag VALUES(NULL, 'Aschehaug','Oslo','22000000');
INSERT INTO forlag VALUES(NULL, 'Oktober','Oslo','22002200');
INSERT INTO forlag VALUES(NULL, 'Tiden','Oslo','22232223');
INSERT INTO forlag VALUES(NULL, 'Harper Collins','USA',NULL);

INSERT INTO bok VALUES(NULL,'Tåpenes',1995,7);
INSERT INTO bok VALUES(NULL,'Rebecca',1981,3);
INSERT INTO bok VALUES(NULL,'Gutter er gutter',1995,5);
INSERT INTO bok VALUES(NULL,'Microserfs',1991,8);
INSERT INTO bok VALUES(NULL,'Generation X',1995,8);
INSERT INTO bok VALUES(NULL,'Klosterkrønike',1982,3);
INSERT INTO bok VALUES(NULL,'Universet',1988,3);
INSERT INTO bok VALUES(NULL,'Nålen',1978,3);
INSERT INTO bok VALUES(NULL,'Markens grøde',1917,2);
INSERT INTO bok VALUES(NULL,'Victoria',1898,2);
INSERT INTO bok VALUES(NULL,'Sult',1890,2);
INSERT INTO bok VALUES(NULL,'Benoni',1908,2);
INSERT INTO bok VALUES(NULL,'Rosa',1908,2);
INSERT INTO bok VALUES(NULL,'Et skritt',1997,2);
INSERT INTO bok VALUES(NULL,'Den femte',1996,2);
INSERT INTO bok VALUES(NULL,'Villspor',1995,2);
INSERT INTO bok VALUES(NULL,'Silkeridderen',1994,2);
INSERT INTO bok VALUES(NULL,'Den hvite hingsten',1992,2);
INSERT INTO bok VALUES(NULL,'Hunder',1992,2);
INSERT INTO bok VALUES(NULL,'Bridget Jones',1995,5);
INSERT INTO bok VALUES(NULL,'Se terapeuten',1998,3);
INSERT INTO bok VALUES(NULL,'Sa mor',1996,3);
INSERT INTO bok VALUES(NULL,'Jubel',1995,3);
INSERT INTO bok VALUES(NULL,'Tatt av kvinnen',1993,3);
INSERT INTO bok VALUES(NULL,'Supernaiv',1996,3);

INSERT INTO forfatter VALUES(NULL, 'John','Tool',1937, 1969, 'USA');
INSERT INTO forfatter VALUES(NULL,'Ken','Follet',NULL, NULL, 'Britisk');
INSERT INTO forfatter VALUES(NULL,'Stephen','Hawking',NULL, NULL, 'Britisk');
INSERT INTO forfatter VALUES(NULL,'Jose','Saramago',1942, NULL, 'Portugisisk');
INSERT INTO forfatter VALUES(NULL,'Douglas','Coupland',1961, NULL, 'Canadisk');
INSERT INTO forfatter VALUES(NULL,'Nick','Hornby',1857, NULL, 'Britisk');
INSERT INTO forfatter VALUES(NULL,'Knut','Hamsund',1859, 1952, 'Norsk');
INSERT INTO forfatter VALUES(NULL,'Henning','Mankell',1948, NULL, 'Svensk');
INSERT INTO forfatter VALUES(NULL,'Helen','Fielding',NULL, NULL, 'Britisk');
INSERT INTO forfatter VALUES(NULL,'Hal','Sirowitz',NULL, NULL, 'USA');
INSERT INTO forfatter VALUES(NULL,'Lars S.','Christensen',NULL, NULL, 'Norsk');
INSERT INTO forfatter VALUES(NULL,'Erlend','Loe',NULL, NULL, 'Norsk');

INSERT INTO bok_forfatter VALUES(1, 1);
INSERT INTO bok_forfatter VALUES(2, 2);
INSERT INTO bok_forfatter VALUES(3, 6);
INSERT INTO bok_forfatter VALUES(4, 5);
INSERT INTO bok_forfatter VALUES(5, 5);
INSERT INTO bok_forfatter VALUES(6, 4);
INSERT INTO bok_forfatter VALUES(7, 3);
INSERT INTO bok_forfatter VALUES(8, 2);
INSERT INTO bok_forfatter VALUES(9, 7);
INSERT INTO bok_forfatter VALUES(10, 7);
INSERT INTO bok_forfatter VALUES(11, 7);
INSERT INTO bok_forfatter VALUES(12, 1);
INSERT INTO bok_forfatter VALUES(13, 1);
INSERT INTO bok_forfatter VALUES(14, 8);
INSERT INTO bok_forfatter VALUES(15, 8);
INSERT INTO bok_forfatter VALUES(16, 8);
INSERT INTO bok_forfatter VALUES(17, 8);
INSERT INTO bok_forfatter VALUES(18, 8);
INSERT INTO bok_forfatter VALUES(19, 8);
INSERT INTO bok_forfatter VALUES(20, 9);
INSERT INTO bok_forfatter VALUES(21, 10);
INSERT INTO bok_forfatter VALUES(22, 10);
INSERT INTO bok_forfatter VALUES(23, 11);
INSERT INTO bok_forfatter VALUES(24, 12);
INSERT INTO bok_forfatter VALUES(25, 12);

INSERT INTO konsulent VALUES(NULL, 'Anne', 'Hansen', 'anne.hansen@xxx.com');
INSERT INTO konsulent VALUES(NULL, 'Bjørn', 'Jensen', 'bjornj@yyy.com');
INSERT INTO konsulent VALUES(NULL,'Anne', 'Ås', 'anne.as@zzz.com');

