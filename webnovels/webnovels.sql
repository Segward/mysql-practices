DROP TABLE IF EXISTS webnovel_status;
DROP TABLE IF EXISTS webnovel_comments;
DROP TABLE IF EXISTS webnovels;
DROP TABLE IF EXISTS users;

CREATE TABLE IF NOT EXISTS webnovels (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    chapters INT DEFAULT 0,
    author VARCHAR(255),
    genres VARCHAR(255),
    description TEXT,
    cover_image VARCHAR(255),
    released DATE,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('ongoing', 'completed', 'hiatus') DEFAULT 'ongoing'
);

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS webnovel_status (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    webnovel_id INT NOT NULL,
    rating INT DEFAULT 0,
    times_read INT DEFAULT 0,
    last_read_chapter INT DEFAULT 0,
    first_read_chapter INT DEFAULT 0,
    last_read_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('reading', 'completed', 'paused', 'dropped', 'planning') DEFAULT 'planning',
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (webnovel_id) REFERENCES webnovels(id)
);

CREATE TABLE IF NOT EXISTS webnovel_comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    webnovel_id INT NOT NULL,
    comment TEXT NOT NULL,
    chapter_from INT DEFAULT 0,
    chapter_to INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (webnovel_id) REFERENCES webnovels(id)
);
