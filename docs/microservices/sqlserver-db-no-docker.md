# **Create Your First Database with SQL Server**

## Introduction

SQL Server is a popular relational database management system (RDBMS) developed by Microsoft and widely used in the industry. It serves as a database server that stores and retrieves data as requested by other software applications, whether on the same computer or a remote one, using the client-server model.

In this lab, I will explain fundamental database concepts and provide practical examples covering the creation of a SQL Server, designing databases, creating tables, inserting and retrieving data, deleting records, and finally, dropping an existing database.

## Databases concepts

**Database**

A database in SQL Server is made up of a collection of tables that stores a specific set of structured data. A table contains a collection of rows, also referred to as records or tuples, and columns, also referred to as attributes. Each column in the table is designed to store a certain type of information, for example, dates, names, dollar amounts, and numbers.

**SQL (Structured Query Language)**


Structured query language (SQL) is a programming language for storing and processing information in a relational database. A relational database stores information in tabular form, with rows and columns representing different data attributes and the various relationships between the data values.

## SQL Server Management Studio (SSMS)

SQL Server Management Studio (SSMS) is a powerful and comprehensive integrated environment for managing SQL Server databases, Developed by Microsoft. SSMS provides a graphical user interface (GUI) that allows database administrators, application developers, and any IT users to interact with SQL Server databases efficiently.

**Features SSMS:**

_Database Object Explorer_: SSMS provides a hierarchical view of all database objects, including tables, views, stored procedures, and more. This makes it easy to navigate and manage database structures.

_Query Editor_: The Query Editor is a robust tool for writing and executing Transact-SQL (T-SQL) queries. It includes features like syntax highlighting, IntelliSense for code completion, and debugging tools.

_Connect_: Click the "Connect" button to establish a connection to the SQL Server instance.

Once connected, you can start exploring and managing the databases, execute queries, and utilize the various features of SSMS to administer and optimize your SQL Server environment


## Create Azure SQL Server

