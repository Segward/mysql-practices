USE segward;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (username, password, email) VALUES ('admin', 'admin', 'temp@gmail.com');
INSERT INTO users (username, password, email) VALUES ('user', 'user', 'temp@gmail.com');
INSERT INTO users (username, password, email) VALUES ('test', 'test', 'temp@gmail.com');

SELECT * FROM users;