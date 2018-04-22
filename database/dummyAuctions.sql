-- This script will add auctions that can be used to
-- show off search features.

USE BuyMe;

INSERT INTO Auction (closeTime,initialPrice,bidIncrement,description,auctioneer,subcategory,category,title)
VALUES (TIMESTAMPADD(WEEK,20,NOW()),10,20,'This is a dummy auction.','User2','Laptops','Computers','D Dummy Laptop 1 - The Sky is Blue');

INSERT INTO Auction (closeTime,initialPrice,bidIncrement,description,auctioneer,subcategory,category,title)
VALUES (TIMESTAMPADD(WEEK,7,NOW()),10,7,'This is a dummy auction.','User3','Desktops','Computers','H Dummy Desktop 1 - We the People');

INSERT INTO Auction (closeTime,initialPrice,bidIncrement,description,auctioneer,subcategory,category,title)
VALUES (TIMESTAMPADD(WEEK,8,NOW()),10,8,'This is a dummy auction.','User1','Tablets','Computers','G Dummy Tablet 1 - How Are You');

INSERT INTO Auction (closeTime,initialPrice,bidIncrement,description,auctioneer,subcategory,category,title)
VALUES (TIMESTAMPADD(WEEK,5,NOW()),10,5,'This is a dummy auction.','User1','Laptops','Computers','A Dummy Laptop 2 - Anything New');

INSERT INTO Auction (closeTime,initialPrice,bidIncrement,description,auctioneer,subcategory,category,title)
VALUES (TIMESTAMPADD(WEEK,3,NOW()),10,3,'This is a dummy auction.','User3','Desktops','Computers','F Dummy Desktop 2 - Ten Earths');

INSERT INTO Auction (closeTime,initialPrice,bidIncrement,description,auctioneer,subcategory,category,title)
VALUES (TIMESTAMPADD(WEEK,4,NOW()),10,4,'This is a dummy auction.','User2','Tablets','Computers','B Dummy Tablet 2 - Bubble Gum Tastes Good');

INSERT INTO Auction (closeTime,initialPrice,bidIncrement,description,auctioneer,subcategory,category,title)
VALUES (TIMESTAMPADD(WEEK,2,NOW()),10,2,'This is a dummy auction.','User3','Laptops','Computers','Dummy Laptop 3 - Give Us Max Points');

INSERT INTO Auction (closeTime,initialPrice,bidIncrement,description,auctioneer,subcategory,category,title)
VALUES (TIMESTAMPADD(WEEK,6,NOW()),10,6,'This is a dummy auction.','User2','Desktops','Computers','C Dummy Desktop 3 - We Are Good');

INSERT INTO Auction (closeTime,initialPrice,bidIncrement,description,auctioneer,subcategory,category,title)
VALUES (TIMESTAMPADD(WEEK,9,NOW()),10,9,'This is a dummy auction.','User1','Tablets','Computers','E Dummy Tablet 3 - You Are Safe');
