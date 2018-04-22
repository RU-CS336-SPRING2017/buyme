USE BuyMe;

START TRANSACTION;

-- Adding accounts

INSERT INTO Account (username, password, type)
VALUES ('admin', 'admin', 'admin');

INSERT INTO Account (username, password, type)
VALUES ('Rep1', 'buyme1', 'customerRep');

INSERT INTO Account (username, password, type)
VALUES ('User1', 'pass18', 'user');

INSERT INTO Account (username, password, type)
VALUES ('User2', 'pass18', 'user');

INSERT INTO Account (username, password, type)
VALUES ('User3', 'pass18', 'user');

-- Adding categories

INSERT INTO ItemCategory (name)
VALUES ('Computers');

INSERT INTO ItemSubcategory (name, category)
VALUES ('Desktops', 'Computers');

INSERT INTO ItemSubcategory (name, category)
VALUES ('Laptops', 'Computers');

INSERT INTO ItemSubcategory (name, category)
VALUES ('Tablets', 'Computers');

-- Adding fields for categories

INSERT INTO CategoryField (name, category)
VALUES ('Processor', 'Computers');

INSERT INTO CategoryField (name, category)
VALUES ('GPU', 'Computers');

INSERT INTO CategoryField (name, category)
VALUES ('Memory', 'Computers');

INSERT INTO CategoryField (name, category, subcategory)
VALUES ('Screen Size', 'Computers', 'Tablets');

INSERT INTO CategoryField (name, category, subcategory)
VALUES ('Power Supply', 'Computers', 'Desktops');

-- Adding Questions

INSERT INTO Question (question,answer)
VALUES ('How do I pay my taxes?', 'You dont man.');

INSERT INTO Question (question,answer)
VALUES ('Do you guys sell food?', 'We do not sell anything, please messages sellers directly for info on what they sell.');

INSERT INTO Question (question,answer)
VALUES ('How do I send messages?', 'Go into Messages in the navbar and click the compose button.');

COMMIT;
