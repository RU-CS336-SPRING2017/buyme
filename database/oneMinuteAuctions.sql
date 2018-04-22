USE BuyMe;

INSERT INTO Auction (closeTime,initialPrice,bidIncrement,description,auctioneer,subcategory,category,title,id)
VALUES (TIMESTAMPADD(MINUTE,1,NOW()),60,20,'This is a dummy auction.','User1','Laptops','Computers','One Minute Laptop - One Bid - No Minimum',1001);

INSERT INTO Bid (amount,bidder,auction)
VALUES (62.32,'User2',1001);

INSERT INTO Auction (closeTime,initialPrice,bidIncrement,description,auctioneer,subcategory,category,title, minimumPrice,id)
VALUES (TIMESTAMPADD(MINUTE,1,NOW()),55,7,'This is a dummy auction.','User2','Desktops','Computers','One Minute Desktop - Two Bids - $80 Minimum',80,1002);

INSERT INTO Bid (amount,bidder,auction)
VALUES (55,'User1',1002);

INSERT INTO Bid (amount,bidder,auction)
VALUES (81.3,'User3',1002);

INSERT INTO Auction (closeTime,initialPrice,bidIncrement,description,auctioneer,subcategory,category,title,id)
VALUES (TIMESTAMPADD(MINUTE,1,NOW()),51,5,'This is a dummy auction.','User1','Tablets','Computers','One Minute Tablet - No Bids - No Minimum',1003);

INSERT INTO Auction (closeTime,initialPrice,bidIncrement,description,auctioneer,subcategory,category,title,id,minimumPrice)
VALUES (TIMESTAMPADD(MINUTE,1,NOW()),70,5,'This is a dummy auction.','User3','Tablets','Computers','One Minute Tablet - 5 Bids - $100 Minimum',1004,100);

INSERT INTO Bid (amount,bidder,auction)
VALUES (70,'User1',1004);

INSERT INTO Bid (amount,bidder,auction)
VALUES (82.63,'User2',1004);

INSERT INTO Bid (amount,bidder,auction)
VALUES (90,'User1',1004);

INSERT INTO Bid (amount,bidder,auction)
VALUES (99,'User2',1004);

INSERT INTO Bid (amount,bidder,auction)
VALUES (104,'User1',1004);
