USE BuyMe;

INSERT INTO Account (username, password, type)
VALUES ('admin', 'admin', 'admin');

INSERT INTO Account (username, password, type)
VALUES ('rep', 'rep', 'customerRep');

INSERT INTO Account (username, password, type)
VALUES ('fun', 'time', 'user');

INSERT INTO Account (username, password, type)
VALUES ('hey', 'there', 'user');

INSERT INTO ItemCategory (name)
VALUES ('Drank');

INSERT INTO ItemSubcategory (name, category)
VALUES ('Wine', 'Drank');

INSERT INTO ItemSubcategory (name, category)
VALUES ('Juice', 'Drank');

INSERT INTO ItemSubcategory (name, category)
VALUES ('Soda', 'Drank');

INSERT INTO CategoryField (name, category, subcategory)
VALUES ('Fizz Level', 'Drank', 'Soda');
