DROP DATABASE IF EXISTS superHeroDB ;
CREATE DATABASE superHeroDB;
USE superHeroDB;

CREATE TABLE Faction (
    factionId INT PRIMARY KEY AUTO_INCREMENT,
    factionName VARCHAR(10) NOT NULL
);

CREATE TABLE Location (
    locationId INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL ,
    description VARCHAR(255) NULL,
    country VARCHAR(60) NULL ,
    address VARCHAR(255) NULL ,
    city Varchar(50) NULL ,
    state char(2) NULL ,
    zipcode char(5) NULL ,
    latitude double(10,7) NULL ,
    longitude double(10,7) NULL
);

CREATE TABLE Power (
    powerId INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL ,
    description VARCHAR(255) NOT NULL
);

CREATE TABLE Organization (
    OrganizationId INT PRIMARY KEY AUTO_INCREMENT,
    factionId INT,
    name VARCHAR(100),
    description VARCHAR(255) NULL ,
    locationId INT NULL,
    phone CHAR(12) NULL ,
    email VARCHAR(100) NUll,
    FOREIGN KEY FK_Faction_factionId(factionId) REFERENCES Faction(factionId),
    FOREIGN KEY FK_Location_locationId(locationId) REFERENCES Location(locationId)

);

CREATE TABLE Super (
    superId INT PRIMARY KEY AUTO_INCREMENT,
    factionId INT NOT NULL,
    superName VARCHAR(30) NOT NULL ,
    description VARCHAR(255) NOT NULL,
    photo BLOB NULL,
    FOREIGN KEY FK_Super_factionId(factionId) REFERENCES Faction(factionId)
);

CREATE TABLE SuperOrganization (
    organizationId INT,
    superId INT,
    FOREIGN KEY FK_Organization_organizationId(organizationId) REFERENCES Organization(OrganizationId) ,
    FOREIGN KEY FK_Super_superId(superId) REFERENCES Super(superId)
);

CREATE TABLE PowerSuper (
    powerId INT,
    superId INT,
    FOREIGN KEY FK_PowerSuper_powerId(powerId) REFERENCES Power(powerId),
    FOREIGN KEY FK_PowerSuper_superId(superId) REFERENCES Super(superId)
);

CREATE TABLE Siting (
    sitingId INT PRIMARY KEY AUTO_INCREMENT,
    superId INT NOT NULL ,
    locationId INT NOT NULL ,
    description VARCHAR(255) NULL ,
    date DATE NOT NULL,
    FOREIGN KEY FK_Siting_superId(superId) REFERENCES Super(superId),
    FOREIGN KEY FK_Siting_locationId(locationId) REFERENCES Location(locationId)
);

INSERT INTO Faction (factionName) VALUES ('Hero'), ('Villain');


CREATE TABLE Users(
                      userID INT PRIMARY KEY AUTO_INCREMENT,
                      username VARCHAR(50) NOT NULL UNIQUE,
                      userPassword VARCHAR(60) NOT NULL,
                      enabled BOOLEAN NOT NULL
);

CREATE TABLE Roles(
                      roleID INT PRIMARY KEY AUTO_INCREMENT,
                      userRole VARCHAR(50) NOT NULL
);

CREATE TABLE Users_Roles(
                            userID INT NOT NULL,
                            roleID INT NOT NULL,
                            PRIMARY KEY(userID, roleID),
                            FOREIGN KEY (userID) REFERENCES Users(userID),
                            FOREIGN KEY (roleID) REFERENCES Roles(roleID)
);

INSERT INTO Users(userID, userName, userPassword, enabled) VALUES (1, "admin", "password", true);
INSERT INTO Users(userID, userName, userPassword, enabled) VALUES (2, "User1", "password", true);

INSERT INTO Roles(roleID, userRole) VALUES (1, "ROLE_ADMIN");
INSERT INTO Roles(roleID, userRole) VALUES (2, "ROLE_SIDEKICK");

INSERT INTO Users_Roles(userID, roleID) VALUES (1, 1);
INSERT INTO Users_Roles(userID, roleID) VALUES (1, 2);
INSERT INTO Users_Roles(userID, roleID) VALUES (2, 2);

UPDATE Users SET userPassword = '$2a$10$FZoRcPPwDCE0HSRoEVnTBuZcPOuWkyi.jjar2cwH.c0cVy4oqQpAS' WHERE userID = 1;
UPDATE Users SET userPassword = '$2a$10$FZoRcPPwDCE0HSRoEVnTBuZcPOuWkyi.jjar2cwH.c0cVy4oqQpAS' WHERE userID = 2;