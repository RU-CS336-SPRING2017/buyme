-- This script will add auctions that can be used to
-- show off search features.

USE BuyMe;

START TRANSACTION;
INSERT INTO Auction (closeTime,initialPrice,bidIncrement,description,auctioneer,subcategory,category,title,id)
VALUES (TIMESTAMPADD(WEEK,20,NOW()),10,20,'This is a dummy auction.','User2','Laptops','Computers','D Dummy Laptop 1 - The Sky is Blue',2001);
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2001,'Processor','Computers','1');
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2001,'GPU','Computers','1');
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2001,'Memory','Computers','1');
COMMIT;

START TRANSACTION;
INSERT INTO Auction (closeTime,initialPrice,bidIncrement,description,auctioneer,subcategory,category,title,id)
VALUES (TIMESTAMPADD(WEEK,7,NOW()),10,7,'This is a dummy auction.','User3','Desktops','Computers','H Dummy Desktop 1 - We the People',2002);
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2002,'Processor','Computers','1');
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2002,'GPU','Computers','1');
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2002,'Memory','Computers','1');
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2002,'Power Supply','Computers','1');
COMMIT;

START TRANSACTION;
INSERT INTO Auction (closeTime,initialPrice,bidIncrement,description,auctioneer,subcategory,category,title,id)
VALUES (TIMESTAMPADD(WEEK,8,NOW()),10,8,'This is a dummy auction.','User1','Tablets','Computers','G Dummy Tablet 1 - How Are You',2003);
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2003,'Processor','Computers','1');
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2003,'GPU','Computers','1');
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2003,'Memory','Computers','1');
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2003,'Screen Size','Computers','1');
COMMIT;

START TRANSACTION;
INSERT INTO Auction (closeTime,initialPrice,bidIncrement,description,auctioneer,subcategory,category,title,id)
VALUES (TIMESTAMPADD(WEEK,5,NOW()),10,5,'This is a dummy auction.','User1','Laptops','Computers','A Dummy Laptop 2 - Anything New',2004);
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2004,'Processor','Computers','1');
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2004,'GPU','Computers','1');
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2004,'Memory','Computers','1');
COMMIT;

START TRANSACTION;
INSERT INTO Auction (closeTime,initialPrice,bidIncrement,description,auctioneer,subcategory,category,title,id)
VALUES (TIMESTAMPADD(WEEK,3,NOW()),10,3,'This is a dummy auction.','User3','Desktops','Computers','F Dummy Desktop 2 - Ten Earths',2005);
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2005,'Processor','Computers','1');
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2005,'GPU','Computers','1');
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2005,'Memory','Computers','1');
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2005,'Power Supply','Computers','1');
COMMIT;

START TRANSACTION;
INSERT INTO Auction (closeTime,initialPrice,bidIncrement,description,auctioneer,subcategory,category,title,id)
VALUES (TIMESTAMPADD(WEEK,4,NOW()),10,4,'This is a dummy auction.','User2','Tablets','Computers','B Dummy Tablet 2 - Bubble Gum Tastes Good',2006);
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2006,'Processor','Computers','1');
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2006,'GPU','Computers','1');
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2006,'Memory','Computers','1');
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2006,'Screen Size','Computers','1');
COMMIT;

START TRANSACTION;
INSERT INTO Auction (closeTime,initialPrice,bidIncrement,description,auctioneer,subcategory,category,title,id)
VALUES (TIMESTAMPADD(WEEK,2,NOW()),10,2,'This is a dummy auction.','User3','Laptops','Computers','Dummy Laptop 3 - Give Us Max Points',2007);
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2007,'Processor','Computers','1');
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2007,'GPU','Computers','1');
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2007,'Memory','Computers','1');
COMMIT;

START TRANSACTION;
INSERT INTO Auction (closeTime,initialPrice,bidIncrement,description,auctioneer,subcategory,category,title,id)
VALUES (TIMESTAMPADD(WEEK,6,NOW()),10,6,'This is a dummy auction.','User2','Desktops','Computers','C Dummy Desktop 3 - We Are Good',2008);
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2008,'Processor','Computers','1');
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2008,'GPU','Computers','1');
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2008,'Memory','Computers','1');
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2008,'Power Supply','Computers','1');
COMMIT;

START TRANSACTION;
INSERT INTO Auction (closeTime,initialPrice,bidIncrement,description,auctioneer,subcategory,category,title,id)
VALUES (TIMESTAMPADD(WEEK,9,NOW()),10,9,'This is a dummy auction.','User1','Tablets','Computers','E Dummy Tablet 3 - You Are Safe',2009);
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2009,'Processor','Computers','1');
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2009,'GPU','Computers','1');
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2009,'Memory','Computers','1');
INSERT INTO AuctionField (auction,field,category,value)
VALUES (2009,'Screen Size','Computers','1');
COMMIT;
