/*
	使用 UPDATE JOIN 進行 StockDailyTrandings 資料表的欄位更新
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

UPDATE [Stocks].[StockDailyTradings]
	SET [High] = b.[High]
		,[Low] = b.[Low]
		,[Volumn] = b.[Volumn]
	FROM [Stocks].[StockDailyTradings] a 
		INNER JOIN (
		SELECT [StockNo]
			,CONVERT(DATE,[TradeTime]) [TradeDate]
			,MIN([Price]) [Low]
			,MAX([Price]) [High]
			,SUM([Volumn]) [Volumn]
		FROM [Trades].[TradePerFiveSeconds]
		WHERE CONVERT(DATE,[TradeTime]) = '2018-12-13'
		GROUP BY CONVERT(DATE,[TradeTime])
			,[StockNo]
		) b ON a.[StockNo] = b.[StockNo]

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