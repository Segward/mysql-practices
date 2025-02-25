DROP TABLE IF EXISTS APARTMENT;

DROP TABLE IF EXISTS PROPERTIES;

DROP TABLE IF EXISTS HOA_MEMBER;

DROP TABLE IF EXISTS HOA;

CREATE TABLE HOA (
    id INT AUTO_INCREMENT PRIMARY KEY,
    addr VARCHAR(255) NOT NULL,
    name_ VARCHAR(255) NOT NULL,
    properties INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE HOA_MEMBER (
    id INT AUTO_INCREMENT PRIMARY KEY,
    member_name VARCHAR(255) NOT NULL,
    hoa_id INT NOT NULL,
    FOREIGN KEY (hoa_id) REFERENCES HOA(id)
);

CREATE TABLE PROPERTIES (
    id INT AUTO_INCREMENT PRIMARY KEY,
    addr VARCHAR(255) NOT NULL,
    hoa_id INT NOT NULL,
    floors INT NOT NULL,
    apartments INT NOT NULL,
    FOREIGN KEY (hoa_id) REFERENCES HOA(id)
);

CREATE TABLE APARTMENT (
    id INT AUTO_INCREMENT PRIMARY KEY,
    prop_id INT NOT NULL,
    addr_floor INT NOT NULL,
    suite_num INT NOT NULL,
    area FLOAT NOT NULL,
    rooms INT NOT NULL,
    member_id INT,
    FOREIGN KEY (prop_id) REFERENCES PROPERTIES(id),
    FOREIGN KEY (member_id) REFERENCES HOA_MEMBER(id)
);

INSERT INTO HOA (addr, name_, properties) VALUES ('Elmwood', "Hoa 2", 5);
INSERT INTO HOA (addr, name_, properties) VALUES ('Oakwood', "Hoa 2", 3);

INSERT INTO HOA_MEMBER (member_name, hoa_id) VALUES ('John Doe', 1);
INSERT INTO HOA_MEMBER (member_name, hoa_id) VALUES ('Jane Doe', 1);
INSERT INTO HOA_MEMBER (member_name, hoa_id) VALUES ('Jim Doe', 1);
INSERT INTO HOA_MEMBER (member_name, hoa_id) VALUES ('Jill Doe', 1);
INSERT INTO HOA_MEMBER (member_name, hoa_id) VALUES ('Jack Doe', 2);
INSERT INTO HOA_MEMBER (member_name, hoa_id) VALUES ('Jenny Doe', 2);
INSERT INTO HOA_MEMBER (member_name, hoa_id) VALUES ('Jerry Doe', 2);
INSERT INTO HOA_MEMBER (member_name, hoa_id) VALUES ('Judy Doe', 2);
INSERT INTO HOA_MEMBER (member_name, hoa_id) VALUES ('Jesse Doe', 2);
INSERT INTO HOA_MEMBER (member_name, hoa_id) VALUES ('Job Doe', 2);
INSERT INTO HOA_MEMBER (member_name, hoa_id) VALUES ('Jillian Doe', 2);
INSERT INTO HOA_MEMBER (member_name, hoa_id) VALUES ('Jasper Doe', 2);

INSERT INTO PROPERTIES (addr, hoa_id, floors, apartments) VALUES ('123 Elm St', 1, 2, 4);
INSERT INTO PROPERTIES (addr, hoa_id, floors, apartments) VALUES ('456 Elm St', 1, 2, 4);
INSERT INTO PROPERTIES (addr, hoa_id, floors, apartments) VALUES ('101 Oak St', 2, 3, 6);

INSERT INTO APARTMENT (prop_id, addr_floor, suite_num, area, rooms, member_id) VALUES (1, 1, 1, 408.5, 2, 1);
INSERT INTO APARTMENT (prop_id, addr_floor, suite_num, area, rooms, member_id) VALUES (1, 1, 2, 189.0, 4, NULL);
INSERT INTO APARTMENT (prop_id, addr_floor, suite_num, area, rooms, member_id) VALUES (1, 2, 1, 390.2, 1, NULL);
INSERT INTO APARTMENT (prop_id, addr_floor, suite_num, area, rooms, member_id) VALUES (1, 2, 2, 391.5, 1, 2);
INSERT INTO APARTMENT (prop_id, addr_floor, suite_num, area, rooms, member_id) VALUES (2, 2, 1, 390.2, 2, 3);
INSERT INTO APARTMENT (prop_id, addr_floor, suite_num, area, rooms, member_id) VALUES (2, 2, 2, 391.5, 3, 4);
INSERT INTO APARTMENT (prop_id, addr_floor, suite_num, area, rooms, member_id) VALUES (2, 1, 1, 408.5, 5, NULL);
INSERT INTO APARTMENT (prop_id, addr_floor, suite_num, area, rooms, member_id) VALUES (2, 1, 2, 189.0, 1, NULL);
INSERT INTO APARTMENT (prop_id, addr_floor, suite_num, area, rooms, member_id) VALUES (3, 1, 1, 930.2, 4, 5);
INSERT INTO APARTMENT (prop_id, addr_floor, suite_num, area, rooms, member_id) VALUES (3, 1, 2, 394.4, 2, 6);
INSERT INTO APARTMENT (prop_id, addr_floor, suite_num, area, rooms, member_id) VALUES (3, 2, 1, 393.3, 3, 7);
INSERT INTO APARTMENT (prop_id, addr_floor, suite_num, area, rooms, member_id) VALUES (3, 2, 2, 402.3, 5, 8);
INSERT INTO APARTMENT (prop_id, addr_floor, suite_num, area, rooms, member_id) VALUES (3, 3, 1, 304.4, 3, 9);
INSERT INTO APARTMENT (prop_id, addr_floor, suite_num, area, rooms, member_id) VALUES (3, 3, 2, 304.4, 2, 10);