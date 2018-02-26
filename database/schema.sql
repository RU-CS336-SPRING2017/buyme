DROP DATABASE IF EXISTS BuyMe;
CREATE DATABASE BuyMe;
USE BuyMe;

CREATE TABLE Account (
	username VARCHAR(255),
    password VARCHAR(255) NOT NULL,
    type ENUM('admin', 'customerRep', 'user') NOT NULL,
    PRIMARY KEY (username)
);

CREATE TABLE Message (
	id BIGINT UNSIGNED AUTO_INCREMENT,
    subject VARCHAR(255),
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

CREATE TABLE ItemCategory (
	name VARCHAR(255),
    PRIMARY KEY (name)
);

CREATE TABLE ItemSubcategory (
	name VARCHAR(255),
    category VARCHAR(255),
    PRIMARY KEY (name, category),
    FOREIGN KEY (category)
		REFERENCES ItemCategory (name)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE CategoryField (
	name VARCHAR(255),
    value VARCHAR(255),
    category VARCHAR(255),
    PRIMARY KEY (name, category),
    FOREIGN KEY (category)
		REFERENCES ItemCategory (name)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE fieldOfSubcategory (
	field VARCHAR(255),
    category VARCHAR(255),
    subcategory VARCHAR(255),
    PRIMARY KEY (field, subcategory, category),
    FOREIGN KEY (field, category)
		REFERENCES CategoryField (name, category)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (subcategory, category)
		REFERENCES ItemSubcategory (name, category)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Auction (
	id BIGINT UNSIGNED AUTO_INCREMENT,
    openTime DATETIME NOT NULL,
    closeTime DATETIME NOT NULL,
    currentBid DECIMAL(8,2),
    bidIncrement DECIMAL(8,2) NOT NULL,
    description LONGTEXT,
    auctioneer VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (auctioneer)
		REFERENCES Account (username)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Bid (
	dateTime DATETIME NOT NULL,
    amount DECIMAL(8,2),
    bidder VARCHAR(255),
    auction BIGINT UNSIGNED,
    PRIMARY KEY (amount, bidder, auction),
    FOREIGN KEY (bidder)
		REFERENCES Account (username)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (auction)
		REFERENCES Auction (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
