SELECT title FROM webnovels 
WHERE JSON_CONTAINS(
  characters,
  JSON_OBJECT('name', 'Kim Dokja')
);