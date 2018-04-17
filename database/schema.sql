DROP DATABASE IF EXISTS BuyMe;
CREATE DATABASE BuyMe;
USE BuyMe;

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
    dateTime DATETIME NOT NULL DEFAULT NOW(),
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
    FOREIGN KEY (subcategory, category)
        REFERENCES ItemSubcategory (name, category)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Represents an auction that must comply with a
-- subcategory, and must have an auctioneer. Each
-- auction has a unique ID.
CREATE TABLE Auction (
    id BIGINT UNSIGNED AUTO_INCREMENT,
    openTime DATETIME NOT NULL DEFAULT NOW(),
    closeTime DATETIME NOT NULL,
    initialPrice DECIMAL(8,2) NOT NULL,
    bidIncrement DECIMAL(8,2) NOT NULL,
    minimumPrice DECIMAL(8,2),
    description LONGTEXT NOT NULL,
    auctioneer VARCHAR(255) NOT NULL,
    subcategory VARCHAR(255) NOT NULL,
    category VARCHAR(255) NOT NULL,
    title VARCHAR(255) NOT NULL,
    winner VARCHAR(255),
    winningBid DECIMAL(8,2),
    PRIMARY KEY (id),
    FOREIGN KEY (auctioneer)
        REFERENCES Account (username)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (subcategory, category)
        REFERENCES ItemSubcategory (name, category)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (winner)
        REFERENCES Account (username)
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
    dateTime DATETIME NOT NULL DEFAULT NOW(),
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
    max DECIMAL(8,2) NOT NULL,
    bidder VARCHAR(255),
    auction BIGINT UNSIGNED,
    PRIMARY KEY (bidder, auction),
    FOREIGN KEY (bidder)
        REFERENCES Account (username)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (auction)
        REFERENCES Auction (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Represents an alert a user makes on a
-- subcategory
CREATE TABLE Alert (
    user VARCHAR(255),
    category VARCHAR(255),
    subcategory VARCHAR(255),
    PRIMARY KEY (user, category, subcategory),
    FOREIGN KEY (user)
        REFERENCES Account (username)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (category, subcategory)
        REFERENCES ItemSubcategory (category, name)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Represents a field for an alert
CREATE TABLE AlertField (
    user VARCHAR(255),
    category VARCHAR(255),
    subcategory VARCHAR(255),
    field VARCHAR(255),
    value VARCHAR(255),
    PRIMARY KEY (user, category, subcategory, field, value),
    FOREIGN KEY (user, category, subcategory)
        REFERENCES Alert (user, category, subcategory)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (field, category)
        REFERENCES CategoryField (name, category)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Represents a question
CREATE TABLE Question (
    id BIGINT AUTO_INCREMENT,
    question LONGTEXT NOT NULL,
    answer LONGTEXT,
    PRIMARY KEY (id)
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
    OR NEW.amount < @maxBid + @bidIncrement
    THEN
        SET NEW.amount = NULL;
    END IF;
END;

-- Makes sure new auto bids are higher then the
-- current max bid or initial bid
CREATE TRIGGER checkNewAutoBid
BEFORE INSERT ON AutoBid
FOR EACH ROW
BEGIN
    SET
        @maxBid = (SELECT MAX(amount) FROM Bid WHERE auction=NEW.auction),
        @initialPrice = (SELECT initialPrice FROM Auction WHERE id=NEW.auction),
        @bidIncrement = (SELECT bidIncrement FROM Auction WHERE id=NEW.auction);
    IF NEW.max < @initialPrice
    OR NEW.max < @maxBid + @bidIncrement
    THEN
        SET NEW.bidder = NULL;
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
    IF @oldMaxBid IS NOT NULL THEN
        INSERT INTO Message (subject, text, sentBy, receivedBy)
        VALUES (
            'Your bid has been exceeded',
            CONCAT(
                'Your winning bid of $', @oldMaxBid,
                ' for the auction <a href="/buyme/6/auction.jsp?id=',
                NEW.auction, '">', @auctionTitle, '</a> has been exceeded.'
            ), 'admin', @oldWinner
        );
    END IF;
END;

-- Notifies all auto bidders whos max bids
-- were exceeded
CREATE TRIGGER notifyAutoBidders
AFTER INSERT ON Bid
FOR EACH ROW
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE autoBidder VARCHAR(255);
    DECLARE autoBidMax DECIMAL(8,2);
    DECLARE cur CURSOR FOR SELECT bidder, max FROM AutoBid
        WHERE auction = NEW.auction AND max < NEW.amount;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    SET @auctionTitle = (SELECT title FROM Auction WHERE id=NEW.auction);
    OPEN cur;
    message_loop: LOOP
        FETCH cur INTO autoBidder, autoBidMax;
        IF done THEN
        LEAVE message_loop;
        END IF;
        INSERT INTO Message (subject, text, sentBy, receivedBy)
        VALUES (
            'Your max bid has been exceeded',
            CONCAT(
                'Your max bid of $', autoBidMax,
                ' for the auction <a href="/buyme/6/auction.jsp?id=',
                NEW.auction, '">', @auctionTitle, '</a> has been exceeded.'
            ), 'admin', autoBidder
        ); 
    END LOOP;
    CLOSE cur;
END;

-- When a new auto bid is made,
-- insert the appropriate bid
CREATE TRIGGER bidOnAuto
AFTER INSERT ON AutoBid
FOR EACH ROW
BEGIN
    SET
        @bidIncrement = (SELECT bidIncrement FROM Auction WHERE id=NEW.auction),
        @initialPrice = (SELECT initialPrice from Auction WHERE id=NEW.auction),
        @maxBid = (SELECT MAX(amount) FROM Bid WHERE auction=NEW.auction),
        @maxAutobid = (SELECT MAX(max) FROM AutoBid WHERE auction=NEW.auction AND bidder<>NEW.bidder);
    IF @maxBid IS NULL THEN
        SET @newMaxBid = @initialPrice, @bidder = NEW.bidder;
    ELSEIF @maxAutobid IS NOT NULL THEN
        IF @maxAutoBid >= NEW.max THEN
            SET @bidder = (SELECT bidder FROM AutoBid WHERE max=@maxAutobid ORDER BY RAND() LIMIT 1);
            IF @maxAutobid >= NEW.max + @bidIncrement THEN
                SET @newMaxBid = NEW.max + @bidIncrement;
            ELSE
                SET @newMaxBid = @maxAutoBid;
            END IF;
        ELSEIF @maxAutoBid > @maxBid THEN
            SET @bidder = NEW.bidder;
            IF NEW.max >= @maxAutobid + @bidIncrement THEN
                SET @newMaxBid = @maxAutobid + @bidIncrement;
            ELSE
                SET @newMaxBid = NEW.max;
            END IF;
        END IF;
    ELSE
        SET @newMaxBid = @maxBid + @bidIncrement, @bidder = NEW.bidder;
    END IF;
    IF NEW.max >= @newMaxBid THEN
        INSERT INTO Bid (amount, bidder, auction)
        VALUES (@newMaxBid, @bidder, NEW.auction);
    END IF;
END;

-- Only allow new auctions where the close time
-- hasn't already passed
CREATE TRIGGER checkAuctionCloseTime
BEFORE INSERT ON Auction
FOR EACH ROW
BEGIN
    IF NEW.closeTime < NOW() THEN
        SET NEW.id = 'string';
    END IF;
END;

-- An event that runs each second
-- and ends auctions that have expired
CREATE EVENT auctionEnder
ON SCHEDULE EVERY 1 SECOND
DO BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE auctionId BIGINT UNSIGNED;
    DECLARE auctionTitle VARCHAR(255);
    DECLARE auctionMinimumPrice DECIMAL(8,2);
    DECLARE auctionAuctioneer VARCHAR(255);
    DECLARE cur CURSOR FOR SELECT id, title, minimumPrice, auctioneer FROM Auction WHERE closeTime <= NOW();
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cur;
    handle_loop: LOOP
        FETCH cur INTO auctionId, auctionTitle, auctionMinimumPrice, auctionAuctioneer;
        IF done THEN
        LEAVE handle_loop;
        END IF;
        SET
            @winnerBid = (SELECT MAX(amount) FROM Bid WHERE auction=auctionId),
            @winner = (SELECT bidder FROM Bid WHERE auction=auctionId AND amount=@winnerBid);
        IF @winnerBid IS NOT NULL THEN
            IF auctionMinimumPrice IS NULL OR @winnerBid > auctionMinimumPrice THEN
                UPDATE Auction SET winner=@winner, winningBid=@winnerBid WHERE id=auctionId;
            ELSE
                INSERT INTO Message (subject, text, sentBy, receivedBy)
                VALUES ('Your Auction Ended', CONCAT('The minimum price for your auction ', auctionTitle, ' was not reached.'), 'admin', auctionAuctioneer);
                DELETE FROM Auction WHERE id=auctionId;
            END IF;
        ELSE
            INSERT INTO Message (subject, text, sentBy, receivedBy)
            VALUES ('Your Auction Ended', CONCAT('No one bidded on your auction ', auctionTitle, '.'), 'admin', auctionAuctioneer);
            DELETE FROM Auction WHERE id=auctionId;
        END IF;
    END LOOP;
    CLOSE cur;
END;
