USE master;
GO

-- Create SampleDB
CREATE DATABASE SampleDB;
GO

USE SampleDB;
GO

-- Create Users table
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username NVARCHAR(50),
    Email NVARCHAR(100)
);
GO

-- Insert some sample data into Users table
INSERT INTO Users (UserID, Username, Email) VALUES (1, 'user1', 'user1@example.com');
INSERT INTO Users (UserID, Username, Email) VALUES (2, 'user2', 'user2@example.com');
INSERT INTO Users (UserID, Username, Email) VALUES (3, 'user3', 'user3@example.com');
GO
