/*
	使用 CURSOR 進行 StockDailyTrandings 資料表的欄位更新
*/
BEGIN TRANSACTION

SELECT b.[No]
	,b.[Code]
	,b.[Name]
	,a.[TradeDate]
	,a.[High]
	,a.[Low]
	,a.[Volumn]
FROM [Stocks].[StockDailyTradings] a
	INNER JOIN [Stocks].[StockMains] b
		ON a.[StockNo] = b.[No]

DECLARE @StockNo		SMALLINT
DECLARE @TradeDate		DATE
DECLARE @Low			SMALLMONEY
DECLARE @High			SMALLMONEY
DECLARE @Volumn			INT

DECLARE DAILY_CURSOR CURSOR FOR
	SELECT [StockNo]
		,CONVERT(DATE,[TradeTime]) [TradeDate]
		,MIN([Price]) [Low]
		,MAX([Price]) [High]
		,SUM([Volumn]) [Volumn]
	FROM [Trades].[TradePerFiveSeconds]
	WHERE CONVERT(DATE,[TradeTime]) = '2018-12-13'
	GROUP BY CONVERT(DATE,[TradeTime])
		,[StockNo]

OPEN DAILY_CURSOR

FETCH NEXT FROM DAILY_CURSOR
	INTO @StockNo,@TradeDate,@Low,@High,@Volumn

WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE [Stocks].[StockDailyTradings]
		SET [Low] = @Low
			,[High] = @High
			,[Volumn] = @Volumn
	WHERE [StockNo] = @StockNo
		AND [TradeDate] = @TradeDate

	FETCH NEXT FROM DAILY_CURSOR
		INTO @StockNo,@TradeDate,@Low,@High,@Volumn
END

CLOSE DAILY_CURSOR
DEALLOCATE DAILY_CURSOR

SELECT b.[No]
	,b.[Code]
	,b.[Name]
	,a.[TradeDate]
	,a.[High]
	,a.[Low]
	,a.[Volumn]
FROM [Stocks].[StockDailyTradings] a
	INNER JOIN [Stocks].[StockMains] b
		ON a.[StockNo] = b.[No]

ROLLBACK TRANSACTION