USE BuyMe;

INSERT INTO Account (username, password, type)
VALUES ('admin', 'admin', 'admin');

INSERT INTO ItemCategory (name)
VALUES ('Drank');

INSERT INTO ItemSubcategory (name, categoy)
VALUES ('Wine', 'Drank');

INSERT INTO ItemSubcategory (name, categoy)
VALUES ('Juice', 'Drank');

INSERT INTO ItemSubcategory (name, categoy)
VALUES ('Soda', 'Drank');

INSERT INTO CategoryField (name, categoy, subcategory)
VALUES ('Fizz Level', 'Drank', 'Soda');
