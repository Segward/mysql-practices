INSERT INTO webnovels (title, chapters, author, genres, description, cover_image, released, status, characters)
VALUES (
    	'Omniscient Reader’s Viewpoint',
   	 551,
    	'Sing Shong',
    	JSON_ARRAY('Fantasy', 'Action', 'Psychological', 'Drama'),
    	'A long-time web novel reader wakes up in the world of his favorite story.',
'https://upload.wikimedia.org/wikipedia/en/f/f1/Omniscient_Readers_Viewpoint_volume_1_cover.jpg',
    	'2018-01-01',
   	'completed',
    	JSON_ARRAY(
JSON_OBJECT('name', 'Kim Dokja', 'image', 'https://static.wikia.nocookie.net/omniscient-readers-viewpoint/images/9/9c/Kim_Dokja_Manhwa.png'),
JSON_OBJECT('name', 'Yoo Joonghyuk', 'image', 'https://static.wikia.nocookie.net/omniscient-readers-viewpoint/images/b/bb/Yoo_Joonghyuk_Manhwa.png'),
JSON_OBJECT('name', 'Han Sooyoung', 'image', 'https://static.wikia.nocookie.net/omniscient-readers-viewpoint/images/e/e3/Han_Sooyoung.png')
    	)
);

INSERT INTO webnovels (title, chapters, author, genres, description, cover_image, released, status, characters)
VALUES (
    'The Beginning After The End',
    180,
    'TurtleMe',
    JSON_ARRAY('Fantasy', 'Action', 'Isekai', 'Magic'),
    'King Grey has unrivaled strength, wealth, and prestige—but lacks purpose. Reincarnated in a new world, he tries to live differently.',
    'https://upload.wikimedia.org/wikipedia/en/3/3d/The_Beginning_After_The_End_cover.png',
    '2018-07-01',
    'ongoing',
    JSON_ARRAY(
        JSON_OBJECT('name', 'Arthur Leywin', 'image', 'https://static.wikia.nocookie.net/tbate/images/8/84/Arthur_Anime_Design.png'),
        JSON_OBJECT('name', 'Sylvie', 'image', 'https://static.wikia.nocookie.net/tbate/images/6/65/Sylvie.png'),
        JSON_OBJECT('name', 'Tessia Eralith', 'image', 'https://static.wikia.nocookie.net/tbate/images/e/e2/Tessia.png')
    )
);

INSERT INTO webnovels (title, chapters, author, genres, description, cover_image, released, status, characters)
VALUES (
    'Hardcore Leveling Warrior',
    234,
    'Kim Sehoon (Sehoon Kim)',
    JSON_ARRAY('Action', 'Fantasy', 'Game', 'Adventure'),
    'Hardcore Leveling Warrior, the top player in the game Lucid Adventure, loses everything and must climb his way back up.',
    'https://upload.wikimedia.org/wikipedia/en/1/13/Hardcore_Leveling_Warrior_cover.jpg',
    '2017-10-18',
    'completed',
    JSON_ARRAY(
        JSON_OBJECT('name', 'Hardcore Leveling Warrior', 'image', 'https://static.wikia.nocookie.net/hardcore-leveling-warrior/images/6/64/Hardcore_Leveling_Warrior_Profile.png'),
        JSON_OBJECT('name', 'Dark', 'image', 'https://static.wikia.nocookie.net/hardcore-leveling-warrior/images/2/2e/Dark_Profile.png'),
        JSON_OBJECT('name', 'Sora', 'image', 'https://static.wikia.nocookie.net/hardcore-leveling-warrior/images/8/8b/Sora_Profile.png')
    )
);
