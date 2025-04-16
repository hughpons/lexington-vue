/**************************************************************************** 
* DevOps Story/Task #XXXXXX: Creates a database named SchoolDB
****************************************************************************/
USE master;
GO

IF DB_ID('SchoolDB') IS NOT NULL
BEGIN
	DROP DATABASE SchoolDB
END
GO

CREATE DATABASE SchoolDB
GO

USE SchoolDB;

/****** Creates object:  Schema [Lexington] ******/
IF (NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'Lexington'))
	EXEC sys.sp_executesql N'CREATE SCHEMA [Lexington] AUTHORIZATION [dbo]'
GO

/****** Creates object:  Schema [Universal] ******/
IF (NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'Universal'))
	EXEC sys.sp_executesql N'CREATE SCHEMA [Universal] AUTHORIZATION [dbo]'
GO