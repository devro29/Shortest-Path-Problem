/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Customer]
      ,[NumberofPackages]
      ,[UOM]
      ,[Country]
      ,[Postalcode_First4digits]
  FROM [devro].[dbo].[kengrid]


  drop table Graph
  CREATE TABLE Graph (
   PA VARCHAR (10), 
   PB VARCHAR (10), 
   Distance INT not null
   ) 
GO
 
INSERT INTO Graph VALUES 
(NULL, 'Refs1', 0), 
('Refs1', 'Refs2', 19), 
('Refs1', 'Refs3', 14), 
('Refs1', 'Refs4', 17), 
('Refs1', 'Refs5', 11), 
('Refs1', 'Refs6', 28), 
('Refs1', 'Refs7', 22), 
('Refs1', 'Refs8', 15), 
('Refs1', 'Refs9', 37),
('Refs1', 'Refs10', 38),
('Refs2', 'Refs3', 18),
('Refs2', 'Refs4', 21),
('Refs2', 'Refs5', 24),
('Refs2', 'Refs6', 21),
('Refs2', 'Refs7', 16),
('Refs2', 'Refs8', 22),
('Refs2', 'Refs9', 25),
('Refs2', 'Refs10', 25),
('Refs3', 'Refs4', 24),
('Refs3', 'Refs5', 23),
('Refs3', 'Refs6', 16),
('Refs3', 'Refs7', 9),
('Refs3', 'Refs8', 5),
('Refs3', 'Refs9', 39),
('Refs3', 'Refs10', 40),
('Refs4', 'Refs5', 8),
('Refs4', 'Refs6', 35),
('Refs4', 'Refs7', 28),
('Refs4', 'Refs8', 26),
('Refs4', 'Refs9', 35),
('Refs4', 'Refs10', 37),
('Refs5', 'Refs6', 34),
('Refs5', 'Refs7', 28),
('Refs5', 'Refs8', 27),
('Refs5', 'Refs9', 38),
('Refs5', 'Refs10', 38),
('Refs6', 'Refs7', 8),
('Refs6', 'Refs8', 16),
('Refs6', 'Refs9', 31),
('Refs6', 'Refs10', 35),
('Refs7', 'Refs8', 8),
('Refs7', 'Refs9', 34),
('Refs7', 'Refs10', 36),
('Refs8', 'Refs9', 41),
('Refs8', 'Refs10', 56),
('Refs9', 'Refs10', 6)
GO 

SELECT *
FROM Graph;

drop procedure usp_FindShortestGraphPath

CREATE PROCEDURE usp_FindShortestGraphPath (@strt VARCHAR (10), @end VARCHAR (10))
AS
BEGIN
   SET NOCOUNT ON;
   WITH CommonTableExp1
   AS (SELECT PB,
         CASE 
            WHEN PA IS NULL
               THEN CAST ('-' + ISNULL (PA, PB) + '-' AS VARCHAR (MAX))
            WHEN PA IS NOT NULL
               THEN CAST ('-' + PA + '-' + PB + '-' AS VARCHAR (MAX))
            END FullPath,
         Distance TotalDistance
      FROM Graph
      WHERE (PA = @strt)
      UNION ALL
      SELECT a.PB,
         c.FullPath + '-' + a.PB + '-' FullPath,
         TotalDistance + a.Distance TotDistance
      FROM Graph a, CommonTableExp1 c
      WHERE a.PA = c.PB
      ),
   CommonTableExp2
   AS (SELECT *, RANK () OVER (ORDER BY TotalDistance) TheRank
      FROM CommonTableExp1
      WHERE PB = @end AND PATINDEX ('%' + @end + '%', FullPath) > 0)
   SELECT FullPath, TotalDistance
   FROM CommonTableExp2
   WHERE TheRank = 1;
   SET NOCOUNT OFF
END
GO



exec dbo.usp_FindShortestGraphPath 'Refs1', 'Refs2'
exec dbo.usp_FindShortestGraphPath 'Refs1', 'Refs3'
exec dbo.usp_FindShortestGraphPath 'Refs1', 'Refs4'
exec dbo.usp_FindShortestGraphPath 'Refs1', 'Refs5'
exec dbo.usp_FindShortestGraphPath 'Refs1', 'Refs6'
exec dbo.usp_FindShortestGraphPath 'Refs1', 'Refs7'
exec dbo.usp_FindShortestGraphPath 'Refs1', 'Refs8'
exec dbo.usp_FindShortestGraphPath 'Refs1', 'Refs9'
exec dbo.usp_FindShortestGraphPath 'Refs1', 'Refs10'

exec dbo.usp_FindShortestGraphPath 'Refs2', 'Refs3'
exec dbo.usp_FindShortestGraphPath 'Refs2', 'Refs4'
exec dbo.usp_FindShortestGraphPath 'Refs2', 'Refs5'
exec dbo.usp_FindShortestGraphPath 'Refs2', 'Refs6'
exec dbo.usp_FindShortestGraphPath 'Refs2', 'Refs7'
exec dbo.usp_FindShortestGraphPath 'Refs2', 'Refs8'
exec dbo.usp_FindShortestGraphPath 'Refs2', 'Refs9'
exec dbo.usp_FindShortestGraphPath 'Refs2', 'Refs10'

exec dbo.usp_FindShortestGraphPath 'Refs3', 'Refs4'
exec dbo.usp_FindShortestGraphPath 'Refs3', 'Refs5'
exec dbo.usp_FindShortestGraphPath 'Refs3', 'Refs6'
exec dbo.usp_FindShortestGraphPath 'Refs3', 'Refs7'
exec dbo.usp_FindShortestGraphPath 'Refs3', 'Refs8'
exec dbo.usp_FindShortestGraphPath 'Refs3', 'Refs9'
exec dbo.usp_FindShortestGraphPath 'Refs3', 'Refs10'

exec dbo.usp_FindShortestGraphPath 'Refs4', 'Refs5'
exec dbo.usp_FindShortestGraphPath 'Refs4', 'Refs6'
exec dbo.usp_FindShortestGraphPath 'Refs4', 'Refs7'
exec dbo.usp_FindShortestGraphPath 'Refs4', 'Refs8'
exec dbo.usp_FindShortestGraphPath 'Refs4', 'Refs9'
exec dbo.usp_FindShortestGraphPath 'Refs4', 'Refs10'

exec dbo.usp_FindShortestGraphPath 'Refs5', 'Refs6'
exec dbo.usp_FindShortestGraphPath 'Refs5', 'Refs7'
exec dbo.usp_FindShortestGraphPath 'Refs5', 'Refs8'
exec dbo.usp_FindShortestGraphPath 'Refs5', 'Refs9'
exec dbo.usp_FindShortestGraphPath 'Refs5', 'Refs10'

exec dbo.usp_FindShortestGraphPath 'Refs6', 'Refs7'
exec dbo.usp_FindShortestGraphPath 'Refs6', 'Refs8'
exec dbo.usp_FindShortestGraphPath 'Refs6', 'Refs9'
exec dbo.usp_FindShortestGraphPath 'Refs6', 'Refs10'

exec dbo.usp_FindShortestGraphPath 'Refs7', 'Refs8'
exec dbo.usp_FindShortestGraphPath 'Refs7', 'Refs9'
exec dbo.usp_FindShortestGraphPath 'Refs7', 'Refs10'

exec dbo.usp_FindShortestGraphPath 'Refs8', 'Refs9'
exec dbo.usp_FindShortestGraphPath 'Refs8', 'Refs10'

exec dbo.usp_FindShortestGraphPath 'Refs9', 'Refs10'