In Chapter 2, we'll explore the creation of an Azure SQL Server as part of the Infrastructure as Code (IaC). However, for immediate guidance, here are step-by-step instructions for manually creating an Azure SQL Server using the Azure Portal.


   - Open your web browser and go to the [Azure portal](https://portal.azure.com/).
   - Sign in with your Azure account.
   - In the left-hand navigation pane, click on "Create a resource."
   - In the "Search" box, type "SQL server."
   - Select "SQL server" from the results.
   - In the "SQL server" pane, click the "Create" button.
   - Fill in the required information:
      - _Subscription_: Choose your Azure subscription.
      - _Resource group_: Create a new one or select an existing resource group.
      - _Server name_: Choose a unique server name.
      - _Data source_: Choose "None" for a new server.
      - _Server admin login_: Enter a username for the server administrator.
      - _Password_: Enter a strong password for the server administrator.
      - _Location_: Choose the region where you want to deploy the server.
   - Configure the networking settings, including:
      - _Networking rule_: Allow access to Azure services and resources.
      - _Firewall rules_: Configure the firewall rules to allow access to the server from specific IP addresses if needed.
   - Configure advanced settings (optional):
   - You can configure additional settings like the version of SQL Server, storage, and backup options on this page. Adjust these settings according to your requirements.
   - Click the "Review + create" button.
   - Click the "Create" button to start the deployment.


## Creating your first database

Follow these step-by-step instruction to create your first sql server database.

create database using SSMS:

1. Open SQL Server Management Studio (SSMS).
2. Connect to your SQL Server instance.
3. In Object Explorer, right-click "Databases" and select "New Database."
4. Name it "database1" and configure optional settings.
5. Click "OK" to create the database.
6. Verify its creation in Object Explorer under "Databases."

create database using SQL query:

```sql
CREATE DATABASE database1;
```

## Creating Tables


Here I am going to show you a sample table called `Article`.

The purpose of the `Article` table is to store information related to articles.
This table is designed to capture details about individual articles and their associated metadata such as content display, publication tracking, modification history etc...

Now let's create an `Article` table within the database1
```sql
CREATE TABLE [dbo].[Article]
(
	[Id]				INT					IDENTITY (1, 1) NOT NULL PRIMARY KEY,	
	[Title]			    NVARCHAR (100)		NOT NULL,	-- Title shown on card
	[Description]		NVARCHAR (256)		NOT NULL,	-- Description shown on card and article page	
	[CoverImage]		NVARCHAR (100)		NOT NULL,	-- Image unique key after uploaded on blob
	[Content]		   	NVARCHAR (MAX)		NOT NULL,	-- Article actual content
	[PublishedDate]		DATETIME2			NOT NULL DEFAULT GETDATE(), -- Date on which article will be published on app
	[IsDeleted]			BIT					NOT NULL DEFAULT 0,	-- Flag for hiding the article on the page.
	[ModifiedBy]		NVARCHAR(100)		NOT NULL DEFAULT 'System',  -- Who modified the contents
	[ModifiedDate]		DATETIME2			NOT NULL DEFAULT GETDATE(), -- Audit purpose
	CONSTRAINT FK_ModifiedBy FOREIGN KEY (ModifiedBy) REFERENCES [dbo].[Users] (UserName) -- Example of a foreign key
);

```
_Primary Key_:

The `Id` column is defined as the primary key with the PRIMARY KEY constraint. This ensures each row has a unique identifier.

_Foreign Key_:

A foreign key (FK_ModifiedBy) is an example linking the ModifiedBy column to a reference table (Users). This is commonly used to maintain referential integrity between tables.

## Inserting Data

To insert data into the `Article` table you've created, you can use the `INSERT INTO` statement. Here are sample SQL queries to demonstrate the insertion of records:

```sql
-- Inserting a basic article without modification information
INSERT INTO [dbo].[Article] ([Title], [Description], [CoverImage], [Content], [PublishedDate])
VALUES ('Introduction to SQL', 'A brief overview of SQL', 'sql_intro.jpg', 'This is the content of the SQL introduction article.', GETDATE());

-- Inserting an article with modification information
INSERT INTO [dbo].[Article] ([Title], [Description], [CoverImage], [Content], [PublishedDate], [IsDeleted], [ModifiedBy], [ModifiedDate])
VALUES ('Advanced SQL Techniques', 'Exploring advanced SQL concepts', 'advanced_sql.jpg', 'In-depth exploration of advanced SQL techniques.', GETDATE(), 0, 'AdminUser', GETDATE());

-- Inserting an article with deletion flag
INSERT INTO [dbo].[Article] ([Title], [Description], [CoverImage], [Content], [PublishedDate], [IsDeleted], [ModifiedBy], [ModifiedDate])
VALUES ('Hidden Article', 'This article is hidden', 'hidden_article.jpg', 'Content of the hidden article.', GETDATE(), 1, 'EditorUser', GETDATE());
```

## Retrieving Data

The `SELECT` statement is used to retrieve data from one or more tables in a database. It allows you to specify the columns you want to retrieve, filter the rows based on specific conditions, sort the results, and perform various other operations. 


Basic `SELECT` Statement:


```sql
SELECT column1, column2, ...
FROM table_name;
```


To retrieve all columns from the `Article` table:

```sql
SELECT *
FROM [dbo].[Article];
```

To retrieve specific columns, such as `Title` and `PublishedDate`:

```sql
SELECT [Title], [PublishedDate]
FROM [dbo].[Article];
```

To filter rows based on a condition, you use the `WHERE` clause. For example, retrieving articles where the `IsDeleted` flag is set to 0:

```sql
SELECT [Title], [Description], [PublishedDate]
FROM [dbo].[Article]
WHERE [IsDeleted] = 0;
```

To sort the results in ascending or descending order, you use the `ORDER BY` clause. For example, retrieving articles sorted by `PublishedDate` in descending order:

```sql
SELECT [Title], [Description], [PublishedDate]
FROM [dbo].[Article]
ORDER BY [PublishedDate] DESC;
```

You can combine filtering and sorting in a single query. For example, retrieving titles and descriptions of non-deleted articles sorted by `PublishedDate`:

```sql
SELECT [Title], [Description], [PublishedDate]
FROM [dbo].[Article]
WHERE [IsDeleted] = 0
ORDER BY [PublishedDate] DESC;
```

## Deleting Data

To delete data from a table, you use the `DELETE` statement. Here's the basic syntax:

```sql
DELETE FROM table_name
WHERE condition;
```

For example, to delete an article with a specific title:

```sql
DELETE FROM [dbo].[Article]
WHERE [Title] = 'Introduction to SQL';
```


Deleting All Data

To `delete all` data from a table without deleting the table structure itself, you can use the following query:

```sql
DELETE FROM [dbo].[Article];
```

## Dropping a Database

Dropping a database removes the entire database and all its objects (tables, views, stored procedures, etc.).

The syntax for dropping a database is as follows:

```sql
DROP DATABASE database_name;
```

For example, to drop the "database1" database:

```sql
DROP DATABASE database1;
```

Before dropping a database, it is necessary to ensure that there are no active connections to the database. 



## Reference
- [Microsoft MSDN - Create a database](https://learn.microsoft.com/en-us/sql/relational-databases/databases/create-a-database?view=sql-server-ver16){:target="_blank"}