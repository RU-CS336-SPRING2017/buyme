DROP DATABASE IF EXISTS buymeDB;
CREATE DATABASE buymeDB;
USE buymeDB;

-- Represents an account that can either be an
-- admin, customer rep, or user.
CREATE TABLE Account (
    username VARCHAR(255),
    password VARCHAR(255) NOT NULL,
    type ENUM('admin', 'customerRep', 'user') NOT NULL,
    PRIMARY KEY (username)
);

-- Represents a message that can be sent from
-- one account to another. If any of the accounts
-- get deleted, the message remains.
CREATE TABLE Message (
    id BIGINT UNSIGNED AUTO_INCREMENT,
    subject VARCHAR(255) NOT NULL,
    text LONGTEXT,
    dateTime DATETIME NOT NULL,
    sentBy VARCHAR(255),
    receivedBy VARCHAR(255),
    PRIMARY KEY (id),
    FOREIGN KEY (sentBy)
        REFERENCES Account (username)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (receivedBy)
        REFERENCES Account (username)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- Represents a category of items that can be auctioned.
CREATE TABLE ItemCategory (
    name VARCHAR(255),
    PRIMARY KEY (name)
);

-- Represents a subcategory of a category.
CREATE TABLE ItemSubcategory (
    name VARCHAR(255),
    category VARCHAR(255),
    PRIMARY KEY (name, category),
    FOREIGN KEY (category)
        REFERENCES ItemCategory (name)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Represents a required field of a category or subcategory.
CREATE TABLE CategoryField (
    name VARCHAR(255),
    category VARCHAR(255),
    subcategory VARCHAR(255),
    PRIMARY KEY (name, category),
    FOREIGN KEY (category)
        REFERENCES ItemCategory (name)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (subcategory)
        REFERENCES ItemSubcategory (name)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Represents an auction that must comply with a
-- subcategory, and must have an auctioneer. Each
-- auction has a unique ID.
CREATE TABLE Auction (
    id BIGINT UNSIGNED AUTO_INCREMENT,
    openTime DATETIME NOT NULL,
    closeTime DATETIME NOT NULL,
    initialPrice DECIMAL(8,2) NOT NULL,
    bidIncrement DECIMAL(8,2) NOT NULL,
    minimumPrice DECIMAL(8,2),
    description LONGTEXT NOT NULL,
    auctioneer VARCHAR(255) NOT NULL,
    subcategory VARCHAR(255) NOT NULL,
    category VARCHAR(255) NOT NULL,
    title VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (auctioneer)
        REFERENCES Account (username)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (subcategory, category)
        REFERENCES ItemSubcategory (name, category)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Holds data for required fields in auctions.
CREATE TABLE AuctionField (
    auction BIGINT UNSIGNED,
    field VARCHAR(255),
    category VARCHAR(255),
    value VARCHAR(255),
    PRIMARY KEY (auction, field, category),
    FOREIGN KEY (auction)
        REFERENCES Auction (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (field, category)
        REFERENCES CategoryField (name, category)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Represent a bid that is identified by the
-- amount, bidder, and auction.
CREATE TABLE Bid (
    dateTime DATETIME NOT NULL,
    amount DECIMAL(8,2),
    bidder VARCHAR(255) NOT NULL,
    auction BIGINT UNSIGNED,
    PRIMARY KEY (amount, auction),
    FOREIGN KEY (bidder)
        REFERENCES Account (username)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (auction)
        REFERENCES Auction (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Represent an automatic bid that is identified by the
-- max amount, bidder, and auction.
CREATE TABLE AutoBid (
    max DECIMAL(8,2),
    bidder VARCHAR(255),
    auction BIGINT UNSIGNED,
    PRIMARY KEY (max, bidder, auction),
    FOREIGN KEY (bidder)
        REFERENCES Account (username)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (auction)
        REFERENCES Auction (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Makes sure new bids are higher then the
-- current max bid or initial bid
CREATE TRIGGER checkNewBid
BEFORE INSERT ON Bid
FOR EACH ROW
BEGIN
    SET
        @maxBid = (SELECT MAX(amount) FROM Bid WHERE auction=NEW.auction),
        @initialPrice = (SELECT initialPrice FROM Auction WHERE id=NEW.auction),
        @bidIncrement = (SELECT bidIncrement FROM Auction WHERE id=NEW.auction);
    IF NEW.amount < @initialPrice
    OR NEW.amount < @maxBid
    OR NEW.amount - @initialPrice < @bidIncrement
    OR NEW.amount - @maxBid < @bidIncrement
    THEN
        SET NEW.amount = NULL;
    END IF;
END;

-- Notify old winners when their bid
-- has been exceeded
CREATE TRIGGER notifyOldWinner
AFTER INSERT ON Bid
FOR EACH ROW
BEGIN
    SET
        @oldMaxBid = (
            SELECT MAX(amount) FROM Bid 
            WHERE auction=NEW.auction AND amount <> NEW.amount
        ),
        @oldWinner = (
            SELECT bidder FROM Bid
            WHERE auction=NEW.auction AND amount=@oldMaxBid
        ),
        @auctionTitle = (SELECT title FROM Auction WHERE id=NEW.auction);
    INSERT INTO Message (subject, text, dateTime, sentBy, receivedBy)
    VALUES (
        'Your bid has been exceeded',
        CONCAT(
            'Your winning bid of $', @oldMaxBid,
            ' for the auction <a href="/buyme/6/auction.jsp?id=',
            NEW.auction, '">', @auctionTitle, '</a> has been exceeded.'
        ),
        NOW(), 'admin', @oldWinner
    );
END;
