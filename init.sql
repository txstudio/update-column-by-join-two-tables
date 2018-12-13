/*
--將既有 StockTrade 資料庫移除的指令碼
EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'StockTrade'
GO

USE [master]
GO

ALTER DATABASE [StockTrade]
	SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO

USE [master]
GO

DROP DATABASE [StockTrade]
GO
*/

/*
    建立 StockTrade 範例資料庫需要的資料表與預設資料內容
*/
CREATE DATABASE [StockTrade]
GO

/*
	此設定與 Azure SQL Database 相同
	https://blogs.msdn.microsoft.com/sqlcat/2013/12/26/be-aware-of-the-difference-in-isolation-levels-if-porting-an-application-from-windows-azure-sql-db-to-sql-server-in-windows-azure-virtual-machine/
*/

--啟用 SNAPSHOT_ISOLATION
ALTER DATABASE [StockTrade]
	SET ALLOW_SNAPSHOT_ISOLATION ON
GO

--啟用 READ_COMMITTED_SNAPSHOT
ALTER DATABASE [StockTrade]
	SET READ_COMMITTED_SNAPSHOT ON
	WITH ROLLBACK IMMEDIATE
GO

USE [StockTrade]
GO


CREATE SCHEMA [Stocks]
GO

CREATE SCHEMA [Trades]
GO

CREATE TABLE [Stocks].[StockMains]
(
	[No]		SMALLINT NOT NULL,
	
	[Code]		VARCHAR(6),
	[Name]		NVARCHAR(50),
	
	CONSTRAINT [pk_StockMains] PRIMARY KEY ([No]),
	
	CONSTRAINT [un_StockMains_Code] UNIQUE ([Code])
)
GO

INSERT INTO [Stocks].[StockMains]([No],[Code],[Name]) VALUES (1,'03086P',N'大立光元大83售15')
INSERT INTO [Stocks].[StockMains]([No],[Code],[Name]) VALUES (2,'089292',N'技嘉麥證84購03')
INSERT INTO [Stocks].[StockMains]([No],[Code],[Name]) VALUES (3,'032134',N'南電國泰85購01')
INSERT INTO [Stocks].[StockMains]([No],[Code],[Name]) VALUES (4,'089681',N'國巨國泰84購14')
INSERT INTO [Stocks].[StockMains]([No],[Code],[Name]) VALUES (5,'700700',N'頎邦國泰84購01')
GO

CREATE TABLE [Trades].[TradePerFiveSeconds]
(
	[No]			BIGINT,
	[TradeTime]		DATETIME,
	
	[StockNo]		SMALLINT,
	[Price]			SMALLMONEY,
	[Volumn]		SMALLINT,
	
	CONSTRAINT [pk_TradePerFiveSeconds]
		PRIMARY KEY ([No]),
		
	CONSTRAINT [fk_TradePerFiveSeconds_StockNo] FOREIGN KEY ([StockNo])
		REFERENCES [Stocks].[StockMains]([No])
)
GO

INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (1,'2018/12/13 09:00:00',4,1.17,1)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (2,'2018/12/13 09:00:25',1,2.03,10)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (3,'2018/12/13 09:00:25',4,1.26,2)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (4,'2018/12/13 09:00:30',4,1.08,25)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (5,'2018/12/13 09:00:35',5,1.51,4)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (6,'2018/12/13 09:00:35',5,1.67,9)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (7,'2018/12/13 09:00:50',1,2.02,10)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (8,'2018/12/13 09:00:50',5,1.61,66)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (9,'2018/12/13 09:00:55',3,1.71,30)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (10,'2018/12/13 09:01:00',5,1.68,30)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (11,'2018/12/13 09:01:00',4,1.45,10)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (12,'2018/12/13 09:01:05',5,1.54,2)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (13,'2018/12/13 09:01:05',4,1.11,3)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (14,'2018/12/13 09:01:15',1,2,6)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (15,'2018/12/13 09:01:20',1,2.01,5)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (16,'2018/12/13 09:01:25',4,1.34,10)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (17,'2018/12/13 09:01:25',1,2.01,10)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (18,'2018/12/13 09:01:30',5,1.51,4)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (19,'2018/12/13 09:01:35',5,1.49,20)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (20,'2018/12/13 09:01:35',5,1.52,20)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (21,'2018/12/13 09:01:45',1,1.92,10)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (22,'2018/12/13 09:01:45',3,1.85,25)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (23,'2018/12/13 09:01:50',5,1.68,11)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (24,'2018/12/13 09:01:50',1,2,40)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (25,'2018/12/13 09:01:50',4,1.43,20)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (26,'2018/12/13 09:01:50',1,2.01,50)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (27,'2018/12/13 09:01:55',5,1.68,1)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (28,'2018/12/13 09:02:10',1,2.02,5)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (29,'2018/12/13 09:02:10',1,2.02,5)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (30,'2018/12/13 09:02:10',5,1.68,14)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (31,'2018/12/13 09:02:30',4,1.08,100)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (32,'2018/12/13 09:02:35',5,1.66,20)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (33,'2018/12/13 09:02:35',1,2,32)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (34,'2018/12/13 09:02:35',4,1.08,100)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (35,'2018/12/13 09:02:40',3,1.89,11)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (36,'2018/12/13 09:02:50',1,1.96,2)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (37,'2018/12/13 09:02:55',1,2,10)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (38,'2018/12/13 09:03:05',4,1.36,1)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (39,'2018/12/13 09:03:10',1,1.98,4)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (40,'2018/12/13 09:03:10',1,2.02,4)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (41,'2018/12/13 09:03:15',4,1.24,1)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (42,'2018/12/13 09:03:15',1,2.02,5)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (43,'2018/12/13 09:03:15',3,1.71,7)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (44,'2018/12/13 09:03:20',3,1.87,3)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (45,'2018/12/13 09:03:20',1,2.01,10)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (46,'2018/12/13 09:03:20',5,1.53,3)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (47,'2018/12/13 09:03:25',1,1.98,6)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (48,'2018/12/13 09:03:40',4,1.08,3)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (49,'2018/12/13 09:03:40',1,2.05,4)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (50,'2018/12/13 09:03:40',5,1.66,2)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (51,'2018/12/13 09:03:50',3,1.86,6)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (52,'2018/12/13 09:03:50',4,1.17,100)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (53,'2018/12/13 09:03:55',4,1.08,25)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (54,'2018/12/13 09:03:55',4,1.08,5)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (55,'2018/12/13 09:04:05',1,1.93,1)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (56,'2018/12/13 09:04:10',1,2,13)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (57,'2018/12/13 09:04:20',4,1.11,1)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (58,'2018/12/13 09:04:20',1,1.99,1)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (59,'2018/12/13 09:04:20',3,1.86,3)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (60,'2018/12/13 09:04:25',3,1.85,22)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (61,'2018/12/13 09:04:30',5,1.52,52)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (62,'2018/12/13 09:04:30',1,2.03,5)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (63,'2018/12/13 09:04:30',4,1.09,3)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (64,'2018/12/13 09:04:35',4,1.21,1)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (65,'2018/12/13 09:04:45',1,2,20)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (66,'2018/12/13 09:04:50',1,2,5)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (67,'2018/12/13 09:04:50',1,2,94)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (68,'2018/12/13 09:04:55',5,1.83,10)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (69,'2018/12/13 09:05:05',1,1.97,1)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (70,'2018/12/13 09:05:05',4,1.38,10)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (71,'2018/12/13 09:05:05',4,1.13,3)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (72,'2018/12/13 09:05:05',5,1.78,10)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (73,'2018/12/13 09:05:10',1,2.01,5)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (74,'2018/12/13 09:05:15',1,2.03,1)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (75,'2018/12/13 09:05:15',5,1.51,29)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (76,'2018/12/13 09:05:15',1,1.94,15)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (77,'2018/12/13 09:05:25',1,2,10)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (78,'2018/12/13 09:05:30',5,1.66,1)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (79,'2018/12/13 09:05:35',5,1.52,3)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (80,'2018/12/13 09:05:35',5,1.59,1)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (81,'2018/12/13 09:05:40',5,1.57,19)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (82,'2018/12/13 09:05:45',1,2.01,7)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (83,'2018/12/13 09:05:50',1,2.02,7)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (84,'2018/12/13 09:05:55',1,2.02,20)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (85,'2018/12/13 09:06:00',1,1.99,5)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (86,'2018/12/13 09:06:05',2,0.45,100)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (87,'2018/12/13 09:06:05',2,0.4,349)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (88,'2018/12/13 09:06:15',1,2.02,20)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (89,'2018/12/13 09:06:20',5,1.84,10)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (90,'2018/12/13 09:06:25',5,1.68,50)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (91,'2018/12/13 09:06:40',1,2,25)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (92,'2018/12/13 09:06:40',1,2.02,16)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (93,'2018/12/13 09:06:45',1,2.01,5)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (94,'2018/12/13 09:06:50',4,1.14,11)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (95,'2018/12/13 09:07:00',5,1.85,10)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (96,'2018/12/13 09:07:05',1,1.99,4)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (97,'2018/12/13 09:07:10',3,1.6,10)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (98,'2018/12/13 09:07:25',1,1.98,10)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (99,'2018/12/13 09:07:30',5,1.82,10)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (100,'2018/12/13 09:07:35',5,1.79,10)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (101,'2018/12/13 09:07:50',5,1.88,10)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (102,'2018/12/13 09:07:50',1,2.03,10)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (103,'2018/12/13 09:08:00',1,2.02,20)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (104,'2018/12/13 09:08:00',1,2.05,10)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (105,'2018/12/13 09:08:00',5,1.6,19)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (106,'2018/12/13 09:08:05',1,2.02,2)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (107,'2018/12/13 09:08:05',4,1.1,12)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (108,'2018/12/13 09:08:05',1,2.03,5)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (109,'2018/12/13 09:08:05',4,1.27,10)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (110,'2018/12/13 09:08:10',1,2.02,5)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (111,'2018/12/13 09:08:15',1,2,5)
INSERT INTO [Trades].[TradePerFiveSeconds]([No],[TradeTime],[StockNo],[Price],[Volumn]) VALUES (112,'2018/12/13 09:08:20',1,2.02,8)
GO

CREATE TABLE [Stocks].[StockDailyTradings]
(
	[TradeDate]		DATE,
	[StockNo]		SMALLINT,
	
	[High]			SMALLMONEY,
	[Low]			SMALLMONEY,
	[Volumn]		INT,
	
	CONSTRAINT [pk_StockDailyTradings]
		PRIMARY KEY ([TradeDate],[StockNo]),
		
	CONSTRAINT [fk_StockDailyTradings_StockNo] FOREIGN KEY ([StockNo])
		REFERENCES [Stocks].[StockMains]([No])
)
GO

INSERT INTO [Stocks].[StockDailyTradings]([TradeDate],[StockNo]) VALUES ('2018/12/13',1)
INSERT INTO [Stocks].[StockDailyTradings]([TradeDate],[StockNo]) VALUES ('2018/12/13',2)
INSERT INTO [Stocks].[StockDailyTradings]([TradeDate],[StockNo]) VALUES ('2018/12/13',3)
INSERT INTO [Stocks].[StockDailyTradings]([TradeDate],[StockNo]) VALUES ('2018/12/13',4)
INSERT INTO [Stocks].[StockDailyTradings]([TradeDate],[StockNo]) VALUES ('2018/12/13',5)
GO

