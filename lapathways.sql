USE [C80]
GO
/****** Object:  StoredProcedure [dbo].[AnswerOptions_SelectAll]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[AnswerOptions_SelectAll]
				@PageIndex int,  
				@PageSize int 
AS
/*
		Declare 
		@PageIndex int=0, 
		@PageSize int=10

		EXEC dbo.AnswerOptions_SelectAll
		@PageIndex, 
		@PageSize;

*/
BEGIN
		Declare @Offset int = @PageIndex * @PageSize
		SELECT
				[Id],
				[Name],
				

				TotalCount = COUNT(1) OVER()
		FROM
				[dbo].[AnswerOptions]

		ORDER BY Id  

		OFFSET @offSet Rows
		Fetch Next @pageSize Rows ONLY
		
				

END
GO
/****** Object:  StoredProcedure [dbo].[CapitalTypes_SelectAll]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[CapitalTypes_SelectAll]
				
AS
/* ------------ TEST CODE -----------------

		EXECUTE dbo.CapitalTypes_SelectAll
	
*/ 
BEGIN
         
		SELECT	[Id] 
			   ,[Code]
			   ,[Name]

        FROM dbo.CapitalTypes

        ORDER BY CapitalTypes.Id

END
GO
/****** Object:  StoredProcedure [dbo].[CategoryTypes_SelectAll]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[CategoryTypes_SelectAll]

AS

/* ---------- TEST CODE ----------

Execute dbo.CategoryTypes_SelectAll

*/

BEGIN

	SELECT [Id]
		  ,[Code]
	      ,[Name]
		  ,[GroupName]

	FROM [dbo].[CategoryTypes]

	ORDER BY CategoryTypes.Id

END


GO
/****** Object:  StoredProcedure [dbo].[ComplianceTypes_Insert]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ComplianceTypes_Insert] @Code NVARCHAR(10), 
                                          @Name NVARCHAR(100), 
                                          @Id   INT OUTPUT
AS

/*--------------TEST CODE -------------------

Declare @Code nvarchar(10) = 'COM7'
		,@Name nvarchar(100) = 'AndAnotherThing'
		,@Id int = 0

Execute dbo.ComplianceTypes_Insert
		@Code
		,@Name
		,@Id OUTPUT

Select @Id
Select *
From dbo.ComplianceTypes
Where Id = @Id

*/

    BEGIN
        INSERT INTO dbo.ComplianceTypes
        ([Code], 
         [Name]
        )
        VALUES
        (@Code, 
         @Name
        );
        SET @Id = SCOPE_IDENTITY();
    END;
GO
/****** Object:  StoredProcedure [dbo].[ComplianceTypes_SelectAll]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ComplianceTypes_SelectAll] 
AS

/* ------------- TEST CODE ------------



Execute dbo.ComplianceTypes_SelectAll



*/

    BEGIN
    
        SELECT [Id], 
               [Code], 
               [Name]

        FROM [dbo].[ComplianceTypes]

        ORDER BY ComplianceTypes.Id
 
    END;
GO
/****** Object:  StoredProcedure [dbo].[ConsultingTypes_SelectAll]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ConsultingTypes_SelectAll]
AS

/*


		EXEC dbo.ConsultingTypes_SelectAll


*/

    BEGIN
        SELECT [Id], 
               [Code], 
               [Name]
        FROM [dbo].[ConsultingTypes]
        ORDER BY Id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ContractingTypes_SelectAll]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ContractingTypes_SelectAll]

AS
/*
EXECUTE [dbo].[ContractingTypes_SelectAll]
*/

SELECT [Id]
      ,[Code]
      ,[Name]
  FROM [dbo].[ContractingTypes]
GO
/****** Object:  StoredProcedure [dbo].[Conversations_DeleteById]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Conversations_DeleteById]
		@User1Id int


AS
/*
TEST CODE

DECLARE @User1Id int = 123


Execute dbo.Conversations_DeleteById
		@User1Id


Select*
From dbo.Conversations

*/
BEGIN


DELETE FROM [dbo].[Conversations]
      WHERE [User1Id] = @User1Id
	  OR [User2Id] = @User1Id



END


GO
/****** Object:  StoredProcedure [dbo].[Conversations_DeleteByIdPair]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Conversations_DeleteByIdPair]
		@User1Id int,
		@User2Id int

AS
/*
TEST CODE

DECLARE @User1Id int = 124
		,@User2Id int = 123

Execute dbo.Conversations_DeleteByIdPair
		@User1Id
		,@User2Id

Select*
From dbo.Conversations

*/
BEGIN
    DECLARE @User1 INT = 0
            ,@User2 INT = 0
 
    IF (@User1Id < @User2Id)
		BEGIN
			SET @User1 =@User1Id
			SET	@User2 = @User2Id;
		END
	ELSE
	BEGIN
		SET @User1 =@User2Id
		SET	@User2 = @User1Id;
	END

DELETE FROM [dbo].[Conversations]
      WHERE [User1Id] = @User1
	  AND [User2Id] = @User2



END


GO
/****** Object:  StoredProcedure [dbo].[Conversations_Insert]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Proc [dbo].[Conversations_Insert]
			@User1Id int
			,@User2Id int
			,@Conversation nvarchar(MAX)
AS

/*
Test Code

DECLARE @User1Id int = 159
		,@User2Id int = 123
		,@Conversation nvarchar(MAX) = 'some conversation'

EXECUTE [dbo].[Conversations_Insert]
			@User1Id,
			@User2Id,
			@Conversation 

		SELECT *
		From [dbo].[Conversations]
*/

BEGIN

    DECLARE @User1 int = 0
            ,@User2 int = 0
 
    IF (@User1Id < @User2Id)
		BEGIN
			SET @User1 =@User1Id
			SET	@User2 = @User2Id;
		END
	ELSE
		BEGIN
			SET @User1 =@User2Id
			SET	@User2 = @User1Id;
		END



INSERT INTO [dbo].[Conversations]
           ([User1Id]
           ,[User2Id]
           ,[Conversation])
     VALUES
           (@User1
           ,@User2
           ,@Conversation)


END
GO
/****** Object:  StoredProcedure [dbo].[Conversations_SelectByUserId]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Conversations_SelectByUserId]
		@User1Id int


AS

/*
DECLARE @User1Id int = 123


EXECUTE dbo.Conversations_SelectByUserId
		@User1Id 



*/

BEGIN
SELECT [User1Id]
      ,[User2Id]
      ,[Conversation]
      ,[DateCreated]
      ,[DateModified]
  FROM [dbo].[Conversations]
  WHERE [User1Id] = @User1Id
		OR [User2Id] = @User1Id

END


GO
/****** Object:  StoredProcedure [dbo].[Conversations_SelectByUserIdPair]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Conversations_SelectByUserIdPair]
		@User1Id int
		,@User2Id int


AS

/*
DECLARE @User1Id int = 159
		,@User2Id int = 123


EXECUTE dbo.Conversations_SelectByUserIdPair
		@User1Id 
		,@User2Id 


SELECT *
FROM dbo.Conversations

*/

BEGIN

	
    DECLARE @User1 int = 0
            ,@User2 int = 0
 
    IF (@User1Id < @User2Id)
		BEGIN
			SET @User1 =@User1Id
			SET	@User2 = @User2Id;
		END
	ELSE
		BEGIN
			SET @User1 =@User2Id
			SET	@User2 = @User1Id;
		END



SELECT [User1Id]
      ,[User2Id]
      ,[Conversation]
      ,[DateCreated]
      ,[DateModified]
  FROM [dbo].[Conversations]
  WHERE [User1Id] = @User1
		And [User2Id] = @User2
END


GO
/****** Object:  StoredProcedure [dbo].[Conversations_SelectByUserIdPairPaginated]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Conversations_SelectByUserIdPairPaginated]
		@User1Id int
		,@User2Id int
		,@pageIndex int
		,@pageSize int

AS

/*
DECLARE @User1Id int = 159
		,@User2Id int = 123
		,@pageIndex int = 0
		,@pageSize int = 2

EXECUTE dbo.[Conversations_SelectByUserIdPairPaginated]
		@User1Id 
		,@User2Id 
		,@pageIndex
		,@pageSize 

SELECT *
FROM dbo.Conversations

*/

BEGIN

	
    DECLARE @User1 int = 0
            ,@User2 int = 0
			,@offSet int = @pageIndex * @pageSize
 
    IF (@User1Id < @User2Id)
		BEGIN
			SET @User1 =@User1Id
			SET	@User2 = @User2Id;
		END
	ELSE
		BEGIN
			SET @User1 =@User2Id
			SET	@User2 = @User1Id;
		END


DECLARE @json NVARCHAR(MAX)

SET @json=(
SELECT [Conversation] 
  FROM [dbo].[Conversations]
  WHERE [User1Id] = @User1
		And [User2Id] = @User2)

SELECT UserId
	   ,Message
	   ,DateCreated
	   	,TotalCount = COUNT(1) OVER()
FROM OPENJSON(@json)

WITH (UserId   int '$.userId' ,  
	Message nvarchar(MAX) '$.message', 
    DateCreated nvarchar(max) '$.dateCreated') 

	ORDER BY DateCreated DESC

	OFFSET @offSet ROWS
	FETCH NEXT @pageSize ROWS ONLY

END


GO
/****** Object:  StoredProcedure [dbo].[Conversations_SelectByUserIdPairPaginatedSearch]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Conversations_SelectByUserIdPairPaginatedSearch]
		@User1Id int
		,@User2Id int
		,@pageIndex int
		,@pageSize int
		,@Query nvarchar(250)

AS

/*
DECLARE @User1Id int = 159
		,@User2Id int = 123
		,@pageIndex int = 0
		,@pageSize int = 2
		,@Query nvarchar(250) = 'who'

EXECUTE dbo.[Conversations_SelectByUserIdPairPaginatedSearch]
		@User1Id 
		,@User2Id 
		,@pageIndex
		,@pageSize 
		,@Query

SELECT *
FROM dbo.Conversations

*/

BEGIN

	
    DECLARE @User1 int = 0
            ,@User2 int = 0
			,@offSet int = @pageIndex * @pageSize
 
    IF (@User1Id < @User2Id)
		BEGIN
			SET @User1 =@User1Id
			SET	@User2 = @User2Id;
		END
	ELSE
		BEGIN
			SET @User1 =@User2Id
			SET	@User2 = @User1Id;
		END


DECLARE @json NVARCHAR(MAX)

SET @json=(
SELECT [Conversation] 
  FROM [dbo].[Conversations]
  WHERE [User1Id] = @User1
		And [User2Id] = @User2)

SELECT [UserId]
	   ,[Message]
	   ,[DateCreated]
	   ,[TotalCount] = COUNT(1) OVER()

FROM OPENJSON(@json)
WITH (UserId int '$.userId' ,  
	Message nvarchar(MAX) '$.message', 
    DateCreated nvarchar(max) '$.dateCreated') 

			
WHERE([UserId] LIKE '%' + @Query + '%'
	OR [Message] LIKE '%' + @Query + '%'
	OR [DateCreated] LIKE '%' + @Query + '%')

	ORDER BY DateCreated DESC

	OFFSET @offSet ROWS
	FETCH NEXT @pageSize ROWS ONLY

END


GO
/****** Object:  StoredProcedure [dbo].[Conversations_Update]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Proc [dbo].[Conversations_Update]
			@User1Id int,
			@User2Id int,
			@Conversation nvarchar(MAX)
AS

/*
Test Code

DECLARE @User1Id int = 123
		,@User2Id int = 159
		,@Conversation nvarchar(MAX) = 'test code'

		EXECUTE dbo.Conversations_Update
			@User1Id 
			,@User2Id 
			,@Conversation 

		Select *
		FROM dbo.Conversations
*/

BEGIN

    DECLARE @User1 int = 0
            ,@User2 int = 0
 
    IF (@User1Id < @User2Id)
		BEGIN
			SET @User1 =@User1Id
			SET	@User2 = @User2Id;
		END
	ELSE
		BEGIN
			SET @User1 =@User2Id
			SET	@User2 = @User1Id;
		END

DECLARE @DateModified datetime2(7) =	GETUTCDATE()

UPDATE [dbo].[Conversations]
   SET [User1Id] = @User1 
      ,[User2Id] = @User2 
      ,[Conversation] = @Conversation 
     
      ,[DateModified] = @DateModified
 WHERE  [User1Id] = @User1
 AND [User2Id] = @User2

 END
GO
/****** Object:  StoredProcedure [dbo].[DemographicTypes_SelectAll]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DemographicTypes_SelectAll]
AS

/* ------------ TEST CODE -----------------

		EXECUTE dbo.DemographicTypes_SelectAll


*/

    BEGIN
        SELECT [Id], 
               [Code],
			   [Name]
        FROM dbo.DemographicTypes
        ORDER BY DemographicTypes.Id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Events_DeleteById]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Events_DeleteById]
	@Id int

as

/*
Declare @Id int = 1

Select * 
FROM dbo.Events
WHERE Id = @Id

Execute dbo.Events_DeleteById
	@Id

Select * 
FROM dbo.Events
Where Id = @Id

*/
BEGIN

DELETE FROM [dbo].[Events]
      WHERE Id = @Id
END


GO
/****** Object:  StoredProcedure [dbo].[Events_Insert]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Events_Insert]
		@Id int Output
		,@EventTypeId int
		,@Name nvarchar(225)
		,@Summary nvarchar(255)
		,@ShortDescription nvarchar(4000)
		,@VenueId int
		,@EventStatusId int
		,@ImageUrl nvarchar(400)
		,@ExternalSiteUrl nvarchar(400)
		,@IsFree bit
		,@DateStart DateTime2(7)
		,@DateEnd DateTime2(7)

AS
/*
Declare
		 @Id int,
		 @EventTypeId int = 1
		,@Name nvarchar(225) = 'Irvine Fund Raiser'
		,@Summary nvarchar(255) = 'irvine Annual Sabio Fund Raiser'
		,@ShortDescription nvarchar(4000) = 'Expirience Hackathons to raise Funds for Education'
		,@VenueId int = 1
		,@EventStatusId int = 1
		,@ImageUrl nvarchar(400) = 'https://bit.ly/2P75c6e'
		,@ExternalSiteUrl nvarchar(400) = 'https://business.lacity.org/'
		,@IsFree bit = 1
		,@DateStart datetime2(7) = '10/25/2019'
		,@DateEnd datetime2(7) = '10/30/2019'


Execute dbo.Events_Insert
		@Id OUT
		,@EventTypeId 
		,@Name
		,@Summary
		,@ShortDescription
		,@VenueId
		,@EventStatusId
		,@ImageUrl
		,@ExternalSiteUrl
		,@IsFree
		,@DateStart
		,@DateEnd

SELECT *
FROM dbo.Events



*/
BEGIN
INSERT INTO [dbo].[Events]
           ([EventTypeId]
           ,[Name]
           ,[Summary]
           ,[ShortDescription]
           ,[VenueId]
           ,[EventStatusId]
           ,[ImageUrl]
           ,[ExternalSiteUrl]
           ,[IsFree]
		   ,[DateStart]
		   ,[DateEnd])
     VALUES
           (@EventTypeId
           ,@Name
           ,@Summary
           ,@ShortDescription
           ,@VenueId
           ,@EventStatusId
           ,@ImageUrl
           ,@ExternalSiteUrl
           ,@IsFree
		   ,@DateStart
		   ,@DateEnd)
	SET @Id = SCOPE_IDENTITY()
END


GO
/****** Object:  StoredProcedure [dbo].[Events_Insert_V2]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc  [dbo].[Events_Insert_V2]
			--VENUE
			@Id int OUTPUT,
			@VenueName nvarchar(225),
			@Description nvarchar(4000),
			@Url nvarchar(225),
			@VenueCreatedBy int, 
			@ModifiedBy int, 
			
			--LOCATION
			@LocationId int OUTPUT,
			@LocationTypeId int,
			@LineOne  nvarchar(255) ,
			@LineTwo  nvarchar(255),
			@City  nvarchar(225) ,
			@Zip  nvarchar(50),
			@StateId  int ,
			@Latitude float ,
			@Longitude  float,
			@CreatedBy  int,

            
			--EVENT
			@EventTypeId int,
			@Name nvarchar(225),
			@Summary nvarchar(255),
			@ShortDescription nvarchar(4000),
			@VenueId int,
			@EventStatusId int,
			@ImageUrl nvarchar(400), 
			@ExternalSiteUrl nvarchar(400),
			@IsFree bit
			
AS
/*----TEST CODE----
DECLARE  	
			@Id int,
			@VenueName nvarchar(225) = 'Sabio Multi Insert Venue1',
			@Description nvarchar(4000) = 'Sabio Venue Description',
			@Url nvarchar(225) = 'www.sabioVenues.com',
			@VenueCreatedBy int = 8, 
			@ModifiedBy int = 8, 

			@LocationId int,
			@LocationTypeId int = 1,
			@LineOne  nvarchar(255) = '200 sabio street' ,
			@LineTwo  nvarchar(255) = '',
			@City  nvarchar(225) = 'Irvine',
			@Zip  nvarchar(50) = '55555',
			@StateId  int = 6,
			@Latitude float = 31.4511,
			@Longitude  float = -75.1524,
			@CreatedBy  int = 8,

			@EventTypeId int = 1,
			@Name nvarchar(225) = 'Zach v.3',
			@Summary nvarchar(255) = 'A Sabio Event Insert v.2',
			@ShortDescription nvarchar(4000) = 'multi proc insert',
			@VenueId int= 10,
			@EventStatusId int= 1,
			@ImageUrl nvarchar(400) = 'image tag',
			@ExternalSiteUrl nvarchar(400) = 'www.sabioVenues.com',
			@IsFree bit = 1

EXECUTE dbo.Locations_Insert
			@LocationId OUTPUT,
			@LocationTypeId,
			@LineOne,
			@LineTwo,
			@City,
			@Zip,
			@StateId,
			@Latitude,
			@Longitude,
			@CreatedBy

EXECUTE dbo.Venues_Insert
	     	@VenueId,
			@VenueName,
			@Description,
			@LocationId, 
			@Url,
			@VenueCreatedBy, 
			@ModifiedBy

EXECUTE dbo.Events_Insert_V2
			@Id OUTPUT,
			@EventTypeId,
			@Name,
			@Summary,
			@ShortDescription,
			@VenueId,
			@EventStatusId,
			@ImageUrl,
			@ExternalSiteUrl,
			@IsFree


SELECT *
FROM dbo.EventTypes

Select *
FROM dbo.Venues 

Select * 
FROM dbo.Locations

-------------------*/
BEGIN

EXECUTE [dbo].[Locations_Insert]
			@LocationId OUTPUT,
			@LocationTypeId,
			@LineOne,
			@LineTwo,
			@City,
			@Zip,
			@StateId,
			@Latitude,
			@Longitude,
			@CreatedBy 
			
EXECUTE [dbo].[Venues_Insert]
			@VenueId  OUTPUT,
			@VenueName,
			@Description,
			@LocationId,
			@Url,
			@VenueCreatedBy,
			@ModifiedBy

EXECUTE [dbo].[Events_Insert]
			@Id OUTPUT,
			@EventTypeId, 
			@Name,
			@Summary,
			@ShortDescription,
			@VenueId,
			@EventStatusId,
			@ImageUrl,
			@ExternalSiteUrl,
			@IsFree
END


GO
/****** Object:  StoredProcedure [dbo].[Events_SelectAll]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Events_SelectAll]
	@PageIndex int
	,@PageSize int
			


as
/*
DECLARE @PageIndex int = 0 
		,@PageSize int = 4
		

EXECUTE dbo.Events_SelectAll
		@PageIndex
		,@PageSize
	

*/
BEGIN
DECLARE @offset int = @PageIndex * @PageSize;
SELECT [Id]
      ,[EventTypeId]
      ,[Name]
      ,[Summary]
      ,[ShortDescription]
      ,[VenueId]
      ,[EventStatusId]
      ,[ImageUrl]
      ,[ExternalSiteUrl]
      ,[IsFree]
      ,[DateCreated]
      ,[DateModified]
      ,[DateStart]
      ,[DateEnd]
	  ,TotalCount = COUNT (1) OVER()
  FROM [dbo].[Events]
  ORDER BY [Events].Id desc
  OFFSET @offset ROWS
  FETCH NEXT @PageSize ROWS ONLY

END


GO
/****** Object:  StoredProcedure [dbo].[Events_SelectAllDetails]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  proc [dbo].[Events_SelectAllDetails] 
			@pageIndex int = 0,
			@pageSize int = 20
AS
/*-----TEST CODE------

DECLARE		@pageIndex int = 0,
			@pageSize int = 20

EXECUTE dbo.Events_SelectAllDetails
			@pageIndex,
			@pageSize

*/--------------------
BEGIN

Declare @offset int = @pageIndex * @pageSize

	SELECT  E.[Id],
			E.[EventTypeId],
			E.[Name],
			E.[Summary],
			E.[ShortDescription],
			E.[VenueId],
			E.[EventStatusId],
			E.[ImageUrl],
			E.[ExternalSiteUrl],
			E.[IsFree],
			E.[DateCreated],
			E.[DateModified],
			E.[DateStart],
			E.[DateEnd],
			ET.[Name] AS EventType,
			ES.[Name] AS EventStatus,
			V.[Name] AS VenueName,
			V.[Description],
			L.[LocationTypeId],
			L.[LineOne],
			L.[City],
			L.[StateId],
			L.[Zip],
			TotalCount = COUNT(1) OVER() 

  FROM [dbo].[Events] as E  
  JOIN dbo.EventTypes as ET on ET.Id = E.EventTypeId
  JOIN dbo.EventStatus as ES on ES.Id = ET.Id
  JOIN dbo.Venues as V on V.Id = E.VenueId
  Join dbo.Locations as L on L.Id = V.LocationId
  ORDER BY E.Id
  OFFSET @offset Rows 
  Fetch Next @pageSize Rows ONLY




  
END


GO
/****** Object:  StoredProcedure [dbo].[Events_SelectById]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Events_SelectById]
	@Id int
as
/*
Declare 
	@Id int = 1
	

Execute dbo.Events_SelectById
	@Id

*/
BEGIN

SELECT [Id]
      ,[EventTypeId]
      ,[Name]
      ,[Summary]
      ,[ShortDescription]
      ,[VenueId]
      ,[EventStatusId]
      ,[ImageUrl]
      ,[ExternalSiteUrl]
      ,[IsFree]
      ,[DateCreated]
      ,[DateModified]
      ,[DateStart]
      ,[DateEnd]
  FROM [dbo].[Events]
  WHERE ID = @Id
END


GO
/****** Object:  StoredProcedure [dbo].[Events_SelectDetails_ById]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc  [dbo].[Events_SelectDetails_ById] 
			@Id int

AS
/*------TEST CODE-------------------------------------
DECLARE @Id int = 2;
EXECUTE [dbo].[Events_SelectDetails_ById] @Id

*/-----------------------------------------------------
BEGIN

SELECT E.[Id],
       E.[EventTypeId],
       E.[Name],
       E.[Summary],
       E.[ShortDescription],
       E.[VenueId],
       E.[EventStatusId],
       E.[ImageUrl],
       E.[ExternalSiteUrl],
       E.[IsFree],
       E.[DateCreated],
       E.[DateModified],
       E.[DateStart],
       E.[DateEnd],
	   ET.[Name] AS EventType,
	   ES.[Name] AS EventStatus,
	   V.[Name] AS VenueName,
	   V.[Description],
	   L.[LocationTypeId],
	   L.[LineOne],
	   L.[City],
	   L.[StateId],
	   L.[Zip]

  FROM [dbo].[Events] as E 
  JOIN dbo.EventTypes as ET on ET.Id = E.EventTypeId
  JOIN dbo.EventStatus as ES on ES.Id = ET.Id
  JOIN dbo.Venues as V on V.Id = E.VenueId
  Join dbo.Locations as L on L.Id = V.LocationId
  WHERE E.Id = @Id 

 END


GO
/****** Object:  StoredProcedure [dbo].[Events_Update]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Events_Update]
	@Id int
	,@EventTypeId int
	,@Name nvarchar(255)
	,@Summary nvarchar(255)
	,@ShortDescription nvarchar(255)
	,@VenueId int
	,@EventStatusId int
	,@ImageUrl nvarchar(400)
	,@ExternalSiteUrl nvarchar(400)
	,@IsFree bit
	,@dateStart datetime2(7)
	,@dateEnd datetime2(7)
	
as
/*
Declare
	 @Id int = 5
	,@EventTypeId int = 1
	,@Name nvarchar(255) = 'Sabio Fund Raiser'
	,@Summary nvarchar(255) = 'Sabio Fund Raiser'
	,@ShortDescription nvarchar(255) = 'Irvine spectrum Sabio Annual Fund Raiser'
	,@VenueId int = 1
	,@EventStatusId int = 1
	,@ImageUrl nvarchar(400) = 'https://bit.ly/35QdIfV'
	,@ExternalSiteUrl nvarchar(400) = 'https://bit.ly/35QdIfV'
	,@IsFree bit = 1
	,@dateStart datetime2(7) = '10/25/2019'
	,@dateEnd datetime2(7) = '10/29/2019'

Select *
From dbo.Events
Where Id = @Id

Execute dbo.Events_Update
	@Id
	,@EventTypeId
	,@Name
	,@Summary
	,@ShortDescription
	,@VenueId
	,@EventStatusId 
	,@ImageUrl
	,@ExternalSiteUrl
	,@IsFree
	,@dateStart 
	,@dateEnd 

Select *
From dbo.Events
Where Id = @Id

*/
BEGIN

DECLARE @DateModified datetime2(7) = GETUTCDATE();

UPDATE [dbo].[Events]
   SET [EventTypeId] = @EventTypeId
      ,[Name] = @Name
      ,[Summary] = @Summary
      ,[ShortDescription] = @ShortDescription
      ,[VenueId] = @VenueId
      ,[EventStatusId] = @EventStatusId
      ,[ImageUrl] = @ImageUrl
      ,[ExternalSiteUrl] = @ExternalSiteUrl
      ,[IsFree] = @IsFree
	  ,[dateStart] = @dateStart 
	  ,[dateEnd] = @dateEnd
      ,[DateModified] = @DateModified

 WHERE Id = @Id
END


GO
/****** Object:  StoredProcedure [dbo].[Events_Update_V2]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Events_Update_V2]
--Locations
@Id               INT, 
@LocationTypeId   INT, 
@LineOne          NVARCHAR(255), 
@LineTwo          NVARCHAR(255), 
@City             NVARCHAR(225), 
@Zip              NVARCHAR(50), 
@StateId          INT, 
@Latitude         FLOAT, 
@Longitude        FLOAT, 
@ModifiedBy       INT,
--Venues 
@VenuesId         INT,
@VenueName        NVARCHAR(255), 
@Description      NVARCHAR(4000), 
@LocationId       INT, 
@Url              NVARCHAR(255), 
@VenueModifiedBy  INT,
--Events 
@EventTypeId      INT, 
@EventName        NVARCHAR(255), 
@Summary          NVARCHAR(255), 
@ShortDescription NVARCHAR(255), 
@VenueId          INT, 
@EventStatusId    INT, 
@ImageUrl         NVARCHAR(400), 
@ExternalSiteUrl  NVARCHAR(400), 
@IsFree           BIT
AS
/*---Test Code---

DECLARE 
	@Id               INT = 1, 
	@LocationTypeId   INT = 1, 
	@LineOne          NVARCHAR(255) = 'Testing', 
	@LineTwo          NVARCHAR(255) = 'Testing', 
	@City             NVARCHAR(225) = 'Irvine', 
	@Zip              NVARCHAR(50) = 'String', 
	@StateId          INT = 1, 
	@Latitude         FLOAT = 1, 
	@Longitude        FLOAT = 1, 
	@ModifiedBy		  INT = 1,

	@VenuesId         INT = 1,
	@VenueName        NVARCHAR(255) = 'Cool Venue', 
	@Description      NVARCHAR(4000) = 'Discription', 
	@LocationId       INT = 1, 
	@Url              NVARCHAR(255) = 'Test URL', 
	@VenueModifiedBy  INT = 1,

	@EventTypeId      INT = 1, 
	@EventName        NVARCHAR(255) = 'EventName', 
	@Summary          NVARCHAR(255) = 'Summary', 
	@ShortDescription NVARCHAR(255) = 'A Short Discription', 
	@VenueId          INT = 1, 
	@EventStatusId    INT = 1, 
	@ImageUrl         NVARCHAR(400) = ' A Image Url', 
	@ExternalSiteUrl  NVARCHAR(400) = 'AN External Site Location', 
	@IsFree           BIT = 1

EXECUTE [dbo].[Events_Update_V2]
	@Id               
	,@LocationTypeId   
	,@LineOne         
	,@LineTwo         
	,@City           
	,@Zip             
	,@StateId         
	,@Latitude       
	,@Longitude        
	,@ModifiedBy   
	
	,@VenuesId      
	,@VenueName        
	,@Description    
	,@LocationId       
	,@Url            
	,@VenueModifiedBy 

	,@EventTypeId      
	,@EventName        
	,@Summary           
	,@ShortDescription  
	,@VenueId          
	,@EventStatusId    
	,@ImageUrl         
	,@ExternalSiteUrl  
	,@IsFree

SELECT *
FROM [dbo].[Locations]

SELECT *
FROM [dbo].[Venues]

SELECT *
FROM [dbo].[Users]
	
*/ ---Test Code---

    BEGIN
        DECLARE @DateModified DATETIME2(7)= GETUTCDATE();
        UPDATE [dbo].[Locations]
          SET 
              [LocationTypeId] = @LocationTypeId, 
              [LineOne] = @LineOne, 
              [LineTwo] = @LineTwo, 
              [City] = @City, 
              [Zip] = @Zip, 
              [StateId] = @StateId, 
              [Latitude] = @Latitude, 
              [Longitude] = @Longitude, 
              [ModifiedBy] = @ModifiedBy, 
              [DateModified] = @DateModified
        WHERE Id = @Id;
        UPDATE [dbo].[Venues]
          SET 
              [Name] = @VenueName, 
              [Description] = @Description, 
              [LocationId] = @LocationId, 
              [Url] = @Url, 
              [ModifiedBy] = @VenueModifiedBy
        WHERE Id = @Id;
        UPDATE [dbo].[Events]
          SET 
              [EventTypeId] = @EventTypeId, 
              [Name] = @EventName, 
              [Summary] = @Summary, 
              [ShortDescription] = @ShortDescription, 
              [VenueId] = @VenueId, 
              [EventStatusId] = @EventStatusId, 
              [ImageUrl] = @ImageUrl, 
              [ExternalSiteUrl] = @ExternalSiteUrl, 
              [IsFree] = @IsFree;
    END;
GO
/****** Object:  StoredProcedure [dbo].[EventStatus_SelectAll]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[EventStatus_SelectAll]
AS

/*
Execute dbo.EventStatus_SelectAll
*/

    BEGIN
        SELECT [Id], 
               [Name]
        FROM [dbo].[EventStatus];
    END;
GO
/****** Object:  StoredProcedure [dbo].[EventTypes_SelectAll]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[EventTypes_SelectAll] @pageIndex INT, 
                                    @pageSize  INT
AS

/*

DECLARE @pageIndex INT= 0, @pageSize INT= 2;
EXECUTE dbo.EventTypes_SelectAll 
        @pageIndex, 
        @pageSize;

*/

    BEGIN
        DECLARE @offset INT= @pageIndex * @pageSize;
        SELECT [Id], 
               [Name], 
               TotalCount = COUNT(1) OVER()
        FROM [dbo].[EventTypes]
        ORDER BY EventTypes.Id
        OFFSET @offset ROWS FETCH NEXT @pageSize ROWS ONLY;
    END;
GO
/****** Object:  StoredProcedure [dbo].[FAQ_DeleteById]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[FAQ_DeleteById]
		@Id int 
as
-------Test Code--------
/*
DECLARE @Id int = ???

	SELECT *
	FROM dbo.FAQ
	WHERE Id = @Id

	EXECUTE dbo.FAQ_DeleteById @Id

	SELECT *
	FROM dbo.People
	WHERE Id = @Id
*/

BEGIN
		DELETE FROM [dbo].[FAQ]
		WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[FAQ_Insert]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[FAQ_Insert]
		@Id int out,
		@Question nvarchar(255),
		@Answer nvarchar(2000),
		@CategoryId int,
		@SortOrder int,
		@CreatedBy int,
		@ModifiedBy int
as		
/*------ Test Code -------

Declare @Id int = 0;

	Declare  
			@Question nvarchar(255) = 'How do I find something?',
			@Answer nvarchar(2000) = 'Use the search bar!',
			@CategoryId int = 1,
			@SortOrder int = 1,
			@CreatedBy int = 1,
			@ModifiedBy int = 1

	Execute [dbo].[FAQ_Insert]
			@Id,
			@Question,
			@Answer,
			@CategoryId,
			@SortOrder,
			
			@CreatedBy,
			@ModifiedBy 

	Select *
	From dbo.FAQ
	

*/
BEGIN

INSERT INTO [dbo].[FAQ]
		(
		[Question],
		[Answer],
		[CategoryId],
		[SortOrder],
	
		[CreatedBy],
		[ModifiedBy])

     VALUES 
        (
		@Question,
		@Answer,
		@CategoryId,
		@SortOrder,
		
		@CreatedBy,
		@ModifiedBy)
           
		SET @Id = SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [dbo].[FAQ_Select_ByCreatedBy]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[FAQ_Select_ByCreatedBy]
										@CreatedBy int
										,@pageIndex int
										,@pageSize int
AS
/* ---Test Code ---

DECLARE @CreatedBy int = 1,
		@pageIndex int = 0,
		@pageSize int = 10
				
EXECUTE dbo.FAQ_Select_ByCreatedBy 
		@CreatedBy,
		@pageIndex,
		@pageSize


*/
BEGIN
			SELECT
				[Id],
				[Question],
				[Answer],
				[CategoryId],
				[SortOrder],
				[DateCreated],
				[DateModified],
				[CreatedBy],
				[ModifiedBy]

			FROM
				[dbo].[FAQ]
			WHERE 
				CreatedBy = @CreatedBy
END
GO
/****** Object:  StoredProcedure [dbo].[FAQ_SelectAll]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[FAQ_SelectAll] @pageIndex INT, 
                                 @pageSize  INT
AS

/* ------------ TEST CODE -----------------

		DECLARE 
				@pageIndex int = 0,
			    @pageSize int = 5

		EXECUTE dbo.FAQ_SelectAll
				 @pageIndex,
				 @pageSIze

*/

    BEGIN
        DECLARE @offset INT= @pageIndex * @pageSize;
        SELECT [Id], 
		       [Question], 
               [Answer], 
               [CategoryId], 
               [SortOrder], 
               [CreatedBy], 
               [ModifiedBy],
			   [DateCreated], 
               [DateModified],
               TotalCount = COUNT(1) OVER()
        FROM dbo.FAQ
        ORDER BY Id DESC
        OFFSET @offset ROWS FETCH NEXT @pageSize ROWS ONLY;
    END;
GO
/****** Object:  StoredProcedure [dbo].[FAQ_SelectAllDetails]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[FAQ_SelectAllDetails]
AS

/*
EXECUTE [FAQ_SelectAllDetails]
*/

    BEGIN
        SELECT F.[Id], 
               F.[Question], 
               F.[Answer], 
               F.[CategoryId], 
               F.[SortOrder],  
               F.[CreatedBy], 
               F.[ModifiedBy],
			   F.[DateCreated], 
               F.[DateModified],
			   FC.Id,
			   FC.Name
			   
        FROM [dbo].[FAQ] AS F
		JOIN FAQCategories as FC on F.CategoryId = FC.Id 
        ORDER BY F.SortOrder
    END
GO
/****** Object:  StoredProcedure [dbo].[FAQ_SelectById]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[FAQ_SelectById]
				@Id int
as

/* --- Test Code ---
	DECLARE @Id int = ???

	EXECUTE dbo.FAQ_SelectById @Id

*/

BEGIN 
	
	SELECT [Id],
		[Question],
		[Answer],
		[CategoryId],
		[SortOrder],
		
		[CreatedBy],
		[ModifiedBy],
		[DateCreated],
		[DateModified]

	FROM [dbo].[FAQ]
	WHERE Id = @Id

END
GO
/****** Object:  StoredProcedure [dbo].[FAQ_Update]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[FAQ_Update]
						@Id int OUTPUT,
						@Question nvarchar(255),
						@Answer nvarchar(2000),
						@CategoryId int,
						@SortOrder int,
						
						@ModifiedBy int

as
/* --- Test Code ---

	DECLARE @Id int = 1;

	DECLARE
			@Question nvarchar(255) = 'Updated',
			@Answer nvarchar(2000) = 'Really Upfdateexd',
			@CategoryId int = 12,
			@SortOrder int = 13,
			
			@ModifiedBy int = 17

	Select *
	From.dbo.Surveys
	WHERE Id = @Id

	Execute dbo.FAQ_Update
			@Id,
			@Question,
			@Answer,
			@CategoryId,
			@SortOrder,
			
			@ModifiedBy

	Select *
	From [dbo].[FAQ]

*/

BEGIN

		DECLARE @DateModified DATETIME2(7) = GETUTCDATE()

		UPDATE [dbo].[FAQ]
		
		   SET 
			[Question] = @Question,
			[Answer] = @Answer,
			[CategoryId] = @CategoryId,
			[SortOrder] = @SortOrder,
			[DateModified] = @DateModified,
			
			[ModifiedBy] = @ModifiedBy

		 WHERE Id = @Id;
END


GO
/****** Object:  StoredProcedure [dbo].[FAQCategories_Delete]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[FAQCategories_Delete] @Id int

AS 

/*

DECLARE @Id int = 3
EXECUTE dbo.FAQCategories_Delete @Id int

*/

BEGIN

DELETE FROM [dbo].[FAQ]
      WHERE CategoryId = @Id
DELETE FROM [dbo].[FAQCategories]
      WHERE Id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[FAQCategories_Insert]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[FAQCategories_Insert] @Id   INT OUT, 
                                        @Name NVARCHAR(50)
AS

/*

Declare @Id int = 0;
	
	Declare
			@Name nvarchar(50) = 'Find your licensing'



	Execute [dbo].[FAQCategories_Insert]
			@Id,
			@Name


	Select * 
	From dbo.FAQCategories

*/

    BEGIN
        INSERT INTO [dbo].[FAQCategories]([Name])
    VALUES(@Name);
        SET @Id = SCOPE_IDENTITY();
    END;
GO
/****** Object:  StoredProcedure [dbo].[FAQCategories_SelectAll]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[FAQCategories_SelectAll]
										--@pageIndex int
										--,@pageSize int

AS

/* --- Test Code ---

--DECLARE @pageIndex int = 0
--		,@pageSize int = 1

EXECUTE dbo.FAQCategories_SelectAll
									--@pageIndex
									--,@pageSize

*/

BEGIN

--DECLARE @offset int = @pageIndex * @pageSize

SELECT [Id]
		,[Name]

FROM dbo.FAQCategories

--ORDER BY FAQCategories.Id

--OFFSET @offset ROWS
--FETCH NEXT @pageSize ROWS ONLY

END
GO
/****** Object:  StoredProcedure [dbo].[FAQCategories_Update]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[FAQCategories_Update]
				@Id int OUTPUT,
				@Name nvarchar(50)

as

/*
Declare @Id int = 3;
	
	Declare 
			@Name nvarchar(50) = 'Find your correct licensing'

	Select *
	From dbo.FAQCategories
	WHERE Id = @Id

	Execute dbo.FAQCategories_Update
				@Id,
				@Name

	Select *
	From dbo.FAQCategories
	WHERE Id = @Id


*/

BEGIN

UPDATE [dbo].[FAQCategories]

   SET [Name] = @Name


 WHERE Id = @Id;


END
GO
/****** Object:  StoredProcedure [dbo].[Files_Delete_ById]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Files_Delete_ById]
		@Id int
AS

/*

DECLARE @Id int = 1

EXECUTE [dbo].[Files_Delete_ById] 
		@Id

*/

BEGIN

DELETE [dbo].[Files]
      WHERE @Id = Id

END


GO
/****** Object:  StoredProcedure [dbo].[Files_Insert]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Files_Insert] 
		@Id         INT OUTPUT, 
		@Url        NVARCHAR(225), 
		@FileTypeId INT, 
		@CreatedBy  INT

AS

/*

DECLARE @_id int,
		@_url NVARCHAR(225) = 'https://business.lacity.org/',
		@_fileTypeId int = 3,
		@_createdBy int = 2

EXECUTE [dbo].[Files_Insert]
		@_id OUTPUT,
		@_url,
		@_fileTypeId,
		@_createdBy

		SELECT * FROM [dbo].[Files]

*/

    BEGIN
        INSERT INTO [dbo].[Files]
        ([Url], 
         [FileTypeId], 
         [CreatedBy]
        )
        VALUES
        (@Url, 
         @FileTypeId, 
         @CreatedBy
        );
        SET @Id = SCOPE_IDENTITY();
    END;
GO
/****** Object:  StoredProcedure [dbo].[Files_Select_ByCreatedBy]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Files_Select_ByCreatedBy] 
			@PageIndex INT, 
			@PageSize  INT, 
			@CreatedBy INT

/*
Declare 		@pageIndex int = 0
				,@pageSize int = 5
				,@CreatedBy int = 2

EXECUTE [dbo].[Files_Select_ByCreatedBy]
				@pageIndex,
				@pageSize,
				@CreatedBy

*/

AS
    BEGIN
        DECLARE @offset INT= @PageIndex * @PageSize;
        SELECT [Id], 
               [Url], 
               [FileTypeId], 
               [CreatedBy], 
               [DateCreated], 
               TotalCount = COUNT(1) OVER()
        FROM [dbo].[Files]
        WHERE @CreatedBy = CreatedBy
        ORDER BY Files.Id
        OFFSET @offset ROWS FETCH NEXT @Pagesize ROWS ONLY;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Files_Select_ById]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Files_Select_ById]

			@Id int

AS

/*

DECLARE @_id int = 1

EXECUTE [dbo].[Files_Select_ById] @_id

*/

BEGIN

SELECT [Id]
      ,[Url]
      ,[FileTypeId]
      ,[CreatedBy]
      ,[DateCreated]
  FROM [dbo].[Files]

  WHERE @Id = Id

END


GO
/****** Object:  StoredProcedure [dbo].[Files_SelectAll]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Files_SelectAll]
	@PageIndex int,
	@PageSize int

AS

/*
DECLARE @PageIndex int = 0,
		@PageSize int = 3


EXECUTE [dbo].[Files_SelectAll]
		@PageIndex,
		@PageSize
*/

BEGIN

DECLARE @Offset int = @PageIndex * @PageSize

SELECT [Id]
      ,[Url]
      ,[FileTypeId]
      ,[CreatedBy]
      ,[DateCreated]
	  ,TotalCount = COUNT(1) OVER()
  FROM [dbo].[Files] 
  ORDER BY [dbo].[Files].Id DESC
  OFFSET @Offset ROWS
  FETCH NEXT @PageSize ROWS ONLY;

END


GO
/****** Object:  StoredProcedure [dbo].[Files_Update]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Files_Update] 
		@Id         INT, 
		@Url        NVARCHAR(255), 
		@FileTypeId INT, 
		@CreatedBy  INT

AS

/*

DECLARE @_id INT = 1

SELECT *
FROM [dbo].[Files]
WHERE @_id = Id


DECLARE @_url NVARCHAR(255) = 'https://business.lacity.org/',
		@_fileTypeId INT = 2,
		@_createdBy INT = 2

EXECUTE [dbo].[Files_Update]
		@_id,
		@_url,
		@_fileTypeId,
		@_createdBy

SELECT *
FROM [dbo].[Files]
WHERE @_id = Id
	
*/

    BEGIN

        UPDATE [dbo].[Files]
          SET 
              [Url] = @Url, 
              [FileTypeId] = @FileTypeId, 
              [CreatedBy] = @CreatedBy

        WHERE @Id = Id;

    END;
GO
/****** Object:  StoredProcedure [dbo].[FileTypes_SelectAll]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[FileTypes_SelectAll]
AS
/*
		EXEC dbo.FileTypes_SelectAll 

*/
BEGIN
		SELECT
				[Id],
				[Name]
				

		FROM
				[dbo].[FileTypes]

		ORDER BY Id  
		
				

END
GO
/****** Object:  StoredProcedure [dbo].[IndustryTypes_SelectAll]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[IndustryTypes_SelectAll]
AS

/*

Execute [dbo].[IndustryTypes_SelectAll]

*/

    BEGIN
        SELECT [Id], 
               [Code], 
               [Name]
        FROM [dbo].[IndustryTypes]
        ORDER BY Id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Locations_Delete]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Locations_Delete] @Id INT
AS

/*

	Select * from [dbo].[Locations];
	DECLARE @Id INT = 1;
	EXEC dbo.Locations_Delete @Id;
	Select * from [dbo].[Locations];

*/

    BEGIN
        DELETE [dbo].[Locations]
        WHERE Id = @Id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Locations_GetOptions]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Locations_GetOptions]
AS
/*
EXECUTE dbo.Locations_GetOptions
*/
BEGIN

SELECT L.[Id]
	  ,V.[Name]
  FROM [dbo].[Locations] as L
  join dbo.Venues as V on V.LocationId = L.Id
END


GO
/****** Object:  StoredProcedure [dbo].[Locations_Insert]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE proc [dbo].[Locations_Insert]
			@Id int output,
			@LocationTypeId  int,
			@LineOne  nvarchar(255),
			@LineTwo  nvarchar(255),
			@City  nvarchar(225),
			@Zip  nvarchar(50),
			@StateId  int,
			@Latitude float,
			@Longitude  float,			
			@CreatedBy  int,
			@ModifiedBy int
		
as
/*
	
DECLARE		@Id int,
			@LocationTypeId int = 1,
			@LineOne  nvarchar(255) = ' abc st' ,
			@LineTwo  nvarchar(255) = 'apt. 2',
			@City  nvarchar(225) = 'Los Angeles' ,
			@Zip  nvarchar(50) = '90057',
			@StateId  int = 10 ,
			@Latitude float = 30.5568 ,
			@Longitude  float = -16.556,			
			@CreatedBy  int =1,
			@ModifiedBy int = 1
	
EXECUTE     [dbo].[Locations_Insert]
			@Id Out,
			@LocationTypeId,
			@LineOne,
			@LineTwo,
			@City,
			@Zip,
			@StateId,
			@Latitude,
			@Longitude,
			@CreatedBy,
			@ModifiedBy
			
SELECT * 
FROM [dbo].[Locations]
WHERE Id = @Id

*/
BEGIN

	INSERT INTO 
		[dbo].[Locations]
           ([LocationTypeId],
			[LineOne],
			[LineTwo],
			[City],
			[Zip],
			[StateId],
			[Latitude],
			[Longitude],
			[CreatedBy],
			[ModifiedBy])
		    
		   VALUES 
		   (@LocationTypeId,
			@LineOne,
			@LineTwo,
			@City,
			@Zip,
			@StateId,
			@Latitude,
			@Longitude,
			@CreatedBy,
			@ModifiedBy)

	SET @Id = SCOPE_IDENTITY()

 END


GO
/****** Object:  StoredProcedure [dbo].[Locations_Search]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Locations_Search] @pageIndex INT, 
                                     @pageSize  INT, 
                                     @query     NVARCHAR(50)
AS

/*
    DECLARE @query nvarchar(50) = 'Test'
    ,@pageSize int = 10
    ,@PageIndex int = 0
    EXECUTE dbo. Locations_Search @query, @pageIndex, @pageSize
*/

    BEGIN
        SELECT [Id], 
               [LocationTypeId], 
               [LineOne], 
               [LineTwo], 
               [City], 
               [Zip], 
               [StateId], 
               
               TotalCount = COUNT(1) OVER()
        FROM [dbo].[Locations]
        WHERE(LocationTypeId LIKE '%' + @query + '%')
             OR (LineOne LIKE '%' + @query + '%')
             OR (LineTwo LIKE '%' + @query + '%')
             OR (City LIKE '%' + @query + '%')
             OR (Zip LIKE '%' + @query + '%')
             OR (StateId LIKE '%' + @query + '%')
        ORDER BY locations.Id desc
        OFFSET @PageIndex ROWS FETCH NEXT @pageSize ROWS ONLY;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Locations_SelectAll]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Locations_SelectAll] @PageIndex INT, 
                                       @PageSize  INT
AS

/*
		Declare 
		@PageIndex int=0, 
		@PageSize int=10

		EXEC dbo.Locations_SelectAll 
		@PageIndex, 
		@PageSize;

*/

    BEGIN
        DECLARE @OffSet INT= @PageIndex * @PageSize;
        SELECT  L.[Id],
				L.[LocationTypeId],
				L.[LineOne],
				L.[LineTwo],
				L.[City],
				L.[Zip],
				L.[StateId],
				L.[Latitude],
				L.[Longitude],
				L.[DateCreated],
				L.[DateModified],
				L.[CreatedBy],
				L.[ModifiedBy],
				LT.[Name],
				
				TotalCount = COUNT(1) OVER()

		FROM	[dbo].[Locations] as L
				JOIN dbo.LocationTypes AS LT ON L.LocationTypeId = LT.Id
        ORDER BY Id
        OFFSET @OffSet ROWS FETCH NEXT @PageSize ROWS ONLY;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Locations_SelectAll_V2]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Locations_SelectAll_V2]
				@PageIndex int,  
				@PageSize int 
AS
/*
		Declare 
		@PageIndex int = 0, 
		@PageSize int = 10

		EXEC dbo.[Locations_SelectAll_V2]
		@PageIndex, 
		@PageSize;

*/
BEGIN
		Declare @OffSet int = @PageIndex * @PageSize
		SELECT
				L.[Id],
				L.[LocationTypeId],
				L.[LineOne],
				L.[LineTwo],
				L.[City],
				L.[Zip],
				L.[StateId],
				L.[Latitude],
				L.[Longitude],
				L.[DateCreated],
				L.[DateModified],
				L.[CreatedBy],
				UP.FirstName,
				UP.LastName,
				L.[ModifiedBy],
				LT.[Name],
				S.[Name] AS [StateName],
				
				TotalCount = COUNT(1) OVER()

		FROM	[dbo].[Locations] as L
				JOIN dbo.LocationTypes AS LT ON L.LocationTypeId = LT.Id
				JOIN dbo.States AS S ON L.StateId = S.Id
				JOIN dbo.UserProfiles as UP on UP.UserId = L.CreatedBy
			
				

		ORDER BY L.Id  

		OFFSET @OffSet Rows
		Fetch Next @PageSize Rows ONLY
		
				

END
GO
/****** Object:  StoredProcedure [dbo].[Locations_SelectByCreatedBy]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[Locations_SelectByCreatedBy]
				@CreatedBy int,
				@PageIndex int,  
				@PageSize int 
AS
/*
		Declare 
		@CreatedBy int = 2,
		@PageIndex int = 0, 
		@PageSize int = 10

		EXEC dbo.Locations_SelectByCreatedBy
		@CreatedBy,
		@PageIndex, 
		@PageSize;

*/
BEGIN
		Declare @OffSet int = @PageIndex * @PageSize
		SELECT
				L.[Id],
				L.[LocationTypeId],
				L.[LineOne],
				L.[LineTwo],
				L.[City],
				L.[Zip],
				L.[StateId],
				L.[Latitude],
				L.[Longitude],
				L.[DateCreated],
				L.[DateModified],
				L.[CreatedBy],
				UP.FirstName,
				UP.LastName,
				L.[ModifiedBy],

				TotalCount = COUNT(1) OVER()
		FROM
				[dbo].[Locations] as L
				JOIN dbo.UserProfiles as UP on UP.UserId = L.CreatedBy
		WHERE [CreatedBy]=@CreatedBy
		ORDER BY Id  

		OFFSET @OffSet Rows
		Fetch Next @PageSize Rows ONLY
		
				

END
GO
/****** Object:  StoredProcedure [dbo].[Locations_SelectById]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[Locations_SelectById]
				@Id int
				
AS
/*
		Declare 
		@Id int=2;
		

		EXEC dbo.Locations_SelectById
		@Id;

*/
BEGIN
		
		SELECT
				L.[Id],
				L.[LocationTypeId],
				L.[LineOne],
				L.[LineTwo],
				L.[City],
				L.[Zip],
				L.[StateId],
				L.[Latitude],
				L.[Longitude],
				L.[DateCreated],
				L.[DateModified],
				L.[CreatedBy],
				UP.FirstName,
				UP.LastName,
				L.[ModifiedBy],
				LT.[Name],
				S.[Name] AS [StateName]

				
		FROM
				[dbo].[Locations] as L
				JOIN dbo.LocationTypes AS LT ON L.LocationTypeId = LT.Id
				JOIN dbo.States AS S ON L.StateId = S.Id
				JOIN dbo.UserProfiles as UP on UP.UserId = L.CreatedBy

		WHERE L.Id = @Id
					

END
GO
/****** Object:  StoredProcedure [dbo].[Locations_Update]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE proc [dbo].[Locations_Update]
			@Id int,
			@LocationTypeId  int,
			@LineOne nvarchar(255),
			@LineTwo nvarchar(255),
			@City nvarchar(225),
			@Zip nvarchar(50),
			@StateId int,
			@Latitude float,
			@Longitude float,			
			@CreatedBy int,
			@ModifiedBy int
			
AS
/*----TEST CODE---------------------

DECLARE	    @Id int = 1,
			@LocationTypeId int = 1,
			@LineOne nvarchar(255) = '24 W HollyWood Blvd' ,
			@LineTwo nvarchar(255) = 'apt. 109',
			@City nvarchar(225) = 'Los Angeles' ,
			@Zip nvarchar(50) = '90057',
			@StateId int = 6,
			@Latitude float = 30.5568 ,
			@Longitude float = -16.556,			
			@CreatedBy int = 1,
			@ModifiedBy int = 1

SELECT * 
FROM [dbo].[Locations] 
WHERE Id = @Id 

EXECUTE     [dbo].[Locations_Update]
			@Id,
			@LocationTypeId,
			@LineOne,
			@LineTwo,
			@City,
			@Zip,
			@StateId,
			@Latitude,
			@Longitude,
			@CreatedBy,
			@ModifiedBy
	
SELECT * 
FROM [dbo].[Locations] 
WHERE Id= @Id

*/----------------------------------
BEGIN

	DECLARE @DateModified DATETIME2(7)=GETUTCDATE()
	UPDATE 
		[dbo].[Locations]
	SET
			[LocationTypeId] = @LocationTypeId,
			[LineOne] = @LineOne,
			[LineTwo] = @LineTwo,
			[City] = @City,
			[Zip] = @Zip,
			[StateId] = @StateId,
			[Latitude] = @Latitude,
			[Longitude] = @Longitude,
			[CreatedBy] = @CreatedBy,
			[ModifiedBy] = @ModifiedBy
		
	WHERE	Id = @Id

 END


GO
/****** Object:  StoredProcedure [dbo].[LocationTypes_SelectAll]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[LocationTypes_SelectAll]


AS

/*


EXECUTE dbo.LocationTypes_SelectAll

*/

BEGIN


SELECT [Id]
      ,[Name]

FROM [dbo].[LocationTypes]

ORDER BY LocationTypes.Id

END


GO
/****** Object:  StoredProcedure [dbo].[LocationZoneTypes_SelectAll]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[LocationZoneTypes_SelectAll]
AS

/*


Execute dbo.LocationZoneTypes_SelectAll

*/

    BEGIN
        SELECT [Id], 
               [Code],
			   [Name]
        FROM [dbo].[LocationZoneTypes]
        ORDER BY Id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[MenteeCategories_Delete_ByUserId]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[MenteeCategories_Delete_ByUserId]
			@UserId int

AS

/* ---------- TEST CODE ----------

	DECLARE 
			@UserId int = 0;

	EXECUTE [dbo].[MenteeCategories_Delete_ByUserId]

*/

BEGIN

	DELETE FROM [dbo].[MenteeCategories]
		  WHERE UserId = @UserId

END


GO
/****** Object:  StoredProcedure [dbo].[MenteeCategories_Insert]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[MenteeCategories_Insert]
			@UserId int,
			@CategoryTypesId int

AS

/* ---------- TEST CODE ----------

	DECLARE
			@UserId int = 7,
			@CategoryTypesId int = 48

	EXECUTE [dbo].[MenteeCategories_Insert]
			@UserId,
			@CategoryTypesId

	SELECT * From [dbo].[MenteeCategories]

*/

BEGIN

	INSERT INTO [dbo].[MenteeCategories]
			   ([UserId],
			   [CategoryTypesId])
		 VALUES
			   (@UserId,
			   @CategoryTypesId)

END


GO
/****** Object:  StoredProcedure [dbo].[MenteeCategories_Insert_Multiple]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[MenteeCategories_Insert_Multiple]
			@UserId int,
			@MenteeCategoriesList as MenteeCategoriesListType READONLY

AS

/* ---------- TEST CODE ----------

	DECLARE @UserId int = 9
	DECLARE @_menteeCategoryList as MenteeCategoriesListType

	INSERT into @_menteeCategoryList 
		(CategoryTypesId) values (10)
	INSERT into @_menteeCategoryList 
		(CategoryTypesId) values (20)
	INSERT into @_menteeCategoryList 
		(CategoryTypesId) values (40)

	EXECUTE [dbo].[MenteeCategories_Insert_Multiple] 
		@UserId,
		@_menteeCategoryList

	SELECT * from dbo.MenteeCategories

*/

BEGIN

	INSERT INTO [dbo].[MenteeCategories]
		([UserId],
		[CategoryTypesId])

	SELECT @UserId, [CategoryTypesId] 
	FROM @MenteeCategoriesList

END


GO
/****** Object:  StoredProcedure [dbo].[MenteeCategories_Select_ByUserId]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[MenteeCategories_Select_ByUserId]
			@UserId int

AS

/* ---------- TEST CODE ----------

	Declare 
	@UserId int = 124

	Execute dbo.MenteeCategories_Select_ByUserId
	@UserId

*/

BEGIN

	SELECT DISTINCT 
			MC.[UserId],
		    (SELECT CT.[Id], CT.[Code], CT.[Name], CT.[GroupName]
				FROM dbo.[CategoryTypes] AS CT
				JOIN dbo.[MenteeCategories] AS MentCat 
				ON MentCat.[CategoryTypesId] = CT.[Id] 
				AND MentCat.[UserId] = MC.[UserId] FOR JSON AUTO) AS CategoryTypes
	FROM [dbo].[MenteeCategories] as MC
		
	WHERE UserId = @UserId

END


GO
/****** Object:  StoredProcedure [dbo].[MenteeCategories_SelectAll]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[MenteeCategories_SelectAll]
			@pageIndex int,
			@pageSize int

AS

/* ---------- TEST CODE ----------

	Declare 
	@PageIndex int = 0,
	@PageSize int = 10

	Execute [dbo].[MenteeCategories_SelectAll]
	@PageIndex,
	@PageSize

*/

BEGIN

	DECLARE @offset int = @pageIndex * @pageSize

	SELECT DISTINCT
			MC.[UserId],
		   (SELECT CT.[Id], CT.[Code], CT.[Name]
				FROM dbo.[CategoryTypes] AS CT
				JOIN dbo.[MenteeCategories] AS MentCat 
				ON MentCat.[CategoryTypesId] = CT.[Id] 
				AND MentCat.[UserId] = MC.[UserId] 
				FOR JSON AUTO) AS Categories,

		  TotalCount = COUNT(1) OVER()

	FROM [dbo].[MenteeCategories] as MC
	
	ORDER BY MC.[UserId]

	OFFSET @offset Rows
	Fetch Next @pageSize Rows ONLY

END


GO
/****** Object:  StoredProcedure [dbo].[MenteeCategories_Update]    Script Date: 1/6/2020 7:14:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[MenteeCategories_Update]
			@UserId int,
			@CategoryTypesId int

AS

/* ---------- TEST CODE ----------

	DECLARE 
			@UserId int = 7,
			@CategoryTypesId int = 49

	EXECUTE [dbo].[MenteeCategories_Update]
			@UserId,
			@CategoryTypesId

	SELECT * FROM [dbo].[MenteeCategories]
		WHERE UserId = @UserId

*/

-- does not update UserIds with multiple associated CategoryTypesIds

BEGIN

	UPDATE [dbo].[MenteeCategories]
	   SET [CategoryTypesId] = @CategoryTypesId
	 WHERE [UserId] = @UserId

END

GO
/****** Object:  StoredProcedure [dbo].[MenteeCategories_Update_V2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[MenteeCategories_Update_V2]
			@UserId int,
			@MenteeCategoriesList as MenteeCategoriesListType READONLY

AS

/* ---------- TEST CODE ----------

	DECLARE @UserId int = 9
	DECLARE @_menteeCategoryList as MenteeCategoriesListType
	
	SELECT * FROM [dbo].[MenteeCategories]
		WHERE UserId = @UserId

	INSERT into @_menteeCategoryList 
		(CategoryTypesId) values (5)
	INSERT into @_menteeCategoryList 
		(CategoryTypesId) values (10)
	INSERT into @_menteeCategoryList 
		(CategoryTypesId) values (15)

	EXECUTE [dbo].[MenteeCategories_Update_V2]
			@UserId,
			@_menteeCategoryList

	SELECT * FROM [dbo].[MenteeCategories]
		WHERE UserId = @UserId

*/


BEGIN

	DELETE FROM [dbo].[MenteeCategories]
		WHERE UserId = @UserId

	INSERT INTO [dbo].[MenteeCategories]
		([UserId],
		[CategoryTypesId])

	SELECT @UserId, [CategoryTypesId] 
	FROM @MenteeCategoriesList

END

GO
/****** Object:  StoredProcedure [dbo].[MentorCategories_Delete]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MentorCategories_Delete]
			@MentorId int

AS

/*

DECLARE @MentorId int = 5

EXECUTE dbo.MentorCategories_Delete
		@MentorId

SELECT * 
FROM dbo.MentorCategories
*/

BEGIN

DELETE FROM [dbo].[MentorCategories]
      WHERE [MentorId] = @MentorId

END

GO
/****** Object:  StoredProcedure [dbo].[MentorCategories_Delete_ByUserId]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[MentorCategories_Delete_ByUserId]
			@UserId int

AS

/* ---------- TEST CODE ----------

	DECLARE 
			@UserId int = 0;

	EXECUTE [dbo].[MentorCategories_Delete_ByUserId]

*/

BEGIN

	DELETE FROM [dbo].[MentorCategories]
		  WHERE MentorId = @UserId

END


GO
/****** Object:  StoredProcedure [dbo].[MentorCategories_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MentorCategories_Insert]
			@MentorId int
			,@MentorCategoryId int

AS

/*
			DECLARE @MentorId int = 6
					,@MentorCategoryId int = 12

			EXECUTE dbo.MentorCategories_Insert
					@MentorId
					,@MentorCategoryId

			EXECUTE dbo.MentorCategories_SelectAll
*/

BEGIN


INSERT INTO [dbo].[MentorCategories]
           ([MentorId]
           ,[MentorCategoryId])
     VALUES
           (@MentorId
           ,@MentorCategoryId)
END


GO
/****** Object:  StoredProcedure [dbo].[MentorCategories_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MentorCategories_SelectAll]

AS

/*
EXECUTE dbo.MentorCategories_SelectAll
*/

BEGIN

SELECT [MentorId]
      ,[MentorCategoryId]
  FROM [dbo].[MentorCategories]
			

END


GO
/****** Object:  StoredProcedure [dbo].[MentorCategories_SelectAll_V2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MentorCategories_SelectAll_V2]

AS

/*
EXECUTE dbo.MentorCategories_SelectAll_V2
*/

BEGIN

	SELECT DISTINCT 
			MC.[MentorId],
		    (SELECT CT.[Id], CT.[Code], CT.[Name], CT.[GroupName]
				FROM dbo.[CategoryTypes] AS CT
				JOIN dbo.[MentorCategories] AS MentCat 
				ON MentCat.[MentorCategoryId] = CT.[Id] AND MentCat.[MentorId] = MC.[MentorId] FOR JSON AUTO) AS CategoryTypes
	FROM [dbo].[MentorCategories] as MC
			

END


GO
/****** Object:  StoredProcedure [dbo].[MentorCategories_SelectById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[MentorCategories_SelectById]
			@MentorId int

AS

/*

SELECT *
FROM dbo.MentorCategories

	DECLARE @MentorId int = 6

	EXECUTE [dbo].[MentorCategories_SelectById]
			@MentorId
*/

BEGIN

SELECT [MentorId]
      ,[MentorCategoryId]
  FROM [dbo].[MentorCategories]
			
  WHERE [MentorId] = @MentorId

END


GO
/****** Object:  StoredProcedure [dbo].[MentorCategories_SelectById_V2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[MentorCategories_SelectById_V2]
			@MentorId int

AS

/*

SELECT *
FROM dbo.MentorCategories

	DECLARE @MentorId int = 6

	EXECUTE [dbo].[MentorCategories_SelectById_V2]
			@MentorId
*/

BEGIN

	SELECT DISTINCT 
			MC.[MentorId],
			(SELECT CT.[Id], CT.[Code], CT.[Name], CT.[GroupName]
				FROM dbo.[CategoryTypes] AS CT
				JOIN dbo.[MentorCategories] AS MentCat 
				ON MentCat.[MentorCategoryId] = CT.[Id] AND MentCat.[MentorId] = MC.[MentorId] FOR JSON AUTO) AS CategoryTypes
	FROM [dbo].[MentorCategories] as MC
	WHERE MentorId = @MentorId

END


GO
/****** Object:  StoredProcedure [dbo].[MentorCategories_SelectPagination]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MentorCategories_SelectPagination]
			@pageIndex int
			,@pageSize int
AS

/*

DECLARE @pageIndex int = 0
		,@pageSize int = 2

EXECUTE dbo.MentorCategories_SelectPagination
		@pageIndex
		,@pageSize
*/

BEGIN

DECLARE @offSet int = @pageIndex * @pageSize

SELECT [MentorId]
      ,[MentorCategoryId]
  FROM [dbo].[MentorCategories]
  ORDER BY [MentorId] ASC

	OFFSET @offSet ROWS
	FETCH NEXT @pageSize ROWS ONLY

END


GO
/****** Object:  StoredProcedure [dbo].[MentorCategories_Update]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[MentorCategories_Update]
			@MentorId int
			,@MentorCategoryId int
			,@NewMentorCategoryId int
AS

/*
		DECLARE @MentorId int = 6
				,@MentorCategoryId int = 12
				,@NewMentorCategoryId int = 10

		EXECUTE dbo.MentorCategories_Update
				@MentorId 
				,@MentorCategoryId 
				,@NewMentorCategoryId

		SELECT * 
		FROM dbo.MentorCategories
*/

BEGIN

UPDATE [dbo].[MentorCategories]
   SET [MentorId] = @MentorId
      ,[MentorCategoryId] = @NewMentorCategoryId
 WHERE [MentorId] = @MentorId AND [MentorCategoryId] = @MentorCategoryId

END


GO
/****** Object:  StoredProcedure [dbo].[MentorCategories_Update_V2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[MentorCategories_Update_V2]
			@UserId int,
			@MentorCategoriesList as MentorCategoriesListType READONLY

AS

/* ---------- TEST CODE ----------

	DECLARE @UserId int = 123
	DECLARE @_mentorCategoryList as MentorCategoriesListType
	
	SELECT * FROM [dbo].[MentorCategories]
		WHERE MentorId = @UserId

	INSERT into @_mentorCategoryList 
		(MentorCategoryId) values (5)
	INSERT into @_mentorCategoryList 
		(MentorCategoryId) values (10)
	INSERT into @_mentorCategoryList 
		(MentorCategoryId) values (15)

	EXECUTE [dbo].[MentorCategories_Update_V2]
			@UserId,
			@_mentorCategoryList

	SELECT * FROM [dbo].[MentorCategories]
		WHERE [MentorId] = @UserId

*/


BEGIN

	DELETE FROM [dbo].[MentorCategories]
		WHERE [MentorId] = @UserId

	INSERT INTO [dbo].[MentorCategories]
		([MentorId],
		[MentorCategoryId])

	SELECT @UserId, [MentorCategoryId] 
	FROM @MentorCategoriesList

END

GO
/****** Object:  StoredProcedure [dbo].[MentorReviews_DeleteById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[MentorReviews_DeleteById]
			@Id int

AS

/* ---------- TEST CODE ----------

	DECLARE @Id int = 9

	SELECT * 
	FROM dbo.MentorReviews
	Where ReviewId = @Id

	SELECT * 
	FROM dbo.Reviews
	Where Id = @Id

	EXECUTE dbo.MentorReviews_DeleteById
			@Id

	SELECT * 
	FROM dbo.MentorReviews
	Where ReviewId = @Id

	SELECT * 
	FROM dbo.Reviews
	Where Id = @Id

*/

BEGIN

	DELETE FROM [dbo].[MentorReviews]
		  WHERE ReviewId = @Id

	DELETE FROM [dbo].[Reviews]
		  WHERE Id = @Id

END


GO
/****** Object:  StoredProcedure [dbo].[MentorReviews_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[MentorReviews_Insert]
	       @ReviewId int output,
		   @UserId int,
		   @Review nvarchar(1000),
		   @StarRating int,
           @MentorId int

AS

/* ---------- TEST CODE ----------

	DECLARE
		@ReviewId int,
		@UserId int = 127,
		@Review nvarchar(1000) = 'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...',
		@StarRating int = 5,
		@MentorId int = 123

	EXECUTE [dbo].[MentorReviews_Insert]
		@ReviewId OUTPUT,
		@UserId,
		@Review,
		@StarRating,
		@MentorId

	SELECT * 
	FROM [dbo].[Reviews]
	WHERE Id = @ReviewId

	SELECT * 
	FROM [dbo].[MentorReviews]
	WHERE ReviewId = @ReviewId

*/

BEGIN

	INSERT INTO [dbo].[Reviews]	
			(UserId,
			Review,
			StarRating)
	VALUES
			(@UserId,
			@Review,
			@StarRating)

	SET @ReviewId = SCOPE_IDENTITY()


	INSERT INTO [dbo].[MentorReviews]
           (MentorId,
           ReviewId)
	VALUES
			(@MentorId,
			@ReviewId)

END


GO
/****** Object:  StoredProcedure [dbo].[MentorReviews_SelectByMentorId]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[MentorReviews_SelectByMentorId]
			@MentorId int,
			@pageIndex int,
			@pageSize int

AS

/* ---------- TEST CODE ----------

	Declare
		@MentorId int = 123,
		@pageIndex int = 0,
		@pageSize int = 10

	Execute dbo.MentorReviews_SelectByMentorId
		@MentorId, 
		@pageIndex,
		@pageSize

*/

BEGIN

DECLARE @offset int = @pageIndex * @pageSize

SELECT DISTINCT 
	MR.[MentorId],
	(SELECT R.[Id], 
			R.[UserId],
			R.[Review], 
			R.[StarRating], 
			R.[DateCreated], 
			R.[DateModified]
			FROM dbo.[Reviews] AS R
			JOIN dbo.[MentorReviews] AS MentRev
			ON MentRev.[ReviewId] = R.[Id] 
			AND MentRev.[MentorId] = MR.[MentorId]
			ORDER BY R.[DateModified] FOR JSON AUTO) AS Reviews,

	TotalCount = COUNT(1) OVER()

	FROM [dbo].[MentorReviews] as MR
	WHERE MR.[MentorId] = @MentorId
	
	ORDER BY Reviews

	OFFSET @offset ROWS
	FETCH NEXT @pageSize ROWS ONLY

END
GO
/****** Object:  StoredProcedure [dbo].[MentorReviews_SelectByMentorId_V2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[MentorReviews_SelectByMentorId_V2]
			@MentorId int,
			@pageIndex int,
			@pageSize int

AS

/* ---------- TEST CODE ----------

	Declare
		@MentorId int = 142,
		@pageIndex int = 0,
		@pageSize int = 1

	Execute dbo.MentorReviews_SelectByMentorId_V2
		@MentorId, 
		@pageIndex,
		@pageSize

*/

BEGIN

DECLARE @offset int = @pageIndex * @pageSize

SELECT DISTINCT 
	MR.[MentorId],
	(SELECT R.[Id], 
			R.[UserId],
			R.[Review], 
			R.[StarRating], 
			R.[DateCreated], 
			R.[DateModified]

	FROM dbo.[Reviews] AS R
	JOIN dbo.[MentorReviews] AS MentRev
	ON MentRev.[ReviewId] = R.[Id] 
	AND MentRev.[MentorId] = MR.[MentorId]
	ORDER BY R.[DateModified]

	OFFSET @offset ROWS
	FETCH NEXT @pageSize ROWS ONLY FOR JSON AUTO) as Reviews,
	TotalCount = COUNT(1) OVER()

	FROM [dbo].[MentorReviews] as MR
	WHERE MR.[MentorId] = @MentorId

END
GO
/****** Object:  StoredProcedure [dbo].[Mentors_DeleteById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Mentors_DeleteById]
			@Id int

AS
/*


DECLARE @Id int = 1

SELECT *
FROM dbo.Mentors
WHERE [Id] = @Id


EXECUTE dbo.Mentors_DeleteById
		@Id

SELECT *
FROM dbo.Mentors
WHERE [Id] = @Id


*/
BEGIN

DELETE FROM [dbo].[MentorCategories]
      WHERE [MentorId] = @Id

DELETE FROM [dbo].[Mentors]
      WHERE [Id] = @Id


END


GO
/****** Object:  StoredProcedure [dbo].[Mentors_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Mentors_Insert]
			@Id int output,
			@UserId int,
			@Summary nvarchar(250),
			@Description nvarchar(4000),
			@SiteUrl nvarchar(200),
			@Phone nvarchar(50)


as
/*

DECLARE		@Id int = 0,
			@UserId int = 4,
			@Summary nvarchar(250) = 'Develop and Manufacture Bio Pharma Drugs',
			@Description nvarchar(4000) = 'BioPharma CMO',
			@SiteUrl nvarchar(200) = 'https://www.linkedin.com/company/ajinomoto-co--inc-',
			@Phone nvarchar(50) = '714-200-2939',
			@isApproved bit = 1

EXECUTE		[dbo].[Mentors_Insert]
			@Id Output,
			@UserId,
			@Summary,
			@Description,
			@SiteUrl,
			@Phone,
			@isApproved

SELECT *
FROM [dbo].[Mentors]
Where Id = @Id

*/
BEGIN

	DECLARE @isApproved bit = 0

	INSERT INTO 
		[dbo].[Mentors]
           ([UserId]
           ,[Summary]
           ,[Description]
           ,[SiteUrl]
           ,[Phone]
           ,[isApproved])

		VALUES
           (@UserId
           ,@Summary
           ,@Description
           ,@SiteUrl
           ,@Phone
           ,@isApproved)

	SET @Id = SCOPE_IDENTITY()

END

GO
/****** Object:  StoredProcedure [dbo].[Mentors_Search_WithUserDetails]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

​
​
CREATE proc [dbo].[Mentors_Search_WithUserDetails]
				@pageIndex int
				,@pageSize int
				,@Query nvarchar(250)
				​
as
​
/*
​
	DECLARE 
			@pageIndex int = 0,
			@pageSize int = 40,
			@Query nvarchar(250) = 'Compliance'
​
	EXECUTE [dbo].[Mentors_Search_WithUserDetails]
			@pageIndex, 
			@pageSize,
			@Query
		
*/
​
​
BEGIN
​
	SELECT
		M.Id,
		UP.[UserId],
		UP.[FirstName],
		UP.[Mi],
		UP.[LastName],
		UP.[AvatarUrl],
		U.[Email],
		U.[RoleId],
		M.[Summary],
		M.[Description],
		M.[SiteUrl],
		M.[Phone],
		M.[isApproved],​
			(SELECT CT.[Id], CT.[Code], CT.[Name], CT.[GroupName]
			FROM dbo.[CategoryTypes] AS CT
			JOIN dbo.[MentorCategories] AS MentCat 
			ON MentCat.[MentorCategoryId] = CT.[Id] AND MentCat.[MentorId] = M.Id FOR JSON AUTO) AS [CategoryTypes]

		INTO #MentorsWithUserDetails
		
		FROM Users AS U
			,UserProfiles AS UP
			,Mentors AS M

		WHERE (U.Id = UP.UserId AND UP.UserId = M.UserId AND M.[isApproved] = 1)
		
		DECLARE @offset int = @pageIndex * @pageSize

		SELECT 
			[Id],
			[UserId],
			[FirstName],
			[Mi],
			[LastName],
			[AvatarUrl],
			[Email],
			[RoleId],
			[Summary],
			[Description],
			[SiteUrl],
			[Phone],
			[isApproved],​
			[CategoryTypes],

		
		TotalCount = COUNT(1) OVER()

		FROM #MentorsWithUserDetails
			
		WHERE([Id] LIKE '%' + @Query + '%' 
			OR [UserId] LIKE '%' + @Query + '%'
			OR [FirstName] LIKE '%' + @Query + '%'
			OR [Mi] LIKE '%' + @Query + '%'
			OR [LastName] LIKE '%' + @Query + '%'
			OR [Email] LIKE '%' + @Query + '%'
			OR [RoleId] LIKE '%' + @Query + '%'
			OR [Summary] LIKE '%' + @Query + '%'
			OR [Description] LIKE '%' + @Query + '%'
			OR [SiteUrl] LIKE '%' + @Query + '%'
			OR [Phone] LIKE '%' + @Query + '%'
			OR [isApproved] LIKE '%' + @Query + '%'
			OR [Phone] LIKE '%' + @Query + '%'
			OR [CategoryTypes] LIKE '%' + @Query + '%')

		ORDER BY [LastName] 
​
		OFFSET @offset Rows
		FETCH NEXT @pageSize Rows ONLY
​
END
GO
/****** Object:  StoredProcedure [dbo].[Mentors_Search_WithUserDetails_V2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

​
​
CREATE proc [dbo].[Mentors_Search_WithUserDetails_V2]
				@pageIndex int
				,@pageSize int
				,@Query nvarchar(250)
				​
as
​
/*
​
	DECLARE 
			@pageIndex int = 0,
			@pageSize int = 40,
			@Query nvarchar(250) = 'ma'
​
	EXECUTE [dbo].[Mentors_Search_WithUserDetails_V2]
			@pageIndex, 
			@pageSize,
			@Query
		
*/
​
​
BEGIN
​
	SELECT
		M.Id,
		UP.[UserId],
		UP.[FirstName],
		UP.[Mi],
		UP.[LastName],
		UP.[AvatarUrl],
		U.[Email],
		U.[RoleId],
		M.[Summary],
		M.[Description],
		M.[SiteUrl],
		M.[Phone],
		M.[isApproved],​
			(SELECT CT.[Id], CT.[Code], CT.[Name], CT.[GroupName]
			FROM dbo.[CategoryTypes] AS CT
			JOIN dbo.[MentorCategories] AS MentCat 
			ON MentCat.[MentorCategoryId] = CT.[Id] AND MentCat.[MentorId] = M.Id FOR JSON AUTO) AS [CategoryTypes]

		INTO #MentorsWithUserDetails
		
		FROM Users AS U
			,UserProfiles AS UP
			,Mentors AS M

		WHERE (U.Id = UP.UserId AND UP.UserId = M.UserId AND M.[isApproved] = 1)
		
		DECLARE @offset int = @pageIndex * @pageSize

		SELECT 
			[Id],
			[UserId],
			[FirstName],
			[Mi],
			[LastName],
			[AvatarUrl],
			[Email],
			[RoleId],
			[Summary],
			[Description],
			[SiteUrl],
			[Phone],
			[isApproved],​
			[CategoryTypes],

		
		TotalCount = COUNT(1) OVER()

		FROM #MentorsWithUserDetails
			
		WHERE([FirstName] LIKE '%' + @Query + '%'
			OR [Mi] LIKE '%' + @Query + '%'
			OR [LastName] LIKE '%' + @Query + '%'
			OR [Summary] LIKE '%' + @Query + '%'
			OR [Description] LIKE '%' + @Query + '%'
			OR [SiteUrl] LIKE '%' + @Query + '%'
			OR [Phone] LIKE '%' + @Query + '%'
			OR [Phone] LIKE '%' + @Query + '%'
			OR [CategoryTypes] LIKE '%' + @Query + '%')

		ORDER BY [LastName] 
​
		OFFSET @offset Rows
		FETCH NEXT @pageSize Rows ONLY
​
END
GO
/****** Object:  StoredProcedure [dbo].[Mentors_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Mentors_SelectAll]

AS
/*


EXECUTE dbo.Mentors_SelectAll

SELECT * 
FROM dbo.Mentors
*/
BEGIN

SELECT m.[Id] as [MentorId]
		,m.[UserId]
		,m.[Summary]
		,m.[Description]
		,m.[DateCreated]
		,m.[DateModified]
		,m.[SiteUrl]
		,m.[Phone]
		,m.[isApproved]
			,(SELECT c.[Id], c.[Code], c.[Name], c.[GroupName]
			FROM dbo.CategoryTypes as c
			JOIN dbo.MentorCategories as mc
			ON mc.[MentorCategoryId] = c.[Id] AND m.[Id] = mc.[MentorId]
			FOR JSON AUTO) as [MentorCategories]

			FROM dbo.Mentors m
			
END


GO
/****** Object:  StoredProcedure [dbo].[Mentors_SelectAll_WithUserDetails]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[Mentors_SelectAll_WithUserDetails]
				@pageIndex int,
				@pageSize int

as

/*

	DECLARE 
			@pageIndex int = 0,
			@pageSize int = 15

	EXECUTE dbo.Mentors_SelectAll_WithUserDetails
			@pageIndex, 
			@pageSize		

*/


BEGIN

	DECLARE @offset int = @pageIndex * @pageSize

	SELECT
		M.Id,
		UP.[UserId],
		UP.[FirstName],
		UP.[Mi],
		UP.[LastName],
		UP.[AvatarUrl],
		U.[Email],
		U.[RoleId],
		--(SELECT R.[Name] 
		--FROM dbo.Roles as R
		--RIGHT JOIN dbo.Users as U
		--ON R.Id = U.RoleId) as [Role],
		M.[Summary],
		M.[Description],
		M.[SiteUrl],
		M.[Phone],
		M.[isApproved],

		TotalCount = COUNT(1) OVER()
		
		FROM Users AS U, UserProfiles AS UP, Mentors AS M
		WHERE U.Id = UP.UserId AND UP.UserId = M.UserId AND M.[isApproved] = 1
		ORDER BY UP.LastName 

		OFFSET @offset Rows
		FETCH NEXT @pageSize Rows ONLY

END
GO
/****** Object:  StoredProcedure [dbo].[Mentors_SelectById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Mentors_SelectById]
			@Id int

as

/*

Declare	
	@Id int = 6

Execute [dbo].[Mentors_SelectById]
	@Id


*/

BEGIN

SELECT m.[Id] as [MentorId]
		,m.[UserId]
		,m.[Summary]
		,m.[Description]
		,m.[DateCreated]
		,m.[DateModified]
		,m.[SiteUrl]
		,m.[Phone]
		,m.[isApproved]
			,(SELECT c.[Id] as CategoryId, c.[Code], c.[Name]
			FROM dbo.CategoryTypes as c
			JOIN dbo.MentorCategories as mc
			ON mc.[MentorCategoryId] = c.[Id] AND m.[Id] = mc.[MentorId]
			FOR JSON AUTO) as [MentorCategories]

			FROM dbo.Mentors m
			
  WHERE m.[Id] = @Id

END


GO
/****** Object:  StoredProcedure [dbo].[Mentors_SelectByUserId]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[Mentors_SelectByUserId]
			@UserId int

as

/*

Declare	
	@UserId int = 123

Execute [dbo].[Mentors_SelectByUserId]
	@UserId


*/

BEGIN

SELECT m.[Id] as [MentorId]
		,m.[UserId]
		,m.[Summary]
		,m.[Description]
		,m.[DateCreated]
		,m.[DateModified]
		,m.[SiteUrl]
		,m.[Phone]
		,m.[isApproved]
			,(SELECT c.[Id] as CategoryId, c.[Code], c.[Name]
			FROM dbo.CategoryTypes as c
			JOIN dbo.MentorCategories as mc
			ON mc.[MentorCategoryId] = c.[Id] AND m.[Id] = mc.[MentorId]
			FOR JSON AUTO) as [MentorCategories]

			FROM dbo.Mentors m
			
  WHERE m.[UserId] = @UserId

END


GO
/****** Object:  StoredProcedure [dbo].[Mentors_SelectPagination]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Mentors_SelectPagination]
		@pageIndex int
		,@pageSize int
AS
/*
DECLARE @pageIndex int = 0
		,@pageSize int = 2

EXECUTE dbo.Mentors_SelectPagination
		@pageIndex
		,@pageSize

SELECT * 
FROM dbo.Mentors
*/
BEGIN

DECLARE @offset int = @pageIndex * @pageSize

SELECT m.[Id] as [MentorId]
		,m.[UserId]
		,m.[Summary]
		,m.[Description]
		,m.[DateCreated]
		,m.[DateModified]
		,m.[SiteUrl]
		,m.[Phone]
		,m.[isApproved]
			,(SELECT c.[Id] as CategoryId, c.[Code], c.[Name]
			FROM dbo.CategoryTypes as c
			JOIN dbo.MentorCategories as mc
			ON mc.[MentorCategoryId] = c.[Id] AND m.[Id] = mc.[MentorId]
			FOR JSON AUTO) as [MentorCategories]
		,TotalCount = COUNT(1) OVER()

			FROM dbo.Mentors m
			WHERE [isApproved] = 1
  ORDER BY m.[Id]
  OFFSET @offset ROWS
  FETCH NEXT @pageSize ROWS ONLY

END



GO
/****** Object:  StoredProcedure [dbo].[Mentors_Update]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Mentors_Update]
			@UserId int
			,@Summary nvarchar(250)
			,@Description nvarchar(4000)
			,@SiteUrl nvarchar(200)
			,@Phone nvarchar(50)



AS
/*

SELECT *
FROM dbo.Mentors

DECLARE @UserId int = 2
		,@Summary nvarchar(250) = 'Connection you with old friends'
		,@Description nvarchar(4000) = 'Platform that uses the Web to connect people together'
		,@SiteUrl nvarchar(200) = 'www.facebook.com'
		,@Phone nvarchar(50) = '626-353-2789'
		,@isApproved bit = 0
		,@Id int = 2

EXECUTE dbo.Mentors_Update
			@UserId 
			,@Summary
			,@Description 
			,@SiteUrl 
			,@Phone 
			,@isApproved
			,@Id

SELECT *
FROM dbo.Mentors
*/
BEGIN

DECLARE @DateModified datetime2(7)	= GETUTCDATE()
 		,@isApproved bit = 0

UPDATE [dbo].[Mentors]
   SET 
      [Summary] = @Summary
      ,[Description] = @Description
	  ,[DateModified] = @DateModified
      ,[SiteUrl] = @SiteUrl
      ,[Phone] = @Phone
      ,[isApproved] = @isApproved
 WHERE [UserId] = @UserId

END


GO
/****** Object:  StoredProcedure [dbo].[PositionTypes_Delete_ById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc  [dbo].[PositionTypes_Delete_ById]
			@Id	int
AS
/*----TEST CODE----

Declare     @Id int = 100

Select * 
FROM dbo.PositionTypes 
WHERE Id =  @Id

Execute dbo.PositionTypes_Delete_ById
			@Id

Select * 
FROM dbo.PositionTypes 
WHERE Id =  @Id

*/-----------------
BEGIN

DELETE FROM [dbo].[PositionTypes]

 WHERE Id = @Id

END


GO
/****** Object:  StoredProcedure [dbo].[PositionTypes_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc  [dbo].[PositionTypes_Insert]
			@Id int OUTPUT,
			@Name nvarchar(100)
AS
/*
Declare		@Id int, 
			@Name nvarchar(100) = 'Treasurer'

Execute		dbo.PositionTypes_Insert
			@Id OUTPUT,
			@Name

SELECT *
FROM dbo.PositionTypes
*/
BEGIN

INSERT INTO [dbo].[PositionTypes]
		   ([Name])

     VALUES
           (@Name)

	 SET    @Id = SCOPE_IDENTITY()

END


GO
/****** Object:  StoredProcedure [dbo].[PositionTypes_Select_ById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc  [dbo].[PositionTypes_Select_ById]
			@Id int 
AS
/*-----TEST CODE----------
Declare		@Id int = 2

Execute dbo.PositionTypes_Select_ById
			@Id 

Select * 
FROM dbo.PositionTypes 
WHERE Id =  @Id 

*/------------------------
BEGIN

SELECT [Id],
       [Name]

  FROM [dbo].[PositionTypes]
  WHERE Id = @Id

END



GO
/****** Object:  StoredProcedure [dbo].[PositionTypes_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc  [dbo].[PositionTypes_SelectAll] 
			@pageIndex int = 0,
			@pageSize int = 5
AS
/*------TEST CODE-------

Declare		@pageIndex int = 0,
			@pageSize int = 5
			
Execute dbo.PositionTypes_SelectAll
			@pageIndex,
			@pageSize

*/----------------------
BEGIN
	
	Declare @offset int = @pageIndex * @pageSize

	SELECT [Id]
		   [Name],
		   totalCount = COUNT(1) OVER()
	FROM [dbo].[PositionTypes]
	ORDER BY PositionTypes.Id 
	OFFSET @offset Rows 
	Fetch Next @pageSize Rows ONLY

END


GO
/****** Object:  StoredProcedure [dbo].[PositionTypes_Update]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc	[dbo].[PositionTypes_Update]
			@Id int,
			@Name nvarchar(100)
AS
/*
	Declare @Id int = 2,
			@Name nvarchar(100) = 'PositionsType Update test v.2'

	Execute dbo.PositionTypes_Update
			@Id,
			@Name

SELECT * 
FROM dbo.PositionTypes
WHERE Id = @Id

*/
BEGIN

UPDATE [dbo].[PositionTypes]

   SET 
		[Name] = @Name
	    WHERE Id = @Id
END


GO
/****** Object:  StoredProcedure [dbo].[QuestionAnswers_GetById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[QuestionAnswers_GetById]
			@Id int

as

/*

	Declare	   @Id int = 16
	EXECUTE    dbo.QuestionAnswers_GetById @Id

*/
	

        SELECT SQ.[Id],
				SQ.QuestionTypeId,
				SQ.Question,
		(Select SQAO.Id AS AnswerOptionId, SQAO.[Text]
		FROM dbo.SurveyQuestionAnswerOptions as SQAO
			WHERE SQAO.QuestionId = SQ.Id FOR JSON Auto) as Answers
			
        FROM [dbo].[SurveyQuestions] as SQ

		

		WHERE SQ.Id = @Id
GO
/****** Object:  StoredProcedure [dbo].[QuestionAnswers_GetMultiple]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[QuestionAnswers_GetMultiple]
			@PageIndex int,  
			@PageSize int 

as

/*
		Declare 		 
		@PageIndex int=0, 
		@PageSize int=10

		EXEC dbo.QuestionAnswers_GetMultiple 		 
		@PageIndex,
		@PageSize;

*/
BEGIN
		Declare @Offset int = @PageIndex * @PageSize

        SELECT SQ.[Id],
				SQ.QuestionTypeId,
				SQ.Question,
		(Select SQAO.Id AS AnswerOptionId, SQAO.[Text],SQAO.[Value]
		FROM dbo.SurveyQuestionAnswerOptions as SQAO
			WHERE SQAO.QuestionId = SQ.Id FOR JSON Auto) as Answers,
			TotalCount = COUNT(1) OVER()
			
        FROM [dbo].[SurveyQuestions] as SQ

		
		ORDER BY SQ.Id  DESC

		OFFSET @offSet Rows
		Fetch Next @pageSize Rows ONLY
end
GO
/****** Object:  StoredProcedure [dbo].[QuestionOptionTypes_GetAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[QuestionOptionTypes_GetAll]
	
AS

/*------------- TEST CODE --------------

EXECUTE [dbo].[QuestionOptionTypes_GetAll]
	
*/--------------------------------------
    BEGIN
       
        SELECT [Id], 
               [Code], 
               [Name] 
               
               
        FROM [dbo].[QuestionOptionTypes]
       
    END
GO
/****** Object:  StoredProcedure [dbo].[QuestionTypes_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[QuestionTypes_SelectAll]
			

AS
/*
			EXEC dbo.QuestionTypes_SelectAll

*/
BEGIN

		SELECT 
				[Id]
				,[Name]

		FROM [dbo].[QuestionTypes]
	
END


GO
/****** Object:  StoredProcedure [dbo].[Recommendations_Concat]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Recommendations_Concat] @SQL          NVARCHAR(MAX), 
                                          @Header       NVARCHAR(MAX), 
                                          @InsertClause NVARCHAR(MAX), 
                                          @WhereClause  NVARCHAR(MAX), 
                                          @ResourceId   INT

/*
DECLARE 
@Header NVARCHAR(MAX) = N'',
@SQL NVARCHAR(MAX)= N'', 
@InsertClause NVARCHAR(MAX)= N'', 
@WhereClause NVARCHAR(MAX) = 'IF TA1 [OR] TA2 [OR] TA3',
@ResourceId INT = 63;

EXECUTE dbo.Recommendations_Concat
	@Header,
	@SQL,
	@InsertClause,
	@WhereClause,
	@ResourceId
*/

AS
    BEGIN
        SELECT
        ----------HEADER-------------
        @Header = @Header + 'WITH CTE_' + CAST(ResourceId AS VARCHAR) + '(ResourceId)
     AS
', 
        ------------------BODY/WHERECLAUSE------------
        @SQL = @SQL + '( SELECT R.[Id] as ResourceId
				FROM dbo.Resources AS R WHERE R.Id = ' + REPLACE([WhereString], @WhereClause, CAST(ResourceId AS VARCHAR) + ')'),

        ------------------------INSERT------------
        @InsertClause = @InsertClause + 'SELECT ResourceId
		 FROM CTE_' + CAST(ResourceId AS VARCHAR) + ' 
		 UNION'
        FROM [dbo].[Recommendations]
        WHERE Recommendations.ResourceId = @ResourceId;
        PRINT @Header;
        PRINT @SQL;
        PRINT @InsertClause;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Recommendations_Concat_v2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Recommendations_Concat_v2] @SQL          NVARCHAR(MAX), 
                                          @Header       NVARCHAR(MAX), 
                                          @InsertClause NVARCHAR(MAX), 
                                          @WhereClause  NVARCHAR(MAX), 
										  @AnswerClause NVARCHAR(MAX),
										  @AndConcat NVARCHAR(MAX),
                                          @ResourceId   INT,
										  @Id INT

/*
DECLARE 
@SQL NVARCHAR(MAX)= N'', 
@Header NVARCHAR(MAX) = N'',
@InsertClause NVARCHAR(MAX)= N'', 
@WhereClause NVARCHAR(MAX) = 'IF TA1 [OR] TA2 [OR] TA3',
@AnswerClause NVARCHAR(MAX) = N'',
@AndConcat NVARCHAR(MAX) = N'',
@ResourceId INT = 63,
@Id INT = 19

EXECUTE dbo.Recommendations_Concat_V2
	@SQL,
	@Header,
	@InsertClause,
	@WhereClause,
	@AnswerClause,
	@AndConcat,
	@ResourceId,
	@Id 
*/

AS
    BEGIN
        SELECT

		------------------------ANSWER CLAUSE --------------------------
		@AnswerClause = @AnswerClause + 'DECLARE @AnswerList TABLE([AnswerOptionId] INT)


				INSERT INTO  @AnswerList (AnswerOptionId) 
				(SELECT Answers.Id as AnswerOptionId
						 FROM [dbo].[SurveysInstances] as Si 
						 Join dbo.Surveys as S 
							on Si.SurveyId =S.Id 
						 Join dbo.SurveyStatus as Sst
							on Sst.Id =S.StatusId
						 Join dbo.SurveyTypes as St 
							on St.Id= S.SurveyTypeId
						JOIN SurveySections as SS
							on S.Id=Ss.[SurveyId] AND Ss.SurveyId =S.Id
						JOIN dbo.SurveyQuestions as Questions  
							on Ss.Id=Questions.SectionId
						JOIN dbo.SurveyAnswers as Answers 
							on Answers.QuestionId= Questions.Id AND Answers.InstanceId = '+ CAST(@Id AS VARCHAR)+'
						JOIN dbo.SurveyQuestionAnswerOptions as AnswerValues
							on Answers.AnswerOptionId = AnswerValues.Id
						Where Si.Id=' +  CAST(@Id AS VARCHAR)+ ')',

		-----------------------AND CONCAT-----------------------------------
		@AndConcat = @AndConcat + '			 SELECT r.Id 
					
			   FROM dbo.Resources AS R
					JOIN dbo.Recommendations AS RE 
						ON RE.ResourceId = R.Id
					inner  join dbo.Resources as RL
							 on RL.Id = RE.ResourceId
					inner join @Cats AS C
						on c.id = r.id
					WHERE R.Id = 62 AND 
					(
					-- START OF DYNAMIC
					EXISTS(SELECT 1 FROM @AnswerList as AL 
					WHERE	AL.AnswerValues = C.Code 
							AND C.CODE = case 
								when c.code = '+ CAST(@WhereClause AS VARCHAR) +' then  c.code 
								else '+ '-skip' + ' end
							)
					
					) --END OF DYNAMIC
			Group by r.id
			 having count(1)= 2',

        ----------HEADER-------------
        @Header = @Header + 'WITH CTE_' + CAST(ResourceId AS VARCHAR) + '(ResourceId)
     AS
', 
        ------------------BODY/WHERECLAUSE------------
        @SQL = @SQL + '( SELECT R.[Id] as ResourceId
				FROM dbo.Resources AS R WHERE R.Id = ' + REPLACE([WhereString], @WhereClause, CAST(ResourceId AS VARCHAR) + ')'),

        ------------------------INSERT------------
        @InsertClause = @InsertClause + 'SELECT ResourceId
		 FROM CTE_' + CAST(ResourceId AS VARCHAR) + ' 
		 UNION'
        FROM [dbo].[Recommendations]
        WHERE Recommendations.ResourceId = @ResourceId;
		PRINT @AnswerClause;
		PRINT @AndConcat;
        PRINT @Header;
        PRINT @SQL;
        PRINT @InsertClause;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Recommendations_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[Recommendations_Insert]
			@ResourceId  int,
			@WhereString  nvarchar(100)
		
as

/*
	
DECLARE		@ResourceId int = 1,
			@WhereString nvarchar(100) = 'Hello WhereString'
			
	
EXECUTE     [dbo].[Recommendations_Insert]
			@ResourceId,
			@WhereString
			
SELECT * 
FROM [dbo].[Recommendations]
WHERE resourceId = @ResourceId

*/
BEGIN

	INSERT INTO 
		[dbo].[Recommendations]
           ([ResourceId],
			[WhereString])
		    
		   VALUES 
		   (@ResourceId,
			@WhereString)

	SET @ResourceId = SCOPE_IDENTITY()

 END


GO
/****** Object:  StoredProcedure [dbo].[Recommendations_MultiInsert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[Recommendations_MultiInsert]
			@ResourceIds as [ResourceRecommendationType] READONLY,
			@WhereString nvarchar(100) 
		
as

/*
	
DECLARE		@ResourceIds as ResourceRecommendationType,
			@WhereString nvarchar(100) = 'Hello WhereString'
			
insert into @ResourceIds ([ResourceId]) VALUES (7)
insert into @ResourceIds ([ResourceId]) VALUES (29)
insert into @ResourceIds ([ResourceId]) VALUES (30)
	
EXECUTE     [dbo].[Recommendations_MultiInsert]
			@ResourceIds,
			@WhereString
			
SELECT * 
FROM [dbo].[Recommendations]

*/
BEGIN

	INSERT INTO 
		[dbo].[Recommendations]
           ([ResourceId],
			[WhereString])
		    
		   SELECT 
		   [ResourceId],
			@WhereString
			FROM @ResourceIds
 END


GO
/****** Object:  StoredProcedure [dbo].[Recommendations_ResourceCTE]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Recommendations_ResourceCTE] @RiD1 INT, 
												@RiD2 INT,
												@RiD3 INT
AS

/*
DECLARE @RiD1 INT = 56,
		@RiD2 INT =58,
		@RiD3 INT = 64
EXECUTE dbo.Recommendations_ResourceCTE
		@RiD1,
		@RiD2,
		@RiD3
*/

    BEGIN
        DECLARE @MyTable TABLE(Rid INT);
        WITH CTE_Resource1(ResourceId)
             AS (SELECT R.[Id] AS ResourceId
                 FROM dbo.Resources AS R
                 WHERE R.Id = @RiD1),
             CTE_Resource2(ResourceId)
             AS (SELECT R.[Id] AS ResourceId
                 FROM dbo.Resources AS R
                 WHERE R.Id = @RiD2),
			CTE_Resource3(ResourceId)
             AS (SELECT R.[Id] AS ResourceId
                 FROM dbo.Resources AS R
                 WHERE R.Id = @RiD3)
             INSERT INTO @MyTable(Rid)
                    SELECT ResourceId
                    FROM CTE_Resource1
                    UNION
                    SELECT ResourceId
                    FROM CTE_Resource2
					UNION
                    SELECT ResourceId
                    FROM CTE_Resource3;
        SELECT *
        FROM @MyTable;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resource_Insert_Multiple_Id]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC  [dbo].[Resource_Insert_Multiple_Id] 
		    @ResourceList as ResourceListType READONLY

as
BEGIN
/*

DECLARE @ResourceList as ResourceListType
		
INSERT INTO @ResourceList (ResourceId) values (57) 
INSERT INTO @ResourceList (ResourceId) values (63) 

EXECUTE [dbo].[Resource_Insert_Multiple_Id]   @ResourceList


*/

EXECUTE [dbo].[ResourceCategories_Select_ByMutlipleResourceId]
			@ResourceList



END
GO
/****** Object:  StoredProcedure [dbo].[Resource_Recommendation_Config_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resource_Recommendation_Config_Insert]
@ResourceId int,
@AnswerOptionId int

AS

/*
DECLARE @ResourceId int = 57,
		@AnswerOptionId int = 53

EXECUTE dbo.Resource_Recommendation_Config_Insert
		@ResourceId,
		@AnswerOptionId

SELECT * FROM dbo.Resource_Recommendation_Config

*/

INSERT INTO [dbo].[Resource_Recommendation_Config]
           ([ResourceId]
           ,[AnswerOptionId])
     VALUES
           (@ResourceId,
           @AnswerOptionId)
GO
/****** Object:  StoredProcedure [dbo].[Resource_Recommendation_Config_Search_Select_ByInstanceId_V3]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resource_Recommendation_Config_Search_Select_ByInstanceId_V3]

@Id INT,
@PageIndex INT,
@PageSize INT,
@Query NVARCHAR(MAX)


AS

/*

DECLARE @Id INT = 149,
		@PageIndex INT = 0,
		@PageSize INT = 4,
		@Query NVARCHAR(MAX) = 'Business'
EXECUTE [dbo].[Resource_Recommendation_Config_Search_Select_ByInstanceId_V3] 
		@Id,
		@PageIndex,
		@PageSize,
		@Query
					

*/
BEGIN

IF OBJECT_ID('tempdb..#AnswerList') IS NOT NULL DROP TABLE #AnswerList
IF OBJECT_ID('tempdb..#TargetResources') IS NOT NULL DROP TABLE #TargetResources


CREATE TABLE #AnswerList (
[AnswerOptionId] INT,
[AnswerValues] NVARCHAR(50)
)

CREATE TABLE #TargetResources (
	ResourceId INT
)

DECLARE @Cats TABLE(
    Id int,
    Code nvarchar(50),
    CategoryType nvarchar(50)
)


--GENERATE ANSWERS FROM INSTANCE ID
		INSERT INTO  #AnswerList (AnswerOptionId, AnswerValues) 

		SELECT Answers.Id as AnswerOptionId,
				AnswerValues.Value as AnswerValues
         FROM [dbo].[SurveysInstances] as Si 
		 Join dbo.Surveys as S 
			on Si.SurveyId =S.Id 
		 Join dbo.SurveyStatus as Sst
			on Sst.Id =S.StatusId
		 Join dbo.SurveyTypes as St 
			on St.Id= S.SurveyTypeId
		JOIN SurveySections as SS
			on S.Id=Ss.[SurveyId] AND Ss.SurveyId =S.Id
		JOIN dbo.SurveyQuestions as Questions  
			on Ss.Id=Questions.SectionId
		JOIN dbo.SurveyAnswers as Answers 
			on Answers.QuestionId= Questions.Id AND Answers.InstanceId = @Id
		JOIN dbo.SurveyQuestionAnswerOptions as AnswerValues
			on Answers.AnswerOptionId = AnswerValues.Id
        Where Si.Id=@Id

		DECLARE @Prefix nvarchar(max) = N'
			INSERT INTO #TargetResources

			SELECT R.Id
			FROM dbo.Resources AS R
			WHERE R.Id ='
		DECLARE @FinalSQL NVARCHAR(MAX) = ''
		SELECT @FinalSQL = @FinalSQL + @Prefix + Cast(ResourceId as NVARCHAR(MAX)) + CHAR(13) + CHAR(10) +
		Condition + CHAR(13) + CHAR(10)
		FROM dbo.ResourceConditions

		SET @FinalSQL = REPLACE(@FinalSQL, '@AnswerList', '#AnswerList')

		EXEC sp_executesql @FinalSQL 

		
		--JOIN OFF OF #TARGETRESOURCES TO GET RESOURCE INFORMATION WE NEED (AVOID CRAZY MAPPERS/JSON IF NEED BE USE SIMPLE DATA IF NEED BE)
		INSERT INTO @Cats exec [dbo].[SelectAll_Resources_With_Categories] 
		Declare @Offset int = @PageIndex * @PageSize
		SELECT TR.[ResourceId] AS Id,
                  R.[Name], 
                  R.[Headline], 
                  R.[Description], 
                  R.[Logo], 
                  R.[LocationId], 
                  R.[ContactName], 
                  R.[ContactEmail], 
                  R.[Phone], 
                  R.[SiteUrl], 
                  R.[DateCreated], 
                  R.[DateModified],
				         ( SELECT DISTINCT CategoryType
                        FROM @Cats AS C
                        WHERE C.Id = R.Id
                        FOR JSON AUTO) AS ResourceCategoryType,
						TotalCount = COUNT(1) OVER()

		
		FROM #TargetResources as TR
			JOIN Resources AS R ON R.Id = TR.ResourceId
		WHERE (R.[Name] LIKE '%' + @Query + '%') 
			OR (R.[Description] LIKE '%' + @Query + '%') 
			OR (R.[ContactName] LIKE '%' + @Query + '%') 
			OR (R.[ContactEmail] LIKE '%' + @Query + '%') 
			ORDER BY Id  

			OFFSET @offSet Rows
			Fetch Next @PageSize Rows ONLY



			DROP TABLE #AnswerList;
			DROP TABLE #TargetResources;

    END;


	 -- Where (Title LIKE '%' + @Query + '%') 
  --AND ([StatusId] = 1)
GO
/****** Object:  StoredProcedure [dbo].[Resource_Recommendation_Config_Select]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resource_Recommendation_Config_Select]
AS

/*

EXECUTE dbo.Resource_Recommendation_Config_Select

*/

    BEGIN
        SELECT RRC.[ResourceId], 
               RRC.[AnswerOptionId]
        FROM [dbo].[Resource_Recommendation_Config] AS RRC
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resource_Recommendation_Config_Select_ById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resource_Recommendation_Config_Select_ById]

@Id INT


AS

/*
DECLARE @Id INT = 97
EXECUTE [dbo].[Resource_Recommendation_Config_Select_ById] @Id
*/
BEGIN

DECLARE @AnswerList TABLE([AnswerOptionId] INT)


 

INSERT INTO  @AnswerList (AnswerOptionId) 
(SELECT Answers.Id as AnsweOptionId
         FROM [dbo].[SurveysInstances] as Si 
		 Join dbo.Surveys as S 
			on Si.SurveyId =S.Id 
		 Join dbo.SurveyStatus as Sst
			on Sst.Id =S.StatusId
		 Join dbo.SurveyTypes as St 
			on St.Id= S.SurveyTypeId
		JOIN SurveySections as SS
			on S.Id=Ss.[SurveyId] AND Ss.SurveyId =S.Id
		JOIN dbo.SurveyQuestions as Questions  
			on Ss.Id=Questions.SectionId
		JOIN dbo.SurveyAnswers as Answers 
			on Answers.QuestionId= Questions.Id AND Answers.InstanceId = @Id
		JOIN dbo.SurveyQuestionAnswerOptions as AnswerValues
			on Answers.AnswerOptionId = AnswerValues.Id
        Where Si.Id=@Id)

		SELECT * FROM @AnswerList

DECLARE @ResourceList TABLE ([ResourceId] INT)

 INSERT INTO  @ResourceList (ResourceId) (SELECT RRC.[ResourceId]
        FROM [dbo].[Resource_Recommendation_Config] AS RRC
		WHERE AnswerOptionId IN(SELECT * FROM @AnswerList))

DECLARE @Cats TABLE(
    Id int,
    Code nvarchar(50),
    CategoryType nvarchar(50)
)
 
INSERT INTO @Cats EXEC [dbo].[SelectAll_Resources_With_Categories] 
 SELECT       R.[Id], 
              R.[Name], 
              R.[Headline], 
              R.[Description], 
              R.[Logo], 
              R.[LocationId], 
              R.[ContactName], 
              R.[ContactEmail], 
              R.[Phone], 
              R.[SiteUrl], 
              R.[DateCreated], 
              R.[DateModified],
              ( SELECT  CODE,
                        CategoryType
                        FROM @Cats AS C
                        WHERE C.Id = R.Id
                        FOR JSON AUTO) AS ResourceCategoryType
       FROM dbo.Resources AS R
       WHERE R.Id =19
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resource_Recommendation_Config_Select_ByInstanceId]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resource_Recommendation_Config_Select_ByInstanceId]

@Id INT


AS

/*
DECLARE @Id INT = 19
EXECUTE [dbo].[Resource_Recommendation_Config_Select_ByInstanceId] @Id
*/
BEGIN

DECLARE @AnswerList TABLE([AnswerOptionId] INT)


INSERT INTO  @AnswerList (AnswerOptionId) 
(SELECT Answers.Id as AnswerOptionId
         FROM [dbo].[SurveysInstances] as Si 
		 Join dbo.Surveys as S 
			on Si.SurveyId =S.Id 
		 Join dbo.SurveyStatus as Sst
			on Sst.Id =S.StatusId
		 Join dbo.SurveyTypes as St 
			on St.Id= S.SurveyTypeId
		JOIN SurveySections as SS
			on S.Id=Ss.[SurveyId] AND Ss.SurveyId =S.Id
		JOIN dbo.SurveyQuestions as Questions  
			on Ss.Id=Questions.SectionId
		JOIN dbo.SurveyAnswers as Answers 
			on Answers.QuestionId= Questions.Id AND Answers.InstanceId = @Id
		JOIN dbo.SurveyQuestionAnswerOptions as AnswerValues
			on Answers.AnswerOptionId = AnswerValues.Id
        Where Si.Id=@Id)

		SELECT * FROM @AnswerList

DECLARE @ResourceList TABLE ([ResourceId] INT)

 INSERT INTO  @ResourceList (ResourceId) 
 
 SELECT RRC.[ResourceId]
        FROM [dbo].[Resource_Recommendation_Config] AS RRC
		WHERE EXISTS (SELECT 1 
						FROM @AnswerList AS A 
						WHERE A.AnswerOptionId = RRC.AnswerOptionId)

DECLARE @Cats TABLE(
    Id int,
    Code nvarchar(50),
    CategoryType nvarchar(50)
)


 

		INSERT INTO @Cats 
		
		EXEC [dbo].[SelectAll_Resources_With_Categories] 


		 SELECT       R.[Id], 
					  R.[Name], 
					  R.[Headline], 
					  R.[Description], 
					  R.[Logo], 
					  R.[LocationId], 
					  R.[ContactName], 
					  R.[ContactEmail], 
					  R.[Phone], 
					  R.[SiteUrl], 
					  R.[DateCreated], 
					  R.[DateModified],
					  ( SELECT  CODE,
								CategoryType
								FROM @Cats AS C
								WHERE C.Id = R.Id
								FOR JSON AUTO) AS ResourceCategoryType,
					RE.WhereString
			   FROM dbo.Resources AS R
					JOIN dbo.Recommendations AS RE 
						ON RE.ResourceId = R.Id
			   WHERE EXISTS (SELECT 1
							 FROM @ResourceList AS RL
							 WHERE RL.ResourceId = RE.ResourceId)

DECLARE @WhereStrings TABLE ([WhereString] NVARCHAR(MAX))


		INSERT INTO @WhereStrings (WhereString) 

		SELECT [WhereString]
		  FROM [C80].[dbo].[Recommendations] AS RE
		  WHERE EXISTS (SELECT 1
						FROM @ResourceList AS RL
						WHERE RL.ResourceId = RE.ResourceId)


SELECT * FROM @WhereStrings

    END;
GO
/****** Object:  StoredProcedure [dbo].[Resource_Recommendation_Config_Select_ByInstanceId_V2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resource_Recommendation_Config_Select_ByInstanceId_V2]

@Id INT


AS

/*
DECLARE @Id INT = 19
EXECUTE [dbo].[Resource_Recommendation_Config_Select_ByInstanceId_V2] @Id
*/
BEGIN

DECLARE @AnswerList TABLE([AnswerOptionId] INT, AnswerValues nvarchar(50))


INSERT INTO  @AnswerList (AnswerOptionId, AnswerValues) 
		VALUES (19,'TA1'),
				(21, 'TA2'),
				(22, 'LOC3'),
				(23, 'DEMO2'),
				(24, 'ST3')


		--SELECT Answers.Id 
		--		, AnswerValues.Value
		--FROM [dbo].[SurveysInstances] as Si 
		--		Join dbo.Surveys as S 
		--			on Si.SurveyId =S.Id 
		--		Join dbo.SurveyStatus as Sst
		--			on Sst.Id =S.StatusId
		--		Join dbo.SurveyTypes as St 
		--			on St.Id= S.SurveyTypeId
		--		JOIN SurveySections as SS
		--			on S.Id=Ss.[SurveyId] AND Ss.SurveyId =S.Id
		--		JOIN dbo.SurveyQuestions as Questions  
		--			on Ss.Id=Questions.SectionId
		--		JOIN dbo.SurveyAnswers as Answers 
		--			on Answers.QuestionId= Questions.Id AND Answers.InstanceId = @Id
		--		JOIN dbo.SurveyQuestionAnswerOptions as AnswerValues
		--			on Answers.AnswerOptionId = AnswerValues.Id
		--Where Si.Id=@Id


		--SELECT * FROM @AnswerList

DECLARE @ResourceList TABLE ([ResourceId] INT)

 INSERT INTO  @ResourceList (ResourceId)
 
 SELECT RRC.[ResourceId]
        FROM [dbo].[Resource_Recommendation_Config] AS RRC
		WHERE EXISTS (SELECT 1 
						FROM @AnswerList AS A 
						WHERE A.AnswerOptionId = RRC.AnswerOptionId)

DECLARE @Cats TABLE(
    Id int,
    Code nvarchar(50),
    CategoryType nvarchar(50)
)


 

		INSERT INTO @Cats
		
		EXEC [dbo].[SelectAll_Resources_With_Categories] 


		 --SELECT       R.[Id], 
			--		  R.[Name], 
			--		  R.[Headline], 
			--		  R.[Description], 
			--		  R.[Logo], 
			--		  R.[LocationId], 
			--		  R.[ContactName], 
			--		  R.[ContactEmail], 
			--		  R.[Phone], 
			--		  R.[SiteUrl], 
			--		  R.[DateCreated], 
			--		  R.[DateModified],
			--		  ( SELECT  CODE
			--					FROM @Cats AS C
			--					WHERE C.Id = R.Id
			--					FOR JSON AUTO) AS ResourceCategoryType,
			--		RE.WhereString
			--   FROM dbo.Resources AS R
			--		JOIN dbo.Recommendations AS RE 
			--			ON RE.ResourceId = R.Id
			----WHERE C.Code IN ('TA2','LOC6')
			--   WHERE EXISTS (SELECT 1
			--				 FROM @ResourceList AS RL
			--				 WHERE RL.ResourceId = RE.ResourceId)

			 SELECT r.Id
					,C.Code
					,RE.WhereString
			   FROM dbo.Resources AS R
					JOIN dbo.Recommendations AS RE 
						ON RE.ResourceId = R.Id
					inner  join @ResourceList AS RL
							 on RL.ResourceId = RE.ResourceId
					inner join @Cats AS C
						on c.id = r.id

			--WHERE C.Code = 'TA2' OR C.Code = 'TA1'
			WHERE C.Code = 'TA2' AND C.Code = 'CON2'
			--WHERE (SELECT CASE
			--			WHEN C.CODE IN ('TA2', 'LOC6') THEN R.Id
			--		END
			--		FROM Resources)
			--WHERE C.Code IN ('TA2','LOC6')

DECLARE @WhereStrings TABLE ([WhereString] NVARCHAR(MAX))


		INSERT INTO @WhereStrings (WhereString) 

		 SELECT [WhereString]
		  FROM [C80].[dbo].[Recommendations] AS RE
		  WHERE EXISTS (SELECT 1
						FROM @ResourceList AS RL
						WHERE RL.ResourceId = RE.ResourceId)


						select * from @AnswerList

SELECT WhereString as ResWhereString FROM @WhereStrings

    END;
GO
/****** Object:  StoredProcedure [dbo].[Resource_Recommendation_Config_Select_ByInstanceId_V3]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resource_Recommendation_Config_Select_ByInstanceId_V3]

@Id INT,
@PageIndex INT,
@PageSize INT


AS

/*

DECLARE @Id INT = 35,
		@PageIndex INT = 0,
		@PageSize INT = 4
EXECUTE [dbo].[Resource_Recommendation_Config_Select_ByInstanceId_V3] 
		@Id,
		@PageIndex,
		@PageSize
					

*/
BEGIN

IF OBJECT_ID('tempdb..#AnswerList') IS NOT NULL DROP TABLE #AnswerList
IF OBJECT_ID('tempdb..#TargetResources') IS NOT NULL DROP TABLE #TargetResources


CREATE TABLE #AnswerList (
[AnswerOptionId] INT,
[AnswerValues] NVARCHAR(50)
)

CREATE TABLE #TargetResources (
	ResourceId INT
)

DECLARE @Cats TABLE(
    Id int,
    Code nvarchar(50),
	[Name] nvarchar(50),
    CategoryType nvarchar(50)
)


--GENERATE ANSWERS FROM INSTANCE ID
		INSERT INTO  #AnswerList (AnswerOptionId, AnswerValues) 

		SELECT Answers.Id as AnswerOptionId,
				AnswerValues.Value as AnswerValues
         FROM [dbo].[SurveysInstances] as Si 
		 Join dbo.Surveys as S 
			on Si.SurveyId =S.Id 
		 Join dbo.SurveyStatus as Sst
			on Sst.Id =S.StatusId
		 Join dbo.SurveyTypes as St 
			on St.Id= S.SurveyTypeId
		JOIN SurveySections as SS
			on S.Id=Ss.[SurveyId] AND Ss.SurveyId =S.Id
		JOIN dbo.SurveyQuestions as Questions  
			on Ss.Id=Questions.SectionId
		JOIN dbo.SurveyAnswers as Answers 
			on Answers.QuestionId= Questions.Id AND Answers.InstanceId = @Id
		JOIN dbo.SurveyQuestionAnswerOptions as AnswerValues
			on Answers.AnswerOptionId = AnswerValues.Id
        Where Si.Id=@Id

		DECLARE @Prefix nvarchar(max) = N'
			INSERT INTO #TargetResources

			SELECT R.Id
			FROM dbo.Resources AS R
			WHERE R.Id ='
		DECLARE @FinalSQL NVARCHAR(MAX) = ''
		SELECT @FinalSQL = @FinalSQL + @Prefix + Cast(ResourceId as NVARCHAR(MAX)) + CHAR(13) + CHAR(10) +
		Condition + CHAR(13) + CHAR(10)
		FROM dbo.ResourceConditions

		SET @FinalSQL = REPLACE(@FinalSQL, '@AnswerList', '#AnswerList')

		EXEC sp_executesql @FinalSQL 

		
		--JOIN OFF OF #TARGETRESOURCES TO GET RESOURCE INFORMATION WE NEED (AVOID CRAZY MAPPERS/JSON IF NEED BE USE SIMPLE DATA IF NEED BE)
		INSERT INTO @Cats exec [dbo].[SelectAll_Resources_With_Categories_v3] 
		Declare @Offset int = @PageIndex * @PageSize
		SELECT TR.[ResourceId] AS Id,
                  R.[Name], 
                  R.[Headline], 
                  R.[Description], 
                  R.[Logo], 
                  R.[LocationId], 
                  R.[ContactName], 
                  R.[ContactEmail], 
                  R.[Phone], 
                  R.[SiteUrl], 
                  R.[DateCreated], 
                  R.[DateModified],
				         ( SELECT DISTINCT CategoryType,
							[Name]
                        FROM @Cats AS C
                        WHERE C.Id = R.Id
                        FOR JSON AUTO) AS ResourceCategoryType,
						TotalCount = COUNT(1) OVER()

		
		FROM #TargetResources as TR
			JOIN Resources AS R ON R.Id = TR.ResourceId

			ORDER BY Id  

			OFFSET @offSet Rows
			Fetch Next @PageSize Rows ONLY



			DROP TABLE #AnswerList;
			DROP TABLE #TargetResources;

    END;
GO
/****** Object:  StoredProcedure [dbo].[Resource_Recommendation_Config_SelectAll_ByInstanceId_V3]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resource_Recommendation_Config_SelectAll_ByInstanceId_V3]

@Id INT


AS

/*

DECLARE @Id INT = 35
EXECUTE [dbo].[Resource_Recommendation_Config_SelectAll_ByInstanceId_V3] 
		@Id
					

*/
BEGIN

IF OBJECT_ID('tempdb..#AnswerList') IS NOT NULL DROP TABLE #AnswerList
IF OBJECT_ID('tempdb..#TargetResources') IS NOT NULL DROP TABLE #TargetResources


CREATE TABLE #AnswerList (
[AnswerOptionId] INT,
[AnswerValues] NVARCHAR(50)
)

CREATE TABLE #TargetResources (
	ResourceId INT
)

DECLARE @Cats TABLE(
    Id int,
    Code nvarchar(50),
    CategoryType nvarchar(50)
)


--GENERATE ANSWERS FROM INSTANCE ID
		INSERT INTO  #AnswerList (AnswerOptionId, AnswerValues) 

		SELECT Answers.Id as AnswerOptionId,
				AnswerValues.Value as AnswerValues
         FROM [dbo].[SurveysInstances] as Si 
		 Join dbo.Surveys as S 
			on Si.SurveyId =S.Id 
		 Join dbo.SurveyStatus as Sst
			on Sst.Id =S.StatusId
		 Join dbo.SurveyTypes as St 
			on St.Id= S.SurveyTypeId
		JOIN SurveySections as SS
			on S.Id=Ss.[SurveyId] AND Ss.SurveyId =S.Id
		JOIN dbo.SurveyQuestions as Questions  
			on Ss.Id=Questions.SectionId
		JOIN dbo.SurveyAnswers as Answers 
			on Answers.QuestionId= Questions.Id AND Answers.InstanceId = @Id
		JOIN dbo.SurveyQuestionAnswerOptions as AnswerValues
			on Answers.AnswerOptionId = AnswerValues.Id
        Where Si.Id=@Id

		DECLARE @Prefix nvarchar(max) = N'
			INSERT INTO #TargetResources

			SELECT R.Id
			FROM dbo.Resources AS R
			WHERE R.Id ='
		DECLARE @FinalSQL NVARCHAR(MAX) = ''
		SELECT @FinalSQL = @FinalSQL + @Prefix + Cast(ResourceId as NVARCHAR(MAX)) + CHAR(13) + CHAR(10) +
		Condition + CHAR(13) + CHAR(10)
		FROM dbo.ResourceConditions

		SET @FinalSQL = REPLACE(@FinalSQL, '@AnswerList', '#AnswerList')

		EXEC sp_executesql @FinalSQL 

		
		--JOIN OFF OF #TARGETRESOURCES TO GET RESOURCE INFORMATION WE NEED (AVOID CRAZY MAPPERS/JSON IF NEED BE USE SIMPLE DATA IF NEED BE)
		INSERT INTO @Cats exec [dbo].[SelectAll_Resources_With_Categories] 
		SELECT TR.[ResourceId] AS Id,
                  R.[Name], 
                  R.[Headline], 
                  R.[Description], 
                  R.[Logo], 
                  R.[LocationId], 
                  R.[ContactName], 
                  R.[ContactEmail], 
                  R.[Phone], 
                  R.[SiteUrl], 
                  R.[DateCreated], 
                  R.[DateModified],
				         ( SELECT DISTINCT CategoryType
                        FROM @Cats AS C
                        WHERE C.Id = R.Id
                        FOR JSON AUTO) AS ResourceCategoryType

		
		FROM #TargetResources as TR
			JOIN Resources AS R ON R.Id = TR.ResourceId

			ORDER BY Id 



			DROP TABLE #AnswerList;
			DROP TABLE #TargetResources;

    END;
GO
/****** Object:  StoredProcedure [dbo].[Resource_Recommendation_Config_SelectAll_ByInstanceId_V4]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resource_Recommendation_Config_SelectAll_ByInstanceId_V4]

@Id INT


AS

/*

DECLARE @Id INT = 35
EXECUTE [dbo].[Resource_Recommendation_Config_SelectAll_ByInstanceId_V4] 
		@Id
					

*/
BEGIN

IF OBJECT_ID('tempdb..#AnswerList') IS NOT NULL DROP TABLE #AnswerList
IF OBJECT_ID('tempdb..#TargetResources') IS NOT NULL DROP TABLE #TargetResources


CREATE TABLE #AnswerList (
[AnswerOptionId] INT,
[AnswerValues] NVARCHAR(50)
)

CREATE TABLE #TargetResources (
	ResourceId INT
)

DECLARE @Cats TABLE(
    Id int,
    Code nvarchar(50),
	[Name] nvarchar(50),
    CategoryType nvarchar(50)
)


--GENERATE ANSWERS FROM INSTANCE ID
		INSERT INTO  #AnswerList (AnswerOptionId, AnswerValues) 

		SELECT Answers.Id as AnswerOptionId,
				AnswerValues.Value as AnswerValues
         FROM [dbo].[SurveysInstances] as Si 
		 Join dbo.Surveys as S 
			on Si.SurveyId =S.Id 
		 Join dbo.SurveyStatus as Sst
			on Sst.Id =S.StatusId
		 Join dbo.SurveyTypes as St 
			on St.Id= S.SurveyTypeId
		JOIN SurveySections as SS
			on S.Id=Ss.[SurveyId] AND Ss.SurveyId =S.Id
		JOIN dbo.SurveyQuestions as Questions  
			on Ss.Id=Questions.SectionId
		JOIN dbo.SurveyAnswers as Answers 
			on Answers.QuestionId= Questions.Id AND Answers.InstanceId = @Id
		JOIN dbo.SurveyQuestionAnswerOptions as AnswerValues
			on Answers.AnswerOptionId = AnswerValues.Id
        Where Si.Id=@Id

		DECLARE @Prefix nvarchar(max) = N'
			INSERT INTO #TargetResources

			SELECT R.Id
			FROM dbo.Resources AS R
			WHERE R.Id ='
		DECLARE @FinalSQL NVARCHAR(MAX) = ''
		SELECT @FinalSQL = @FinalSQL + @Prefix + Cast(ResourceId as NVARCHAR(MAX)) + CHAR(13) + CHAR(10) +
		Condition + CHAR(13) + CHAR(10)
		FROM dbo.ResourceConditions

		SET @FinalSQL = REPLACE(@FinalSQL, '@AnswerList', '#AnswerList')

		EXEC sp_executesql @FinalSQL 

		
		--JOIN OFF OF #TARGETRESOURCES TO GET RESOURCE INFORMATION WE NEED (AVOID CRAZY MAPPERS/JSON IF NEED BE USE SIMPLE DATA IF NEED BE)
		INSERT INTO @Cats exec [dbo].[SelectAll_Resources_With_Categories_v3] 
		SELECT TR.[ResourceId] AS Id,
                  R.[Name], 
                  R.[Headline], 
                  R.[Description], 
                  R.[Logo], 
                  R.[LocationId], 
                  R.[ContactName], 
                  R.[ContactEmail], 
                  R.[Phone], 
                  R.[SiteUrl], 
                  R.[DateCreated], 
                  R.[DateModified],
				         ( SELECT DISTINCT CategoryType,
											C.[Name]
                        FROM @Cats AS C
                        WHERE C.Id = R.Id
						

                        FOR JSON AUTO) AS ResourceCategoryType

		
		FROM #TargetResources as TR
			JOIN Resources AS R ON R.Id = TR.ResourceId

			ORDER BY Id 



			DROP TABLE #AnswerList;
			DROP TABLE #TargetResources;

    END;
GO
/****** Object:  StoredProcedure [dbo].[Resource_Search_WithCatTypes]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resource_Search_WithCatTypes] @PageIndex INT, 
                                                @PageSize  INT, 
                                                @Query     NVARCHAR(MAX)
AS

/*

DECLARE		@pageIndex int = 0,
			@pageSize int = 200,
			@Query nvarchar(MAX) = 'Pacific'

EXECUTE [dbo].[Resource_Search_WithCatTypes]
			@pageIndex,
			@pageSize,
			@Query
*/

     DECLARE @Offset INT= @PageIndex * @PageSize;
     DECLARE @Cats TABLE
     (Id           INT, 
      CatId        INT, 
      Code         NVARCHAR(50), 
      [Name]       NVARCHAR(50), 
      CategoryType NVARCHAR(50)
     );
     INSERT INTO @Cats
     EXEC [dbo].[SelectAll_Resources_With_Categories_v2];
    BEGIN
        SELECT R.Id, 
               R.[Name], 
               R.[Headline], 
               R.[Description], 
               R.[Logo], 
               R.[LocationId], 
               R.[ContactName], 
               R.[ContactEmail], 
               R.[Phone], 
               R.[SiteUrl], 
               R.[DateCreated], 
               R.[DateModified], 
        (
            SELECT DISTINCT 
                   Id, 
                   [Name], 
                   Code, 
                   CategoryType
            FROM @Cats AS C
            WHERE C.Id = R.Id FOR JSON AUTO
        ) AS ResourceCategoryType, 
               TotalCount = COUNT(0) OVER()
        FROM dbo.Resources AS R
        WHERE([Name] LIKE '%' + @query + '%')
             OR (Headline LIKE '%' + @query + '%')
             OR ([Description] LIKE '%' + @query + '%')
             OR (Logo LIKE '%' + @query + '%')
             OR (LocationId LIKE '%' + @query + '%')
             OR (ContactName LIKE '%' + @query + '%')
             OR (ContactEmail LIKE '%' + @query + '%')
             OR (Phone LIKE '%' + @query + '%')
             OR (SiteUrl LIKE '%' + @query + '%')
        ORDER BY R.Id DESC
        OFFSET @Offset ROWS FETCH NEXT @pageSize ROWS ONLY;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resource_Select_WithCatTypes]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resource_Select_WithCatTypes] @PageIndex INT, 
                                                @PageSize  INT
AS

/*

DECLARE		@pageIndex int = 0,
			@pageSize int = 200

EXECUTE [dbo].[Resource_Select_WithCatTypes]
			@pageIndex,
			@pageSize
*/

     DECLARE @Offset INT= @PageIndex * @PageSize;
     DECLARE @Cats TABLE
     (RId          INT, 
      CatId        INT, 
      Code         NVARCHAR(50), 
      [Name]       NVARCHAR(50), 
      CategoryType NVARCHAR(50)
     );
     INSERT INTO @Cats
     EXEC [dbo].[SelectAll_Resources_With_Categories_v2];
    BEGIN
        SELECT R.Id, 
               R.[Name], 
               R.[Headline], 
               R.[Description], 
               R.[Logo], 
               R.[LocationId], 
               R.[ContactName], 
               R.[ContactEmail], 
               R.[Phone], 
               R.[SiteUrl], 
               R.[DateCreated], 
               R.[DateModified], 
        (
            SELECT DISTINCT 
                   C.CatId AS Id, 
                   [Name] AS [Name], 
                   Code, 
                   CategoryType
            FROM @Cats AS C
            WHERE C.RId = R.Id FOR JSON AUTO
        ) AS ResourceCategoryType, 
               TotalCount = COUNT(1) OVER()
        FROM dbo.Resources AS r
        ORDER BY R.Id DESC
        OFFSET @offset ROWS FETCH NEXT @pageSize ROWS ONLY;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ResourceCapital_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[ResourceCapital_Insert]
			@ResourceId INT,
			@CapitalTypeId INT

AS

/*

	DECLARE 
			@ResourceId int = 1
			,@CapitalTypeId int = 2
			


	EXEC dbo.ResourceCapital_Insert 
								@ResourceId 
								,@CapitalTypeId
							

	
	SELECT *
	FROM dbo.ResourceCapital

*/

BEGIN

	INSERT INTO [dbo].[ResourceCapital]
			   ([ResourceId]
			   ,[CapitalTypesId])
		 VALUES
			   (
				   @ResourceId,
				   @CapitalTypeId
			   );

END




GO
/****** Object:  StoredProcedure [dbo].[ResourceCapital_MultipleInsert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResourceCapital_MultipleInsert] @Id           INT, 
                                                  @CapitalTypes AS RESOURCECAPITALTYPE READONLY
AS

/*

DECLARE @Id int = 7
DECLARE @CapitalTypes as ResourceCapitalType

insert into @CapitalTypes (CapitalTypesId) values (3)
insert into @CapitalTypes (CapitalTypesId) values (1)

Execute dbo.ResourceCapital_MultipleInsert @Id,
										  @CapitalTypes

select * from dbo.ResourceCapital

*/

    BEGIN
        INSERT INTO [dbo].[ResourceCapital]
        ([ResourceId], 
         [CapitalTypesId]
        )
               SELECT @Id, [CapitalTypesId]
               FROM @CapitalTypes;
	END;
GO
/****** Object:  StoredProcedure [dbo].[ResourceCapital_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[ResourceCapital_SelectAll]
			@pageIndex int = 0
			,@pageSize int = 10


as

/*

	DECLARE 
			@pageIndex int = 0
			,@pageSize int = 10

	DECLARE @offset int = @pageIndex * @pageSize
				
				SELECT	
						[ResourceId]
						,[CapitalTypesId]
						,TotalCount = COUNT(1) OVER()

			FROM dbo.ResourceCapital
			
			ORDER BY ResourceCapital.ResourceId
			
			OFFSET @offSet Rows
			
			Fetch Next @pageSize Rows ONLY
	
			EXEC dbo.ResourceCapital_SelectAll;

	

*/
BEGIN
		DECLARE @offset int = @pageIndex * @pageSize

		SELECT [ResourceId]
			  ,[CapitalTypesId]
			  ,TotalCount = COUNT(1) OVER()

		  FROM [dbo].[ResourceCapital]
		  ORDER BY dbo.ResourceCapital.ResourceId
		  OFFSET @offset Rows
		  FETCH Next @pageSize Rows ONLY

END


GO
/****** Object:  StoredProcedure [dbo].[ResourceCategories_Delete_ByResourceId]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[ResourceCategories_Delete_ByResourceId]
			@ResourceId int
AS

/*
	DECLARE 
			@ResourceId int = 0;
			EXEC dbo.ResourceCategories @ResourceId;
*/

BEGIN
		DELETE FROM [dbo].[ResourceCategories]
			WHERE ResourceId = @ResourceId
END
GO
/****** Object:  StoredProcedure [dbo].[ResourceCategories_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResourceCategories_Insert] @ResourceId         INT, 
                                             @ConsultingTypeId   INT = NULL, 
                                             @ContractingTypeId  INT = NULL, 
                                             @LocationZoneTypeId INT = NULL, 
                                             @IsNetworking       BIT
AS

/*
			DECLARE
					@ResourceId int = 65,
					@ConsultingTypeId int = 3,
					@ContractingTypeId int = 1,
					@LocationZoneTypeId int = 4,
					@IsNetworking bit = 0;

			EXEC [dbo].[ResourceCategories_Insert]
					@ResourceId,
					@ConsultingTypeId,
					@ContractingTypeId,
					@LocationZoneTypeId,
					@IsNetworking
			SELECT * From [dbo].[ResourceCategories]

*/

    BEGIN
        INSERT INTO [dbo].[ResourceCategories]
        ([ResourceId], 
         [ConsultingTypeId], 
         [ContractingTypeId], 
         [LocationZoneTypeId], 
         [IsNetworking]
        )
        VALUES
        (@ResourceId, 
         @ConsultingTypeId, 
         @ContractingTypeId, 
         @LocationZoneTypeId, 
         @IsNetworking
        );
    END;
GO
/****** Object:  StoredProcedure [dbo].[ResourceCategories_Select_ByConsultingType]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResourceCategories_Select_ByConsultingType] @ConsultingTypeId INT
AS

/*

		DECLARE @ConsultingTypeId int = 2;

		EXECUTE dbo.ResourceCategories_Select_ByConsultingType 

		@ConsultingTypeId

*/

    BEGIN
        SELECT R.[ResourceId], 
               CT.[Name] AS ConsultingTypes, 
               CTT.[Name] AS ContractingTypes, 
               LZ.[Name] AS LocationType, 
               R.[IsNetworking]
        FROM [dbo].[ResourceCategories] AS R
             JOIN dbo.LocationZoneTypes AS LZ ON LZ.Id = R.LocationZoneTypeId
             JOIN dbo.ConsultingTypes AS CT ON CT.Id = R.ConsultingTypeId
             JOIN dbo.ContractingTypes AS CTT ON CTT.Id = R.ContractingTypeId
        WHERE R.ConsultingTypeId = @ConsultingTypeId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ResourceCategories_Select_ByConsultingType_V2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResourceCategories_Select_ByConsultingType_V2]
AS

/*
EXECUTE dbo.ResourceCategories_Select_ByConsultingType_V2 
*/

    BEGIN
        SELECT R.[ResourceId],
            RE.[Name], 
            RE.[Headline], 
            RE.[Description], 
            RE.[Logo], 
            RE.[LocationId], 
            RE.[ContactName], 
            RE.[ContactEmail], 
            RE.[Phone], 
            RE.[SiteUrl], 
            RE.[DateCreated], 
            RE.[DateModified], 
             CT.[Name] AS ConsultingTypes,
			 CT.Code
        FROM [dbo].[ResourceCategories] AS R
			JOIN dbo.Resources as RE ON RE.Id = R.ResourceId
             JOIN dbo.ConsultingTypes AS CT ON CT.Id = R.ConsultingTypeId
    END;
GO
/****** Object:  StoredProcedure [dbo].[ResourceCategories_Select_ByContractingType]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResourceCategories_Select_ByContractingType] @ContractingTypeId INT
AS

/*
	DECLARE @ContractingTypeId int = 1;
	
	EXEC dbo.ResourceCategories_Select_ByContractingType

	@ContractingTypeId

*/

    BEGIN
        SELECT RC.[ResourceId], 
               CT.[Name] AS ConsultingTypes, 
               CTT.[Name] AS ContractingTypes, 
               LZ.[Name] AS LocationType, 
               RC.[IsNetworking]
        FROM [dbo].[ResourceCategories] AS RC
             JOIN dbo.LocationZoneTypes AS LZ ON LZ.Id = RC.LocationZoneTypeId
             JOIN dbo.ConsultingTypes AS CT ON CT.Id = RC.ConsultingTypeId
             JOIN dbo.ContractingTypes AS CTT ON CTT.Id = RC.ContractingTypeId
        WHERE RC.ContractingTypeId = @ContractingTypeId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ResourceCategories_Select_ByContractingType_V2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResourceCategories_Select_ByContractingType_V2]
AS

/*
EXEC dbo.ResourceCategories_Select_ByContractingType_V2
*/

    BEGIN
        SELECT R.[ResourceId],
            RE.[Name], 
            RE.[Headline], 
            RE.[Description], 
            RE.[Logo], 
            RE.[LocationId], 
            RE.[ContactName], 
            RE.[ContactEmail], 
            RE.[Phone], 
            RE.[SiteUrl], 
            RE.[DateCreated], 
            RE.[DateModified], 
             CON.[Name] AS ContractingTypes,
			 CON.Code
        FROM [dbo].[ResourceCategories] AS R
			JOIN dbo.Resources as RE ON RE.Id = R.ResourceId
             JOIN dbo.ContractingTypes AS CON ON CON.Id = R.ConsultingTypeId
    END;
GO
/****** Object:  StoredProcedure [dbo].[ResourceCategories_Select_ByMutlipleResourceId]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResourceCategories_Select_ByMutlipleResourceId]
@ResourceList as dbo.ResourceListType READONLY



AS


/*




*/

BEGIN

DECLARE @Cats TABLE(
    Id int,
    Code nvarchar(50),
    CategoryType nvarchar(50)
)
 
INSERT INTO @Cats EXEC [dbo].[SelectAll_Resources_With_Categories] 
 SELECT       R.[Id], 
              R.[Name], 
              R.[Headline], 
              R.[Description], 
              R.[Logo], 
              R.[LocationId], 
              R.[ContactName], 
              R.[ContactEmail], 
              R.[Phone], 
              R.[SiteUrl], 
              R.[DateCreated], 
              R.[DateModified],
              ( SELECT  CODE,
                        CategoryType
                        FROM @Cats AS C
                        WHERE C.Id = R.Id
                        FOR JSON AUTO) AS ResourceCategoryType
       FROM dbo.Resources AS R
       WHERE R.Id IN (SELECT * FROM @ResourceList)

END
GO
/****** Object:  StoredProcedure [dbo].[ResourceCategories_Select_ByResourceId]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResourceCategories_Select_ByResourceId] @ResourceId INT
AS

/*
		DECLARE @ResourceId int = 1;
		EXEC dbo.ResourceCategories_Select_ByResourceId 
		@ResourceId


*/

    BEGIN
        SELECT [ResourceId], 
               [ConsultingTypeId], 
               [ContractingTypeId], 
               [LocationZoneTypeId], 
               [IsNetworking]
        FROM [dbo].[ResourceCategories]
        WHERE ResourceId = @ResourceId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ResourceCategories_Select_LocationType]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResourceCategories_Select_LocationType] @LocationZoneTypeId INT
AS

/*

		DECLARE @LocationZoneTypeId int = 1;

		EXECUTE dbo.ResourceCategories_Select_LocationType
				@LocationZoneTypeId

*/

    BEGIN
        SELECT R.[ResourceId], 
               CT.[Name] AS ConsultingTypes, 
               CTT.[Name] AS ContractingTypes, 
               LZ.[Name] AS LocationType, 
               R.[IsNetworking]
        FROM [dbo].[ResourceCategories] AS R
             JOIN dbo.LocationZoneTypes AS LZ ON LZ.Id = R.LocationZoneTypeId
             JOIN dbo.ConsultingTypes AS CT ON CT.Id = R.ConsultingTypeId
             JOIN dbo.ContractingTypes AS CTT ON CTT.Id = R.ContractingTypeId
        WHERE R.LocationZoneTypeId = @LocationZoneTypeId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ResourceCategories_Select_LocationType_V2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResourceCategories_Select_LocationType_V2] 
AS

/*
EXECUTE dbo.ResourceCategories_Select_LocationType_V2
*/

    BEGIN
        SELECT R.[ResourceId],
            RE.[Name], 
            RE.[Headline], 
            RE.[Description], 
            RE.[Logo], 
            RE.[LocationId], 
            RE.[ContactName], 
            RE.[ContactEmail], 
            RE.[Phone], 
            RE.[SiteUrl], 
            RE.[DateCreated], 
            RE.[DateModified], 
             LOC.[Name] AS LocationZoneType,
			 LOC.Code
        FROM [dbo].[ResourceCategories] AS R
			JOIN dbo.Resources as RE ON RE.Id = R.ResourceId
             JOIN dbo.LocationZoneTypes AS LOC ON LOC.Id = R.ConsultingTypeId
    END;
GO
/****** Object:  StoredProcedure [dbo].[ResourceCategories_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResourceCategories_SelectAll]
AS

/*


		EXEC dbo.ResourceCategories_SelectAll 

*/

    BEGIN
        SELECT [ResourceId], 
               [ConsultingTypeId], 
               [ContractingTypeId], 
               [LocationZoneTypeId], 
               [IsNetworking]
        FROM [dbo].[ResourceCategories]
        ORDER BY ResourceId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ResourceCategories_SelectAll_V2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResourceCategories_SelectAll_V2]
AS

/*


		EXEC dbo.ResourceCategories_SelectAll_V2 

*/

    BEGIN
        SELECT R.Id,
				R.[Name],
				R.[Headline],
				R.[Description],
				R.[Logo],
				R.[LocationId],
				R.[ContactName],
				R.[ContactEmail],
				R.[Phone],
				R.[SiteUrl],
				R.[DateCreated],
				R.[DateModified],
			   RCA.CapitalTypesId,
			   RD.DemographicTypesId,
			   RI.IndustryTypesId,
			   RCO.ComplianceTypesId,
               RC.[ConsultingTypeId], 
               RC.[ContractingTypeId], 
               RC.[LocationZoneTypeId] 

        FROM [dbo].[Resources] AS R
			JOIN ResourceCategories AS RC
				ON RC.ResourceId = R.Id
			LEFT JOIN ResourceCapital AS RCA
				on RCA.ResourceId = R.Id
			LEFT JOIN ResourceCompliances AS RCO
				ON RCO.ResourceId = R.Id
			LEFT JOIN ResourceDemographics AS RD
				ON RD.ResourceId = R.Id
			LEFT JOIN ResourceIndustries AS RI
				ON RI.ResourceId = R.Id
			LEFT JOIN ResourceSpecialTopics AS RST
				ON RST.SpecialTopicId = R.Id
        ORDER BY R.Id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ResourceCategories_SelectAll_V3]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResourceCategories_SelectAll_V3] @Id INT
AS

/* --------- TEST CODE -----------------------------


		DECLARE @Id int = 97;

		EXEC dbo.ResourceCategories_SelectAll_V3 @Id 


*/ -------------------------------------------------

    BEGIN
        SELECT R.Id, 
               R.[Name], 
               R.[Headline], 
               R.[Description], 
               R.[Logo], 
               R.[LocationId], 
               R.[ContactName], 
               R.[ContactEmail], 
               R.[Phone], 
               R.[SiteUrl], 
               R.[DateCreated], 
               R.[DateModified], 
               RC.[ConsultingTypeId], 
               CT.[Name] AS ConsultingType, 
               RC.[ContractingTypeId], 
               CONT.[Name] ContractingType,
               RC.[LocationZoneTypeId], 
               LZT.[Name] AS locationZone,
			   RCA.[CapitalTypesId],
			   CapT.[Name] AS CapitalType,
			   RI.[IndustryTypesId],
			   IT.[Name] AS IndustryType,
			   RD.[DemographicTypesId],
			   DGT.[Name] AS DemoType,
			   ReC.[ComplianceTypesId],
			   CompT.[Name] AS ComplianceType,
			   RSPT.[SpecialTopicId],
			   SPT.[Name] AS SpecialTopicType
        FROM [dbo].[Resources] AS R
             Inner JOIN ResourceCategories AS RC ON RC.ResourceId = R.Id
             inner JOIN LocationZoneTypes AS LZT ON RC.LocationZoneTypeId = LZT.Id
             inner JOIN ConsultingTypes AS CT ON RC.ConsultingTypeId = CT.Id
             inner JOIN ContractingTypes AS CONT ON RC.ContractingTypeId = CONT.Id
             inner JOIN ResourceCapital AS RCA ON RCA.ResourceId = R.Id
			 inner JOIN CapitalTypes as CapT on RCA.CapitalTypesId = CapT.Id
			 inner JOIN ResourceIndustries AS RI on RI.ResourceId = R.Id
			 inner JOIN IndustryTypes AS IT on RI.IndustryTypesId = IT.Id
			 inner JOIN ResourceDemographics AS RD ON RD.ResourceId = R.Id
			 inner JOIN DemographicTypes AS DGT ON RD.DemographicTypesId = DGT.Id
			 inner JOIN ResourceCompliances AS ReC ON  ReC.ResourceId = R.Id
			 inner JOIN ComplianceTypes AS CompT ON ReC.ComplianceTypesId = CompT.Id
			 inner JOIN ResourceSpecialTopics AS RSPT ON RSPT.ResourceId = R.Id
			 inner JOIN SpecialTopicTypes AS SPT ON RSPT.SpecialTopicId = SPT.Id
     
        WHERE R.Id = @Id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ResourceCategories_Update]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[ResourceCategories_Update]
			@ResourceId int,
			@ConsultingTypeId int,
			@ContractingTypeId int,
			@LocationZoneTypeId int,
			@IsNetworking bit

AS
/*

			DECLARE
					@ResourceId int,
					@ConsultingTypeId int = 432,
					@ContractingTypeId int = 8765,
					@LocationZoneTypeId int =345,
					@IsNetworking bit = 0;

			EXECUTE [dbo].[ResourceCategories_Update]
					@ResourceId,
					@ConsultingTypeId,
					@ContractingTypeId,
					@LocationZoneTypeId,
					@IsNetworking;

			SELECT * FROM [dbo].[ResourceCategories]

*/

BEGIN
	
	UPDATE 
		[dbo].[ResourceCategories]
	SET
			[ConsultingTypeId] = @ConsultingTypeId,
			[ContractingTypeId] = @ContractingTypeId,
			[LocationZoneTypeId] = @LocationZoneTypeId,
			[IsNetworking] = @IsNetworking
	WHERE
			@ResourceId = @ResourceId;
	END
GO
/****** Object:  StoredProcedure [dbo].[ResourceCompliances_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[ResourceCompliances_Insert]

			@ResourceId int
			,@ComplianceTypesId int
			
AS

/*			TEST CODE

	DECLARE  
			@ResourceId int = 1234
			,@ComplianceTypesId int = 1234

	EXECUTE dbo.ResourceCompliances_Insert 

			@ResourceId
			,@ComplianceTypesId

	SELECT *
	FROM dbo.ResourceCompliances
*/

BEGIN

	INSERT INTO  [dbo].[ResourceCompliances]
				([ResourceId]
				,[ComplianceTypesId])
	VALUES
				(@ResourceId
				,@ComplianceTypesId)

		SET @ResourceId = SCOPE_IDENTITY()

END
GO
/****** Object:  StoredProcedure [dbo].[ResourceCompliances_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[ResourceCompliances_SelectAll]


AS

BEGIN

/*
	EXECUTE dbo.ResourceCompliances_SelectAll
*/

	SELECT
			[ResourceId],
			[ComplianceTypesId]


	FROM	[dbo].[ResourceCompliances]
	ORDER BY ResourceId

	END
GO
/****** Object:  StoredProcedure [dbo].[ResourceCondition_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[ResourceCondition_Insert]
			@ResourceId  int,
			@Condition  NVARCHAR(MAX)
		
as

/*
	
DECLARE		@ResourceId int = 1,
			@Condition varchar(MAX) = 'Hello WhereString'
			
	
EXECUTE     [dbo].[ResourceCondition_Insert]
			@ResourceId,
			@Condition
			
SELECT * 
FROM [dbo].[ResourceCondition]
WHERE resourceId = @ResourceId

*/
BEGIN

	INSERT INTO 
		[dbo].[ResourceConditions]
           ([ResourceId],
			[Condition])
		    
		   VALUES 
		   (@ResourceId,
			@Condition)


 END


GO
/****** Object:  StoredProcedure [dbo].[ResourceCondition_MultiInsert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[ResourceCondition_MultiInsert]
			@ResourceIds as [ResourceRecommendationType] READONLY,
			@Condition nvarchar(max),
			@Query NVARCHAR(MAX)
		
as

/*
	
DECLARE		@ResourceIds as ResourceRecommendationType,
			@Condition nvarchar(max) = 'Hello WhereString',
			@Query NVARCHAR(MAX) ='SADFASD',
			
insert into @ResourceIds ([ResourceId]) VALUES (7)
insert into @ResourceIds ([ResourceId]) VALUES (29)
insert into @ResourceIds ([ResourceId]) VALUES (30)
	
EXECUTE     [dbo].[ResourceCondition_MultiInsert]
			@ResourceIds,
			@Condition,
			@Query
			
SELECT * 
FROM [dbo].[Condition]

*/
BEGIN

	INSERT INTO 
		[dbo].[ResourceConditions]
           ([ResourceId],
			[Condition],
			[Query])
		    
		   SELECT 
		   [ResourceId],
			@Condition,
			@Query
			FROM @ResourceIds
 END


GO
/****** Object:  StoredProcedure [dbo].[ResourceConditions_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResourceConditions_SelectAll]
AS

/*

EXEC ResourceConditions_SelectAll

*/

    BEGIN 
	SELECT
               R.Id, 
               R.[Name], 
               R.[Headline], 
               R.[Description], 
               R.[Logo], 
               R.[LocationId], 
               R.[ContactName], 
               R.[ContactEmail], 
               R.[Phone], 
               R.[SiteUrl], 
               R.[DateCreated], 
               R.[DateModified],
				RC.[Condition] AS ConditionString, 
               RC.[Query]
        FROM [dbo].[Resources] AS R
             LEFT JOIN dbo.ResourceConditions AS RC ON R.Id = RC.ResourceId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ResourceConditions_SelectById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResourceConditions_SelectById]
											@Id int
AS

/*
DECLARE @Id int = 99


EXEC ResourceConditions_SelectById
@Id


*/

    BEGIN 
	SELECT
               R.Id, 
               R.[Name], 
               R.[Headline], 
               R.[Description], 
               R.[Logo], 
               R.[LocationId], 
               R.[ContactName], 
               R.[ContactEmail], 
               R.[Phone], 
               R.[SiteUrl], 
               R.[DateCreated], 
               R.[DateModified],
				RC.[Condition] AS ConditionString, 
               RC.[Query]
        FROM [dbo].[Resources] AS R
             LEFT JOIN dbo.ResourceConditions AS RC ON R.Id = RC.ResourceId
			 Where R.Id = @Id
    END;
GO
/****** Object:  StoredProcedure [dbo].[ResourceConditions_Update]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResourceConditions_Update]
@ResourceId INT,
@Condition NVARCHAR(MAX),
@Query NVARCHAR(MAX)

as

/*
DECLARE @ResourceId INT = 11,
@Condition NVARCHAR(MAX) ='',
@Query NVARCHAR(MAX) = ''

exec ResourceConditions_Update
	@ResourceId,
	@Condition,
	@Query

*/

UPDATE [dbo].[ResourceConditions]
   SET [ResourceId] = @ResourceId
      ,[Condition] = @Condition
      ,[Query] = @Query
	  WHERE ResourceId = @ResourceId
GO
/****** Object:  StoredProcedure [dbo].[ResourceDemographics_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[ResourceDemographics_Insert]
		@ResourceId INT,
		@DemographicTypesId INT

/* ---------------TEST CODE---------------------

DECLARE
		@ResourceId INT = 0,
		@DemographicTypesId INT = 0

EXECUTE dbo.ResourceDemographics_Insert
		
		@ResourceId,
		@DemographicTypesId
		

	Select *
	From dbo.ResourceDemographics
	WHERE ResourceId = @ResourceId

*/

AS

BEGIN

INSERT INTO [dbo].[ResourceDemographics]
           ([ResourceId]
           ,[DemographicTypesId])
     VALUES
           (@ResourceId
           ,@DemographicTypesId)
	SET @ResourceId = SCOPE_IDENTITY();

END
GO
/****** Object:  StoredProcedure [dbo].[ResourceDemographics_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[ResourceDemographics_SelectAll] @pageIndex INT = 0,
												@pageSize INT = 10

AS

/* -------------------TEST CODE-----------------------

Declare @pageIndex INT = 0,
		@pageSize INT = 5

Execute dbo.ResourceDemographics_SelectAll

		@pageIndex,
		@pageSize

*/

	BEGIN
		DECLARE @offset INT = @pageIndex * @pageSize;
		SELECT	[ResourceId],
				[DemographicTypesId],
				TOTALCOUNT = COUNT(1) OVER()
		FROM dbo.ResourceDemographics
		ORDER BY ResourceDemographics.ResourceId
		OFFSET @offset ROWS FETCH NEXT @pageSize ROWS ONLY;
	END
GO
/****** Object:  StoredProcedure [dbo].[ResourceIndustries_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[ResourceIndustries_Insert]
										@ResourceId int,
										@IndustryTypesId int

AS		
/*------ Test Code -------



	Declare  
			@ResourceId int = 1,
			@IndustryTypesId int = 1

	Execute [dbo].[ResourceIndustries_Insert]
			@ResourceId 
			,@IndustryTypesId 

	Select *
	From dbo.ResourceIndustries
	

*/
BEGIN

INSERT INTO [dbo].[ResourceIndustries]
		(
		[ResourceId],
		[IndustryTypesId]
		)
		

     VALUES 
        (
		@ResourceId,
		@IndustryTypesId
		)
           
		SET @ResourceId = SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [dbo].[ResourceIndustries_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[ResourceIndustries_SelectAll]
											@pageIndex INT
											,@pageSize  INT
AS
/* ------------ TEST CODE -----------------

		DECLARE 
				@pageIndex int = 0
			   ,@pageSize int = 5

		EXECUTE dbo.ResourceIndustries_SelectAll
				 @pageIndex
				,@pageSIze

*/ 
BEGIN
        DECLARE @offset INT= @pageIndex * @pageSize;
         
		SELECT	[ResourceId] 
			   ,[IndustryTypesId]
               ,TotalCount = COUNT(1) OVER()

        FROM dbo.ResourceIndustries

        ORDER BY ResourceIndustries.ResourceId

        OFFSET @offset ROWS FETCH NEXT @pageSize ROWS ONLY;
END
GO
/****** Object:  StoredProcedure [dbo].[Resources_CapitalTypes_Update]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_CapitalTypes_Update]  @Id             INT, 
                                                   @CapitalTypesId AS ResourceCapitalType READONLY
AS
    BEGIN
        DELETE FROM [dbo].[ResourceCapital]
		WHERE ResourceId = @Id

        INSERT INTO [dbo].[ResourceCapital]
        ([ResourceId], 
         [CapitalTypesId]
        )
               SELECT @Id, 
                      [CapitalTypesId]
               FROM @CapitalTypesId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_ComplianceTypes_Update]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[Resources_ComplianceTypes_Update]  @Id             INT, 
                                                      @ComplianceTypesId AS ResourceComplianceType READONLY
AS
    BEGIN
        DELETE FROM [dbo].[ResourceCompliances]
		WHERE ResourceId = @Id

        INSERT INTO [dbo].[ResourceCompliances]
        ([ResourceId], 
         [ComplianceTypesId]
        )
               SELECT @Id, 
                      [ComplianceTypesId]
               FROM @ComplianceTypesId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_Delete_ById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_Delete_ById] @Id INT
AS

/*

DECLARE  @Id int = 79

SELECT *
FROM dbo.Resources
WHERE Id = @Id

EXECUTE [dbo].[Resources_Delete_ById] @Id
		             
SELECT *
FROM dbo.Resources 
WHERE Id = @Id

*/

    BEGIN
        DELETE FROM [dbo].[ResourceConditions]
        WHERE ResourceId = @Id;
        DELETE FROM [dbo].[ResourceCategories]
        WHERE ResourceId = @Id;
        DELETE FROM [dbo].[ResourceCapital]
        WHERE ResourceId = @Id;
        DELETE FROM [dbo].[ResourceCompliances]
        WHERE ResourceId = @Id;
        DELETE FROM [dbo].[ResourceDemographics]
        WHERE ResourceId = @Id;
        DELETE FROM [dbo].[ResourceSpecialTopics]
        WHERE ResourceId = @Id;
        DELETE FROM [dbo].[ResourceIndustries]
        WHERE ResourceId = @Id;
        DELETE FROM [dbo].[Resources]
        WHERE Id = @Id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_DemographicTypes_Update]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_DemographicTypes_Update]  @Id             INT, 
                                                      @DemographicTypesId AS ResourceDemographicsType READONLY
AS
    BEGIN
        DELETE FROM [dbo].[ResourceDemographics] 
		WHERE ResourceId = @Id

        INSERT INTO [dbo].[ResourceDemographics]
        ([ResourceId], 
         [DemographicTypesId]
        )  
               SELECT @Id, 
                      [DemographicTypesId]
               FROM @DemographicTypesId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_IndustryTypes_Update]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_IndustryTypes_Update] @Id              INT, 
                                                  @IndustryTypesId AS RESOURCEINDUSTRYTYPE READONLY
AS
    BEGIN
        DELETE FROM [dbo].[ResourceIndustries]
        WHERE ResourceId = @Id;
        INSERT INTO [dbo].[ResourceIndustries]
        ([ResourceId], 
         [IndustryTypesId]
        )
               SELECT @Id, 
                      [IndustryTypesId]
               FROM @IndustryTypesId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[Resources_Insert] 
			@Id int OUTPUT,
			@Name nvarchar(200),
			@Headline nvarchar(200),
			@Description nvarchar(1000),
			@Logo nvarchar(255),
			@LocationId int,
			@ContactName nvarchar(200),
			@ContactEmail nvarchar(255),
			@Phone nvarchar(50),
			@SiteUrl nvarchar(255)
	


AS

/*--------TEST CODE-------------

    Declare @Id int, 
			@Name nvarchar(200) = 'Sabio Resource 2',
			@Headline nvarchar(200) = 'Sabio Resource Table Insert Test 2',
			@Description nvarchar(1000) = 'This is a test',
			@Logo nvarchar(255) = 'Logo can be null',
			@LocationId int = '1',
			@ContactName nvarchar(200) = 'Zach',
			@ContactEmail nvarchar(255) = 'sabiola@sabio.com',
			@Phone nvarchar(50) = '949-555-5555',
			@SiteUrl nvarchar(255) = 'www.sabiola.com'
		
	Execute dbo.Resources_Insert
			@Id OUTPUT,	
			@Name,
			@Headline,
			@Description,
			@Logo,
			@LocationId,
			@ContactName,
			@ContactEmail,
			@Phone,
			@SiteUrl

	Select * 
    FROM dbo.Resources

*/------------------------------ 
BEGIN

INSERT INTO [dbo].[Resources]
           ([Name]
           ,[Headline]
           ,[Description]
           ,[Logo]
           ,[LocationId]
           ,[ContactName]
           ,[ContactEmail]
           ,[Phone]
           ,[SiteUrl])
     VALUES
            (@Name,
             @Headline, 
             @Description, 
             @Logo, 
             @LocationId, 
             @ContactName, 
             @ContactEmail,
             @Phone, 
             @SiteUrl)
            
			 SET @Id = SCOPE_IDENTITY()
END


GO
/****** Object:  StoredProcedure [dbo].[Resources_Insert_V2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_Insert_V2] @Id             INT OUTPUT, 
                                       @LocationTypeId INT, 
                                       @LineOne        NVARCHAR(255), 
                                       @LineTwo        NVARCHAR(255), 
                                       @City           NVARCHAR(225), 
                                       @Zip            NVARCHAR(50), 
                                       @StateId        INT, 
                                       @Latitude       FLOAT, 
                                       @Longitude      FLOAT, 
                                       @CreatedBy      INT, 
                                       @ModifiedBy     INT, 
                                       @Name           NVARCHAR(200), 
                                       @Headline       NVARCHAR(200), 
                                       @Description    NVARCHAR(1000), 
                                       @Logo           NVARCHAR(255), 
                                       @LocationId     INT, 
                                       @ContactName    NVARCHAR(200), 
                                       @ContactEmail   NVARCHAR(255), 
                                       @Phone          NVARCHAR(50), 
                                       @SiteUrl        NVARCHAR(255)
AS

/* ---Test Code---

DECLARE		@Id int,
			@LocationTypeId  int = 1,
			@LineOne  nvarchar(255) = 'PROCEDUREe',
			@LineTwo  nvarchar(255) = 'Testing',
			@City  nvarchar(225) = 'Testing',
			@Zip  nvarchar(50) = 'Testing',
			@StateId  int = 1,
			@Latitude float = 1.1,
			@Longitude  float = 1.1,			
			@CreatedBy  int = 1,
			@ModifiedBy int = 1,

			@Name nvarchar(200) = 'PROCEDUREe',
			@Headline nvarchar(200) = 'Testing',
			@Description nvarchar(1000) = 'Testing',
			@Logo nvarchar(255) = 'Testing',
			@LocationId int = 1,
			@ContactName nvarchar(200) = 'Testing',
			@ContactEmail nvarchar(255) = 'Testing',
			@Phone nvarchar(50) = 'Testing',
			@SiteUrl nvarchar(255) = 'Testing'

EXECUTE [dbo].[Resources_Insert_V2]
			@Id OUTPUT,
			@LocationTypeId,
			@LineOne,
			@LineTwo,
			@City,
			@Zip,
			@StateId,
			@Latitude,
			@Longitude,			
			@CreatedBy,
			@ModifiedBy,

			@Name,
			@Headline,
			@Description,
			@Logo,
			@LocationId,
			@ContactName,
			@ContactEmail,
			@Phone,
			@SiteUrl

SELECT *
FROM [dbo].[Locations] 

SELECT * 
FROM [dbo].[Resources]

*/

    ---Test Code---

    BEGIN
        INSERT INTO [dbo].[Locations]
        (L.[LocationTypeId], 
         L.[LineOne], 
         L.[LineTwo], 
         L.[City], 
         L.[Zip], 
         L.[StateId], 
         L.[Latitude], 
         L.[Longitude], 
         L.[CreatedBy], 
         L.[ModifiedBy]
        )
        VALUES
        (@LocationTypeId, 
         @LineOne, 
         @LineTwo, 
         @City, 
         @Zip, 
         @StateId, 
         @Latitude, 
         @Longitude, 
         @CreatedBy, 
         @ModifiedBy
        );
        SET @Id = SCOPE_IDENTITY();
        INSERT INTO [dbo].[Resources]
        (R.[Name], 
         R.[Headline], 
         R.[Description], 
         R.[Logo], 
         R.[LocationId], 
         R.[ContactName], 
         R.[ContactEmail], 
         R.[Phone], 
         R.[SiteUrl]
        )
        VALUES
        (@Name, 
         @Headline, 
         @Description, 
         @Logo, 
         @LocationId, 
         @ContactName, 
         @ContactEmail, 
         @Phone, 
         @SiteUrl
        );
        SET @Id = SCOPE_IDENTITY();
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_Insert_V3]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_Insert_V3] @Id                 INT OUTPUT, 
                                       @Name               NVARCHAR(200), 
                                       @Headline           NVARCHAR(200), 
                                       @Description        NVARCHAR(1000), 
                                       @Logo               NVARCHAR(255), 
                                       @LocationId         INT, 
                                       @ContactName        NVARCHAR(200), 
                                       @ContactEmail       NVARCHAR(255), 
                                       @Phone              NVARCHAR(50), 
                                       @SiteUrl            NVARCHAR(255), 
                                       @ConsultingTypeId   INT, 
                                       @ContractingTypeId  INT, 
                                       @LocationTypeId     INT, 
                                       @CapitalTypes AS       RESOURCECAPITALTYPE READONLY, 
                                       @ComplianceTypes AS    RESOURCECOMPLIANCETYPE READONLY, 
                                       @DemographicTypes AS   RESOURCEDEMOGRAPHICSTYPE READONLY, 
                                       @SpecialTopicsTypes AS RESOURCESPECIALTOPICSTYPE READONLY, 
                                       @IndustryTypes AS      RESOURCEINDUSTRYTYPE READONLY
AS

/*
INSERT into @DemographicTypes ([DemographicTypesId]) values (1)
INSERT into @DemographicTypes ([DemographicTypesId]) values (2)
INSERT into @SpecialTopicsTypes ([SpecialTopicId]) values (2)
INSERT into @SpecialTopicsTypes ([SpecialTopicId]) values (1)
INSERT into @IndustryTypes ([IndustryTypesId]) values (1)
INSERT into @IndustryTypes ([IndustryTypesId]) values (3)
INSERT into @ComplianceTypes ([ComplianceTypesId]) values (1)
INSERT into @ComplianceTypes ([ComplianceTypesId]) values (2)
INSERT into @CapitalTypes ([CapitalTypesId]) values (3)
INSERT into @CapitalTypes ([CapitalTypesId]) values (1)

DECLARE @Id int = 0

DECLARE @CapitalTypes AS RESOURCECAPITALTYPE
DECLARE @ComplianceTypes AS RESOURCECOMPLIANCETYPE
DECLARE @DemographicTypes AS RESOURCEDEMOGRAPHICSTYPE
DECLARE @SpecialTopicsTypes AS RESOURCESPECIALTOPICSTYPE
DECLARE @IndustryTypes AS RESOURCEINDUSTRYTYPE


DECLARE @Name NVARCHAR(200) = 'Tesdtinf respurce', 
        @Headline NVARCHAR(200) = 'We Help Businesses at Every Stage',  
        @Description  NVARCHAR(1000) = 'Helping small businesses all over LA County.', 
        @Logo NVARCHAR(255) = 'https://pcrsbdc.org/wp-content/themes/pcr/images/la-sbdc.png', 
        @LocationId INT = '7', 
        @ContactName NVARCHAR(200) = 'Maria Salazar', 
        @ContactEmail NVARCHAR(255) = 'MariaSalazar@gmail.com', 
        @Phone NVARCHAR(50) = '213-674-2696', 
        @SiteUrl NVARCHAR(255) = 'https://pcrsbdc.org/', 
		@ConsultingTypeId  INT = '1', 
        @ContractingTypeId INT = '2', 
        @LocationTypeId    INT = '1' 


EXECUTE dbo.Resources_Insert_V3 @Id OUTPUT, 
								@Name, 
								@Headline, 
								@Description, 
								@Logo, 
								@LocationId, 
								@ContactName, 
								@ContactEmail, 
								@Phone, 
								@SiteUrl, 
								@ConsultingTypeId, 
                                @ContractingTypeId, 
								@LocationTypeId, 
								@CapitalTypes, 
								@ComplianceTypes, 
								@DemographicTypes, 
								@SpecialTopicsTypes, 
								@IndustryTypes 

SELECT *
FROM [dbo].[Resources]

SELECT *
FROM [dbo].[ResourceCategories]

SELECT *
FROM [dbo].[ResourceCapital]

SELECT *
FROM [dbo].[ResourceCompliances]

SELECT *
FROM [dbo].[ResourceDemographics]

SELECT *
FROM [dbo].[ResourceIndustries]

SELECT *
FROM [dbo].[ResourceSpecialTopics]

*/

     SET XACT_ABORT ON;
     DECLARE @tran NVARCHAR(50)= 'transaction';
    BEGIN TRY
        BEGIN TRANSACTION @tran;
        INSERT INTO [dbo].[Resources]
        ([Name], 
         [Headline], 
         [Description], 
         [Logo], 
         [LocationId], 
         [ContactName], 
         [ContactEmail], 
         [Phone], 
         [SiteUrl]
        )
        VALUES
        (@Name, 
         @Headline, 
         @Description, 
         @Logo, 
         @LocationId, 
         @ContactName, 
         @ContactEmail, 
         @Phone, 
         @SiteUrl
        );
        SET @Id = SCOPE_IDENTITY();
        IF(@ConsultingTypeId IS NOT NULL
           OR @ContractingTypeId IS NOT NULL
           OR @LocationTypeId IS NOT NULL)
            BEGIN
                INSERT INTO [dbo].[ResourceCategories]
                ([ResourceId], 
                 [ConsultingTypeId], 
                 [ContractingTypeId], 
                 [LocationZoneTypeId]
                )
                VALUES
                (@Id, 
                 @ConsultingTypeId, 
                 @ContractingTypeId, 
                 @LocationTypeId
                );
        END;
        IF(
        (
            SELECT COUNT([CapitalTypesId])
            FROM @CapitalTypes
        ) > 0)
            BEGIN
                INSERT INTO [dbo].[ResourceCapital]
                ([ResourceId], 
                 [CapitalTypesId]
                )
                       SELECT @Id, 
                              [CapitalTypesId]
                       FROM @CapitalTypes AS ct;
        END;
        IF(
        (
            SELECT COUNT([ComplianceTypesId])
            FROM @ComplianceTypes
        ) > 0)
            BEGIN
                INSERT INTO [dbo].[ResourceCompliances]
                ([ResourceId], 
                 [ComplianceTypesId]
                )
                       SELECT @Id, 
                              [ComplianceTypesId]
                       FROM @ComplianceTypes;
        END;
        IF(
        (
            SELECT COUNT([DemographicTypesId])
            FROM @DemographicTypes
        ) > 0)
            BEGIN
                INSERT INTO [dbo].[ResourceDemographics]
                ([ResourceId], 
                 [DemographicTypesId]
                )
                       SELECT @Id, 
                              [DemographicTypesId]
                       FROM @DemographicTypes;
        END;
        IF(
        (
            SELECT COUNT([SpecialTopicId])
            FROM @SpecialTopicsTypes
        ) > 0)
            BEGIN
                INSERT INTO [dbo].[ResourceSpecialTopics]
                ([ResourceId], 
                 [SpecialTopicId]
                )
                       SELECT @Id, 
                              [SpecialTopicId]
                       FROM @SpecialTopicsTypes;
        END;
        IF(
        (
            SELECT COUNT([IndustryTypesId])
            FROM @IndustryTypes
        ) > 0)
            BEGIN
                INSERT INTO [dbo].[ResourceIndustries]
                ([ResourceId], 
                 [IndustryTypesId]
                )
                       SELECT @Id, 
                              [IndustryTypesId]
                       FROM @IndustryTypes;
        END;
        COMMIT TRANSACTION @tran;
    END TRY
    BEGIN CATCH
        IF(XACT_STATE()) = -1
            BEGIN
                PRINT 'The transaction is in an uncommittable state.' + ' Rolling back transaction.';
                ROLLBACK TRANSACTION @Tran;
        END;
        IF(XACT_STATE()) = 1
            BEGIN
                PRINT 'The transaction is committable.' + ' Committing transaction.';
                COMMIT TRANSACTION @Tran;
        END;
        THROW;
    END CATCH;
     SET XACT_ABORT OFF;
GO
/****** Object:  StoredProcedure [dbo].[Resources_Search]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Resources_Search] @pageIndex INT, 
                                    @pageSize  INT, 
                                    @query     NVARCHAR(50)
AS

/*
    DECLARE @query nvarchar(50) = 'Test'
    ,@pageSize int = 10
    ,@PageIndex int = 0
    EXECUTE dbo. Resources_Search @query, @pageIndex, @pageSize
*/

    BEGIN
        SELECT [Id], 
               [Name], 
               [Headline], 
               [Description], 
               [Logo], 
               [LocationId], 
               [ContactName], 
               [ContactEmail], 
               [Phone], 
               [SiteUrl], 
               TotalCount = COUNT(1) OVER()
        FROM [dbo].[Resources]
        WHERE([Name] LIKE '%' + @query + '%')
             OR (Headline LIKE '%' + @query + '%')
             OR ([Description] LIKE '%' + @query + '%')
             OR (Logo LIKE '%' + @query + '%')
             OR (LocationId LIKE '%' + @query + '%')
             OR (ContactName LIKE '%' + @query + '%')
             OR (ContactEmail LIKE '%' + @query + '%')
             OR (Phone LIKE '%' + @query + '%')
             OR (SiteUrl LIKE '%' + @query + '%')
        ORDER BY resources.Id desc
        OFFSET @PageIndex ROWS FETCH NEXT @pageSize ROWS ONLY;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_SearchDetails]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_SearchDetails] @Query NVARCHAR(50)
AS

/*
DECLARE @Query NVARCHAR(50)	= 'v.3'

EXECUTE [dbo].[Resources_SearchDetails] @Query

*/

    BEGIN
        SELECT R.[Id], 
               R.[Name], 
               R.[Headline], 
               R.[Description], 
               R.[Logo], 
               R.[LocationId], 
               R.[ContactName], 
               R.[ContactEmail], 
               R.[Phone], 
               R.[SiteUrl], 
               R.[DateCreated], 
               R.[DateModified], 
               L.[Id], 
               L.[LocationTypeId], 
               L.[LineOne], 
               L.[LineTwo], 
               L.[City], 
               L.[Zip], 
               L.[StateId], 
               L.[Latitude], 
               L.[Longitude], 
               L.[DateCreated], 
               L.[DateModified], 
               L.[CreatedBy], 
               L.[ModifiedBy],
			   CT.[Name] AS ConsultingTypeId,
			   CO.[Name] AS ContractingTypeId,
			   LT.[Name] AS LocationZoneTypeId

        FROM dbo.Resources AS R
             JOIN Locations AS L ON R.LocationId = L.Id
			 JOIN ResourceCategories as RC ON RC.ResourceId = R.Id
			 LEFT JOIN dbo.ConsultingTypes as CT on CT.Id = RC.ConsultingTypeId
			 LEFT JOIN dbo.ContractingTypes as CO on CO.Id = RC.ContractingTypeId
			 LEFT JOIN dbo.LocationZoneTypes as LT on LT.Id = RC.LocationZoneTypeId
			 
        WHERE(R.[Name] LIKE '%' + @Query + '%'
              OR [Headline] LIKE '%' + @Query + '%'
              OR [Description] LIKE '%' + @Query + '%');
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_Select_ById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_Select_ById] @Id INT
AS

/*------TEST CODE--------------

Declare @Id int = 13

Execute dbo.Resources_Select_ById 
		@Id

*/

    -----------------------------
    BEGIN
        DECLARE @TABLE TABLE
       (Id           INT, 
         CatId        INT, 
         Code         NVARCHAR(50), 
         [Name]       NVARCHAR(50), 
         CategoryType NVARCHAR(50)
        );
        INSERT INTO @TABLE
        EXEC [dbo].[SelectAll_Resources_With_Categories_By_ResourceId] 
             @Id;
        SELECT [Id], 
               [Name], 
               [Headline], 
               [Description], 
               [Logo], 
               [LocationId], 
               [ContactName], 
               [ContactEmail], 
               [Phone], 
               [SiteUrl], 
               [DateCreated], 
               [DateModified], 
        (
            SELECT T.CatId AS Id, 
                   T.Code, 
                   T.[Name], 
                   T.CategoryType
            FROM @TABLE AS T FOR JSON AUTO
        ) AS Categories
        FROM [dbo].[Resources]
        WHERE Id = @Id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_Select_Details_ByCapital]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[Resources_Select_Details_ByCapital]
			@CapitalTypesId int 

as

/*

	DECLARE  @CapitalTypesId int = 1

	EXECUTE dbo.Resources_Select_Details_ByCapital @CapitalTypesId

*/

BEGIN

		SELECT 
				R.[Id]
				,R.[Name]
				,R.[Headline]
				,R.[Description]
				,R.[Logo]
				,R.[LocationId]
				,R.[ContactName]
				,R.[ContactEmail]
				,R.[Phone]
				,R.[SiteUrl]
				,R.[DateCreated]
				,R.[DateModified]
				,L.[Id]
				,L.[LocationTypeId]
				,L.[LineOne]
				,L.[LineTwo]
				,L.[City]
				,L.[Zip]
				,L.[StateId]
				,L.[Latitude]
				,L.[Longitude]
				,L.[DateCreated]
				,L.[DateModified]
				,L.[CreatedBy]
				,L.[ModifiedBy]
				,CT.[Name] AS ConsultingType
				,CTT.[Name] AS ContractingType
                ,LZT.[Name] AS LocationZoneType

			FROM [dbo].Resources as R
				
				join dbo.Locations as L on L.Id = R.LocationId
				join dbo.ResourceCapital as RC on RC.ResourceId = R.Id
				join dbo.ResourceCategories as RCT on RCT.ResourceId = R.Id
				join dbo.ConsultingTypes as CT on RCT.ConsultingTypeId = CT.Id
				join dbo.ContractingTypes AS CTT ON CTT.Id = RCT.ContractingTypeId
				join dbo.LocationZoneTypes AS LZT ON LZT.Id = RCT.LocationZoneTypeId

			WHERE RC.[CapitalTypesId] = @CapitalTypesId
			
END


GO
/****** Object:  StoredProcedure [dbo].[Resources_Select_Details_ByCompliances]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_Select_Details_ByCompliances]
				@ComplianceTypesId int
AS 

/*					TEST CODE
	
	DECLARE @ComplianceTypesId int = 1
	EXECUTE dbo.Resources_Select_Details_ByCompliances @ComplianceTypesId

*/

BEGIN 
	
	SELECT
		 R.Id AS ResourceId
		,R.[Name]
		,R.Headline
		,R.[Description]
		,R.Logo
		,R.LocationId
		,R.ContactName
		,R.ContactEmail
		,R.Phone
		,R.SiteUrl
		,R.DateCreated AS ResourceDateCreated
		,R.DateModified AS ResourceDateModified

		,L.Id AS LocationId
		,L.LocationTypeId
		,L.LineOne
		,L.LineTwo
		,L.City
		,L.Zip
		,L.StateId
		,L.Latitude
		,L.Longitude
		,L.DateCreated AS LocationDateCreated
		,L.DateModified AS LocationDateModified
		,L.CreatedBy
		,L.ModifiedBy

		,RC.ResourceId
		,RC.ConsultingTypeId
		,RC.ContractingTypeId
		,RC.LocationZoneTypeId
		,RC.IsNetworking

		,CST.[Name] as ConsultingType
		,CTR.[Name] as ContractingType
		,LZ.[Id] as LocationZoneType

		,CT.[Id] as ComplianceType

		,RCT.ResourceId as Resource
		,RCT.ComplianceTypesId

	FROM dbo.ComplianceTypes AS CT
		JOIN dbo.ResourceCompliances AS RCT 
			ON CT.Id = RCT.ResourceId
		JOIN dbo.Resources AS R 
			ON RCT.ResourceId = R.Id
		JOIN dbo.Locations AS L 
			ON R.LocationId = L.Id
		JOIN dbo.ResourceCategories AS RC 
			ON RC.ResourceId = R.Id
		JOIN dbo.ConsultingTypes AS CST 
			ON R.Id = CST.Id
		JOIN dbo.ContractingTypes AS CTR 
			ON R.Id = CTR.Id
		JOIN dbo.LocationZoneTypes AS LZ 
			ON R.Id = LZ.Id

	WHERE CT.Id = @ComplianceTypesId

END
		
GO
/****** Object:  StoredProcedure [dbo].[Resources_Select_Details_ByConsultingType]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Resources_Select_Details_ByConsultingType]
													@ConsultingTypeId int
AS
/*

DECLARE @ConsultingTypeId int = 1

EXECUTE dbo.Resources_Select_Details_ByConsultingType @ConsultingTypeId

*/



BEGIN

	SELECT	
		
			R.[Id],
			R.[Name],
			R.[Headline],
			R.[Description],
			R.[Logo],
			R.[LocationId],
			R.[ContactName],
			R.[ContactEmail],
			R.[Phone],
			R.[SiteUrl],
			R.[DateCreated],
			R.[DateModified],
			
			RC.[ContractingTypeId],
			RC.[LocationZoneTypeId],
			RC.[IsNetworking],
			L.[LineOne],
			L.[LineTwo],
			L.[City],
			L.[Zip],
			L.[StateId],
			L.[Latitude],
			L.[Longitude],
			L.[DateCreated],
			L.[DateModified],
			L.[ModifiedBy],

			CT.[Name] AS ConsultingType,
			CNT.[Name] AS ContractingType, 
            LZT.[Name] AS LocationZoneType
		


	

	FROM [dbo].[Resources] AS R
	JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = R.Id
	LEFT JOIN dbo.ConsultingTypes AS CT ON RC.ConsultingTypeId = CT.Id
	LEFT JOIN dbo.ContractingTypes AS CNT ON CNT.Id = RC.ContractingTypeId
	LEFT JOIN dbo.LocationZoneTypes AS LZT ON LZT.Id = RC.LocationZoneTypeId
	JOIN [dbo].[Locations] AS L ON L.Id = R.LocationId

	WHERE RC.ConsultingTypeId = @ConsultingTypeId


END

GO
/****** Object:  StoredProcedure [dbo].[Resources_Select_Details_ByContractingType]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_Select_Details_ByContractingType] @ContractingTypeId INT
AS

/* ------------- TEST CODE ----------

DECLARE @ContractingTypeId int = 1

EXECUTE dbo.Resources_Select_Details_ByContractingType @ContractingTypeId

*/

    BEGIN
        SELECT R.[Id], 
               R.[Name], 
               R.[Headline], 
               R.[Description], 
               R.[Logo], 
               R.[LocationId], 
               R.[ContactName], 
               R.[ContactEmail], 
               R.[Phone], 
               R.[SiteUrl], 
               R.[DateCreated], 
               R.[DateModified], 
               L.LocationTypeId, 
               L.Id, 
               L.LineTwo, 
               L.LineTwo, 
               L.City, 
               L.Zip, 
               L.StateId, 
               L.Latitude, 
               L.Longitude, 
               L.CreatedBy, 
               L.ModifiedBy, 
               L.DateCreated, 
               L.DateModified, 
               CT.[Name] AS ConsultingType, 
               CNT.[Name] AS ContractingType, 
               LZT.[Name] AS LocationZoneType
        FROM dbo.Resources AS R
             JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = R.Id
             LEFT JOIN dbo.ConsultingTypes AS CT ON RC.ConsultingTypeId = CT.Id
             LEFT JOIN dbo.ContractingTypes AS CNT ON CNT.Id = RC.ContractingTypeId
             LEFT JOIN dbo.LocationZoneTypes AS LZT ON LZT.Id = RC.LocationZoneTypeId
             JOIN dbo.Locations AS L ON L.Id = R.LocationId
        WHERE RC.ContractingTypeId = @ContractingTypeId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_Select_Details_ByContractingType_V2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_Select_Details_ByContractingType_V2]
AS

/* ------------- TEST CODE ----------
EXECUTE dbo.Resources_Select_Details_ByContractingType_V2
*/

    BEGIN
        SELECT R.[Id], 
               R.[Name], 
               R.[Headline], 
               R.[Description], 
               R.[Logo], 
               R.[LocationId], 
               R.[ContactName], 
               R.[ContactEmail], 
               R.[Phone], 
               R.[SiteUrl], 
               R.[DateCreated], 
               R.[DateModified], 
               L.LocationTypeId, 
               L.Id, 
               L.LineTwo, 
               L.LineTwo, 
               L.City, 
               L.Zip, 
               L.StateId, 
               L.Latitude, 
               L.Longitude, 
               L.CreatedBy, 
               L.ModifiedBy, 
               L.DateCreated, 
               L.DateModified, 
			   CNT.Id AS ContractingTypeId,
               CNT.[Name] AS ContractingType, 
			   CNT.Code AS ContractingTypeCode
        FROM dbo.Resources AS R
             JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = R.Id
             LEFT JOIN dbo.ContractingTypes AS CNT ON CNT.Id = RC.ContractingTypeId
             JOIN dbo.Locations AS L ON L.Id = R.LocationId
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_Select_Details_ByDemographics]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[Resources_Select_Details_ByDemographics]
			@DemographicTypesId int

as
/*

DECLARE @DemographicTypesId int =1
EXECUTE dbo.Resources_Select_Details_ByDemographics @DemographicTypesId


*/
Begin

		Select	Rd.[ResourceId],
				Rd.[DemographicTypesId],
				ConsT.[Name] as ConsultingType,
				ContrT.[Name] as ContractingType,
				Lzt.[Id] as LocationZoneType,
				Rc.IsNetworking as IsNetworking,
				Res.[Name] as ResourceName,
				Res.[Headline] as ResourceHeadline,
				Res.[Description] as ResourceDescription,
				Res.[Logo] as ResourceLogo,
				Res.[ContactName] as ResourceContactName,
				Res.[ContactEmail] as ResourceContactEmail,
				Res.[Phone] as ResourceContactPhone,
				Res.[SiteUrl] as ResourceSiteUrl,
				Loct.[Name] as LocationType,
				Loc.[LineOne] as LocationLineOne,
				Loc.[LineTwo] as LocationLineTwo,
				Loc.[City] as LocationCity,
				Loc.[Zip] as LocationZip,
				Loc.[StateId] as LocationStateId,
				Loc.Latitude as LocationLatitude,
				Loc.Longitude as LocationLongitude


		

		FROM	dbo.[ResourceDemographics] as Rd
				JOIN dbo.ResourceCategories as Rc 
					on Rd.ResourceId= Rc.ResourceId
				JOIN dbo.ConsultingTypes as ConsT 
					on Rd.ResourceId=ConsT.Id
				JOIN dbo.ContractingTypes as ContrT 
					on Rd.ResourceId=ContrT.Id
				JOIN dbo.LocationZoneTypes as Lzt 
					on Rd.ResourceId=Lzt.Id
				JOIN dbo.Resources as Res 
					on Rd.ResourceId=Res.Id
				JOIN dbo.Locations as Loc 
					on Res.LocationId=Loc.Id
				Join dbo.LocationTypes as LocT 
					on Loc.LocationTypeId=LocT.Id

		Where Rd.[DemographicTypesId]= @DemographicTypesId

END
GO
/****** Object:  StoredProcedure [dbo].[Resources_Select_Details_ByDemographics_V2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[Resources_Select_Details_ByDemographics_V2]

as
/*

EXECUTE dbo.Resources_Select_Details_ByDemographics_V2


*/
Begin

		Select	R.[Id], 
               R.[Name], 
               R.[Headline], 
               R.[Description], 
               R.[Logo], 
               R.[LocationId], 
               R.[ContactName], 
               R.[ContactEmail], 
               R.[Phone], 
               R.[SiteUrl], 
               R.[DateCreated], 
               R.[DateModified], 
               L.LocationTypeId, 
               L.Id AS LocationId, 
               L.LineTwo, 
               L.LineTwo, 
               L.City, 
               L.Zip, 
               L.StateId, 
               L.Latitude, 
               L.Longitude, 
               L.CreatedBy, 
               L.ModifiedBy, 
               L.DateCreated, 
               L.DateModified,
			   DT.Id as DemographicTypeId,
			   DT.Name as DemographicTypeName,
			   DT.Code as DemographicTypeCode 
		FROM	dbo.Resources as R
				JOIN Locations as L 
					on L.Id = r.LocationId
				JOIN ResourceDemographics as RD 
					on RD.ResourceId = R.Id
				JOIN DemographicTypes as DT
					ON DT.Id = RD.DemographicTypesId


END
GO
/****** Object:  StoredProcedure [dbo].[Resources_Select_Details_ById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_Select_Details_ById] @Id INT
AS

/* ----------- TEST CODE ---------

DECLARE @Id int = 97

EXECUTE dbo.Resources_Select_Details_ById @Id

select *
from dbo.Locations

select *
from dbo.Resources

select *
from dbo.ResourceCategories

*/

    BEGIN
        SELECT R.[Id], 
               R.[Name], 
               R.[Headline], 
               R.[Description], 
               R.[Logo], 
               R.[LocationId], 
               R.[ContactName], 
               R.[ContactEmail], 
               R.[Phone], 
               R.[SiteUrl], 
               R.[DateCreated], 
               R.[DateModified], 
               L.[Id], 
               L.[LocationTypeId], 
               L.[LineOne], 
               L.[LineTwo], 
               L.[City], 
               L.[Zip], 
               L.[StateId], 
               L.[Latitude], 
               L.[Longitude], 
               L.[DateCreated], 
               L.[DateModified], 
               L.[CreatedBy], 
               L.[ModifiedBy], 
               CT.[Name] AS ConsultingType, 
               CNT.[Name] AS ContractingType, 
               LZT.[Name] AS LocationZoneType
        FROM [dbo].[Resources] AS R
             JOIN dbo.Locations AS L ON L.Id = R.LocationId
             JOIN dbo.ResourceCategories AS RC ON RC.LocationZoneTypeId = L.LocationTypeId
             LEFT JOIN dbo.ConsultingTypes AS CT ON RC.ConsultingTypeId = CT.Id
             LEFT JOIN dbo.ContractingTypes AS CNT ON CNT.Id = RC.ContractingTypeId
             LEFT JOIN dbo.LocationZoneTypes AS LZT ON LZT.Id = RC.LocationZoneTypeId
        WHERE R.Id = @Id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_Select_Details_ById_V2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_Select_Details_ById_V2] @Id INT
AS

/* ----------- TEST CODE ---------

DECLARE @Id int = 97

EXECUTE dbo.Resources_Select_Details_ById_V2 @Id

*/
DECLARE @Cats TABLE(
    Id int,
    Code nvarchar(50),
    CategoryType nvarchar(50)
)

INSERT INTO @Cats exec [dbo].[SelectAll_Resources_With_Categories] 
    BEGIN
        SELECT R.[Id], 
               R.[Name], 
               R.[Headline], 
               R.[Description], 
               R.[Logo], 
               R.[LocationId], 
               R.[ContactName], 
               R.[ContactEmail], 
               R.[Phone], 
               R.[SiteUrl], 
               R.[DateCreated], 
               R.[DateModified], 
			   			( SELECT DISTINCT CategoryType
                        FROM @Cats AS C
                        WHERE C.Id = R.Id
                        FOR JSON AUTO) AS ResourceCategoryType
        FROM [dbo].[Resources] AS R
        WHERE R.Id = @Id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_Select_Details_ByIndustry]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_Select_Details_ByIndustry] @IndustryTypesId INT
AS

/*

DECLARE @IndustryTypesId int = 1

EXECUTE dbo.Resources_Select_Details_ByIndustry @IndustryTypesId

*/

    BEGIN
        SELECT R.[Id], 
               R.[Name], 
               R.[Headline], 
               R.[Description], 
               R.[Logo], 
               R.[LocationId], 
               R.[ContactName], 
               R.[ContactEmail], 
               R.[Phone], 
               R.[SiteUrl], 
               R.[DateCreated], 
               R.[DateModified], 
               L.LocationTypeId, 
               L.Id, 
               L.LineTwo, 
               L.LineTwo, 
               L.City, 
               L.Zip, 
               L.StateId, 
               L.Latitude, 
               L.Longitude, 
               L.CreatedBy, 
               L.ModifiedBy, 
               L.DateCreated, 
               L.DateModified, 
               CT.[Name] AS ConsultingType, 
               CNT.[Name] AS ContractingType, 
               LZT.[Name] AS LocationZoneType
        FROM dbo.Resources AS R
             JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = R.Id
             LEFT JOIN dbo.ConsultingTypes AS CT ON RC.ConsultingTypeId = CT.Id
             LEFT JOIN dbo.ContractingTypes AS CNT ON CNT.Id = RC.ContractingTypeId
             LEFT JOIN dbo.LocationZoneTypes AS LZT ON LZT.Id = RC.LocationZoneTypeId
             JOIN dbo.Locations AS L ON L.Id = R.LocationId
             JOIN dbo.ResourceIndustries AS RI ON RI.ResourceId = R.Id
        WHERE RI.IndustryTypesId = @IndustryTypesId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_Select_Details_ByIndustry_V2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_Select_Details_ByIndustry_V2] 
AS

/*

EXECUTE dbo.Resources_Select_Details_ByIndustry_V2

*/

    BEGIN
        SELECT R.[Id], 
               R.[Name], 
               R.[Headline], 
               R.[Description], 
               R.[Logo], 
               R.[LocationId], 
               R.[ContactName], 
               R.[ContactEmail], 
               R.[Phone], 
               R.[SiteUrl], 
               R.[DateCreated], 
               R.[DateModified], 
               L.LocationTypeId, 
               L.Id AS LocationId, 
               L.LineTwo, 
               L.LineTwo, 
               L.City, 
               L.Zip, 
               L.StateId, 
               L.Latitude, 
               L.Longitude, 
               L.CreatedBy, 
               L.ModifiedBy, 
               L.DateCreated, 
               L.DateModified,
			   IT.Id AS IndustryTypeId,
			   IT.Name AS IndustryTypeName,
			   IT.Code AS IndustryTypeCode
        FROM dbo.Resources AS R
             JOIN dbo.Locations AS L ON L.Id = R.LocationId
             JOIN dbo.ResourceIndustries AS RI ON RI.ResourceId = R.Id
			 JOIN dbo.IndustryTypes AS IT on IT.Id = RI.IndustryTypesId
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_Select_Details_ByLocationType]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_Select_Details_ByLocationType] @LocationZoneTypeId INT
AS

/*

DECLARE @LocationZoneTypeId int = 1

EXECUTE dbo.Resources_Select_Details_ByLocationType @LocationZoneTypeId

select *
from dbo.Locations

select *
from dbo.Resources

select *
from dbo.ResourceCategories

*/

    BEGIN
        SELECT R.[Id], 
               R.[Name], 
               R.[Headline], 
               R.[Description], 
               R.[Logo], 
               R.[LocationId], 
               R.[ContactName], 
               R.[ContactEmail], 
               R.[Phone], 
               R.[SiteUrl], 
               R.[DateCreated], 
               R.[DateModified], 
               L.LocationTypeId, 
               L.Id, 
               L.LineTwo, 
               L.LineTwo, 
               L.City, 
               L.Zip, 
               L.StateId, 
               L.Latitude, 
               L.Longitude, 
               L.CreatedBy,  
               L.ModifiedBy, 
               L.DateCreated, 
               L.DateModified, 
               CT.[Name] AS ConsultingType, 
               CNT.[Name] AS ContractingType, 
               LZT.[Name] AS LocationZoneType
        FROM dbo.Resources AS R
             JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = R.Id
             LEFT JOIN dbo.ConsultingTypes AS CT ON RC.ConsultingTypeId = CT.Id
             LEFT JOIN dbo.ContractingTypes AS CNT ON CNT.Id = RC.ContractingTypeId
             LEFT JOIN dbo.LocationZoneTypes AS LZT ON LZT.Id = RC.LocationZoneTypeId
             JOIN dbo.Locations AS L ON L.Id = R.LocationId
        WHERE RC.LocationZoneTypeId = @LocationZoneTypeId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_Select_Details_ByLocationType_V2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_Select_Details_ByLocationType_V2]
AS

/*


EXECUTE dbo.Resources_Select_Details_ByLocationType_V2


*/

    BEGIN
        SELECT R.[Id], 
               R.[Name], 
               R.[Headline], 
               R.[Description], 
               R.[Logo], 
               R.[LocationId], 
               R.[ContactName], 
               R.[ContactEmail], 
               R.[Phone], 
               R.[SiteUrl], 
               R.[DateCreated], 
               R.[DateModified], 
               L.LocationTypeId, 
               L.Id as LocationId, 
               L.LineTwo, 
               L.LineTwo, 
               L.City, 
               L.Zip, 
               L.StateId, 
               L.Latitude, 
               L.Longitude, 
               L.CreatedBy,  
               L.ModifiedBy, 
               L.DateCreated, 
               L.DateModified, 
               LZT.Id AS LocationZoneTypeId,
			   LZT.Name AS LocationZoneTypeName,
			   LZT.Code AS LocationZoneTypeCode
        FROM dbo.Resources AS R
             JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = R.Id
             LEFT JOIN dbo.LocationZoneTypes AS LZT ON LZT.Id = RC.LocationZoneTypeId
             JOIN dbo.Locations AS L ON L.Id = R.LocationId

    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_Select_Details_BySpecialTopics]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_Select_Details_BySpecialTopics] @SpecialTopicsId INT
AS

/* ---------------- TEST CODE --------------

DECLARE @SpecialTopicsId int = 2

EXECUTE dbo.Resources_Select_Details_BySpecialTopics @SpecialTopicsId

*/

    BEGIN
        SELECT R.[Id], 
               R.[Name], 
               R.[Headline], 
               R.[Description], 
               R.[Logo], 
               R.[LocationId], 
               R.[ContactName], 
               R.[ContactEmail], 
               R.[Phone], 
               R.[SiteUrl], 
               R.[DateCreated], 
               R.[DateModified], 
               L.LocationTypeId, 
               L.Id, 
               L.LineTwo, 
               L.LineTwo, 
               L.City, 
               L.Zip, 
               L.StateId, 
               L.Latitude, 
               L.Longitude, 
               L.CreatedBy, 
               L.ModifiedBy, 
               L.DateCreated, 
               L.DateModified, 
               CT.[Name] AS ConsultingType, 
               CNT.[Name] AS ContractingType, 
               LZT.[Name] AS LocationZoneType
        FROM dbo.Resources AS R
             JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = R.Id
             LEFT JOIN dbo.ConsultingTypes AS CT ON RC.ConsultingTypeId = CT.Id
             LEFT JOIN dbo.ContractingTypes AS CNT ON CNT.Id = RC.ContractingTypeId
             LEFT JOIN dbo.LocationZoneTypes AS LZT ON LZT.Id = RC.LocationZoneTypeId
             JOIN dbo.Locations AS L ON L.Id = R.LocationId
             JOIN dbo.ResourceSpecialTopics AS RST ON RST.ResourceId = R.Id
        WHERE RST.SpecialTopicId = @SpecialTopicsId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_Select_Details_BySpecialTopics_V2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_Select_Details_BySpecialTopics_V2]
AS

/* ---------------- TEST CODE --------------

EXECUTE dbo.Resources_Select_Details_BySpecialTopics_V2

*/

    BEGIN
        SELECT R.[Id], 
               R.[Name], 
               R.[Headline], 
               R.[Description], 
               R.[Logo], 
               R.[LocationId], 
               R.[ContactName], 
               R.[ContactEmail], 
               R.[Phone], 
               R.[SiteUrl], 
               R.[DateCreated], 
               R.[DateModified], 
               L.LocationTypeId, 
               L.Id as LocationId, 
               L.LineTwo, 
               L.LineTwo, 
               L.City, 
               L.Zip, 
               L.StateId, 
               L.Latitude, 
               L.Longitude, 
               L.CreatedBy, 
               L.ModifiedBy, 
               L.DateCreated, 
               L.DateModified, 
				STT.Id AS SpecialTopicTypesId,
				STT.Name as SpecialTopicName,
				STT.Code as SpecialTopicCode
        FROM dbo.Resources AS R
             JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = R.Id
             JOIN dbo.Locations AS L ON L.Id = R.LocationId
             JOIN dbo.ResourceSpecialTopics AS RST ON RST.ResourceId = R.Id
			 JOIN dbo.SpecialTopicTypes AS STT ON RST.SpecialTopicId = STT.Id
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_SelectAll] @pageIndex INT, 
                                       @pageSize  INT
AS

/*---------	TEST CODE-----------

Declare  @pageIndex int = 0,
		 @pageSize int = 35


	Execute dbo.Resources_SelectAll
			@pageIndex,
			@pageSize

*/

    ------------------------------
    BEGIN
        DECLARE @offset INT= @pageIndex * @pageSize;
        SELECT [Id], 
               [Name], 
               [Headline], 
               [Description], 
               [Logo], 
               [LocationId], 
               [ContactName], 
               [ContactEmail], 
               [Phone], 
               [SiteUrl], 
               [DateCreated], 
               [DateModified], 
               TotalCount = COUNT(1) OVER()
        FROM [dbo].[Resources]
        ORDER BY Id DESC
        OFFSET @offset ROWS FETCH NEXT @pageSize ROWS ONLY;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_SelectAll_V2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  proc [dbo].[Resources_SelectAll_V2]
			@pageIndex int,
			@pageSize int
AS

/*---------	TEST CODE-----------
Declare  @pageIndex int = 0,
		 @pageSize int = 20


	Execute dbo.Resources_SelectAll_V2
			@pageIndex,
			@pageSize

*/------------------------------
BEGIN

    Declare @offset int = @pageIndex * @pageSize

	SELECT   R.[Id],
			 R.[Name],
			 R.[Headline],
			 R.[Description],
			 R.[Logo],
			 R.[LocationId],
			 R.[ContactName],
			 R.[ContactEmail],
			 R.[Phone],
			 R.[SiteUrl],
			 R.[DateCreated],
			 R.[DateModified],
      (Select [Id] AS CONID,
                        [Code] AS CONCODE
                from dbo.ContractingTypes FOR JSON AUTO
             ) AS ContractingTypes,
			 TotalCount = COUNT(1) OVER()
		FROM [dbo].[Resources] as R


		ORDER BY R.Id desc
		OFFSET @offset Rows 
		Fetch Next @pageSize Rows ONLY



END
GO
/****** Object:  StoredProcedure [dbo].[Resources_SelectAll_V3]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_SelectAll_V3]
AS

/*
-----------TEST CODE ------------------------

		EXEC dbo.ConsultingTypes_SelectAll;
        EXEC dbo.ContractingTypes_SelectAll;
        EXEC dbo.LocationZoneTypes_SelectAll;
        EXEC dbo.CapitalTypes_SelectAll;
        EXEC dbo.ComplianceTypes_SelectAll;
        EXEC dbo.DemographicTypes_SelectAll;
        EXEC dbo.SpecialTopicTypes_SelectAll;
        EXEC dbo.IndustryTypes_SelectAll;

*/ --------------------------------------------

    BEGIN
        EXEC dbo.ConsultingTypes_SelectAll;
        EXEC dbo.ContractingTypes_SelectAll;
        EXEC dbo.LocationZoneTypes_SelectAll;
        EXEC dbo.CapitalTypes_SelectAll;
        EXEC dbo.ComplianceTypes_SelectAll;
        EXEC dbo.DemographicTypes_SelectAll;
        EXEC dbo.SpecialTopicTypes_SelectAll;
        EXEC dbo.IndustryTypes_SelectAll;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_SelectAll_WithCatTypes]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_SelectAll_WithCatTypes]
AS

/*------TEST CODE--------------
		
Execute [dbo].[Resources_SelectAll_WithCatTypes] 
											 
		
*/

    BEGIN
        DECLARE @TABLE TABLE
        (Id   INT, 
         Code         NVARCHAR(50), 
         [Name]       NVARCHAR(50), 
         CategoryType NVARCHAR(50)
        );
        INSERT INTO @TABLE
        EXEC [dbo].[SelectAll_Resources_With_Categories_v2];
        SELECT R.[Id], 
               R.[Name], 
               R.[Headline], 
               R.[Description], 
               R.[Logo], 
               R.[LocationId], 
               R.[ContactName], 
               R.[ContactEmail], 
               R.[Phone], 
               R.[SiteUrl], 
               R.[DateCreated], 
               R.[DateModified], 
        (
            SELECT T.Code, 
                   T.[Name], 
                   T.CategoryType
            FROM @TABLE AS T
                 JOIN dbo.Resources AS RS ON RS.Id = T.Id FOR JSON AUTO
        ) AS Categories
        FROM [dbo].[Resources] AS R
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_SelectAllResourceCategories]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_SelectAllResourceCategories]

as

/*
EXECUTE Resources_SelectAllResourceCategories
*/

SELECT R.[Id], 
                  R.[Name], 
                  R.[Headline], 
                  R.[Description], 
                  R.[Logo], 
                  R.[LocationId], 
                  R.[ContactName], 
                  R.[ContactEmail], 
                  R.[Phone], 
                  R.[SiteUrl], 
				  --ResourceCategoryTypes = STUFF(
				  --(SELECT ',' + CT.Code + ',' + CON.Code + ',' + LZ.Code
				  --FROM Resources AS R
				  --LEFT JOIN ResourceCategories as RC on RC.ResourceId = R.Id
				  --LEFT JOIN dbo.ConsultingTypes AS CT ON RC.ConsultingTypeId = CT.Id
				  --LEFT JOIN dbo.ContractingTypes AS CON ON RC.ContractingTypeId = CON.Id
				  --LEFT JOIN dbo.LocationZoneTypes AS LZ ON RC.LocationZoneTypeId = LZ.Id
				  --FOR XML PATH('')),1,1,'')

				  --ResourceCategories = STUFF((SELECT CT.Code
				  --FROM dbo.Resources
				  --LEFT JOIN ResourceCategories AS RC ON RC.ResourceId = ResourceId
				  --LEFT JOIN ConsultingTypes AS CT ON CT.Id = RC.ConsultingTypeId FOR XML PATH('')),1,1,'')
				  ResourceCategories = STUFF((SELECT ',' + CT.Code FROM dbo.Resources
				  LEFT JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = Resources.Id
				  LEFT JOIN dbo.ConsultingTypes AS CT ON CT.Id = RC.ConsultingTypeId WHERE Resources.Id IN(62) FOR XML PATH('')),1,1,'') + ',' +
				  STUFF((SELECT ',' + CON.Code FROM dbo.Resources
				  LEFT JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = Resources.Id
				  LEFT JOIN dbo.ContractingTypes AS CON ON CON.Id = RC.ContractingTypeId WHERE Resources.Id IN(62) FOR XML PATH('')),1,1,'') + ',' +
				  STUFF((SELECT ',' + LZ.Code FROM dbo.Resources
				  LEFT JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = Resources.Id
				  LEFT JOIN dbo.LocationZoneTypes AS LZ ON LZ.Id = RC.ContractingTypeId WHERE Resources.Id IN(62) FOR XML PATH('')),1,1,'')

				  --ResourceCategories = STUFF((SELECT ',' + CT.Code FROM dbo.Resources
				  --LEFT JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = Resources.Id
				  --LEFT JOIN dbo.ConsultingTypes AS CT ON CT.Id = RC.ConsultingTypeId FOR XML PATH('')),1,1,'') +
				  --STUFF((SELECT ',' + CON.Code FROM dbo.Resources
				  --LEFT JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = Resources.Id
				  --LEFT JOIN dbo.ContractingTypes AS CON ON CON.Id = RC.ContractingTypeId FOR XML PATH('')),1,1,'') + 
				  --STUFF((SELECT ',' + LZ.Code FROM dbo.Resources
				  --LEFT JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = Resources.Id
				  --LEFT JOIN dbo.LocationZoneTypes AS LZ ON LZ.Id = RC.ContractingTypeId FOR XML PATH('')),1,1,'')
				   


FROM [C80].[dbo].[Resources] R
WHERE R.Id IN(62)
GO
/****** Object:  StoredProcedure [dbo].[Resources_SelectAllV4]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_SelectAllV4] 

AS

/*---------	TEST CODE-----------


	Execute dbo.Resources_SelectAllV4
			
*/

    ------------------------------
    BEGIN
        SELECT [Id], 
               [Name], 
               [Headline], 
               [Description], 
               [Logo], 
               [LocationId], 
               [ContactName], 
               [ContactEmail], 
               [Phone], 
               [SiteUrl], 
               [DateCreated], 
               [DateModified] 
               
        FROM [dbo].[Resources]
        
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_SpecialTopics_Update]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_SpecialTopics_Update] @Id                 INT, 
                                                  @SpecialTopicsTypes AS RESOURCESPECIALTOPICSTYPE READONLY
AS
/* --TEST CODE---------------------------------------

*/ --------------------------------------------------
    BEGIN
        DELETE FROM [dbo].[ResourceSpecialTopics]
		WHERE ResourceId = @Id

        INSERT INTO [dbo].[ResourceSpecialTopics]
        ([ResourceId], 
         [SpecialTopicId]
        )
               SELECT @Id, 
                      [SpecialTopicId]
               FROM @SpecialTopicsTypes;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_Update]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[Resources_Update] 
			@Id int,
			@Name nvarchar(200),
			@Headline nvarchar(200),
			@Description nvarchar(1000),
			@Logo nvarchar(255),
			@LocationId int,
			@ContactName nvarchar(200),
			@ContactEmail nvarchar(255),
			@Phone  nvarchar(50),
			@SiteUrl nvarchar(255)
		
	
AS
/*-------TEST CODE--------

    Declare	@Id int = 2,
			@Name nvarchar(200) = 'Sabio Resource v.3',
			@Headline nvarchar(200) = 'Update Test',
			@Description nvarchar(1000) = 'Update Test',
			@Logo nvarchar(255) = 'Logo',
			@LocationId int = 1,
			@ContactName nvarchar(200) = 'Zach',
			@ContactEmail nvarchar(255) = 'sabiola@sabio.com',
			@Phone nvarchar(50) = '949-555-5555',
			@SiteUrl nvarchar(255) = 'sabiola.com'
Select * 
FROM dbo.Resources 
WHERE Id = @Id

	Execute dbo.Resources_Update 
			@Id, 
			@Name, 
			@Headline, 
			@Description, 
			@Logo,
			@LocationId, 
			@ContactName, 
			@ContactEmail,
			@Phone, 
			@SiteUrl

Select * 
FROM dbo.Resources 
WHERE Id = @Id

*/------------------------
BEGIN
UPDATE [dbo].[Resources]
	          SET  
			  [Name] = @Name,
			  [Headline] = @Headline,
			  [Description] = @Description,
			  [Logo] = @Logo,
			  [LocationId] = @LocationId,
			  [ContactName] = @ContactName,
			  [ContactEmail] = @ContactEmail,
			  [Phone] = @Phone,
			  [SiteUrl] = @SiteUrl
			  WHERE Id = @Id
 END


GO
/****** Object:  StoredProcedure [dbo].[Resources_Update_V2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_Update_V2] @Id             INT, 
                                       @LocationTypeId INT, 
                                       @LineOne        NVARCHAR(255), 
                                       @LineTwo        NVARCHAR(255), 
                                       @City           NVARCHAR(225), 
                                       @Zip            NVARCHAR(50), 
                                       @StateId        INT, 
                                       @Latitude       FLOAT, 
                                       @Longitude      FLOAT, 
                                       @ModifiedBy     INT, 
                                       @Name           NVARCHAR(200), 
                                       @Headline       NVARCHAR(200), 
                                       @Description    NVARCHAR(1000), 
                                       @Logo           NVARCHAR(255), 
                                       @LocationId     INT, 
                                       @ContactName    NVARCHAR(200), 
                                       @ContactEmail   NVARCHAR(255), 
                                       @Phone          NVARCHAR(50), 
                                       @SiteUrl        NVARCHAR(255)
AS

/*---Test Code---

DECLARE		@Id int = 3
		   ,@LocationTypeId int = 1
           ,@LineOne nvarchar(255) = 'PROCEdure'
           ,@LineTwo nvarchar(255) = 'Testing'
           ,@City nvarchar(225) = 'Testing'
           ,@Zip nvarchar(50) = 'Testing'
           ,@StateId int = 1
           ,@Latitude float = 1.1
           ,@Longitude float = 1.1
           ,@ModifiedBy int = 1
			
		   ,@Name nvarchar(200) = 'PROCedure'
           ,@Headline nvarchar(200) = 'Testing'
           ,@Description nvarchar(1000) = 'Testing'
           ,@Logo nvarchar(255) = 'Testing'
           ,@LocationId int = 1
           ,@ContactName nvarchar(200) = 'Testing'
           ,@ContactEmail nvarchar(255) = 'Testing'
           ,@Phone nvarchar(50) = 'Testing'
           ,@SiteUrl nvarchar(255) = 'Testing'

EXECUTE [dbo].[Resources_Update_V2]
			@Id 
		   ,@LocationTypeId
           ,@LineOne
           ,@LineTwo 
           ,@City 
           ,@Zip
           ,@StateId 
           ,@Latitude
           ,@Longitude 
           ,@ModifiedBy 
		 
		   ,@Name 
           ,@Headline 
           ,@Description 
           ,@Logo 
           ,@LocationId 
           ,@ContactName 
           ,@ContactEmail 
           ,@Phone 
           ,@SiteUrl 

SELECT *
FROM [dbo].[Locations] 

SELECT * 
FROM [dbo].[Resources]

*/

    ---Test Code---

    BEGIN
        DECLARE @DateModified DATETIME2(7)= GETUTCDATE();
        UPDATE [dbo].[Locations]
          SET 
              [LocationTypeId] = @LocationTypeId, 
              [LineOne] = @LineOne, 
              [LineTwo] = @LineTwo, 
              [City] = @City, 
              [Zip] = @Zip, 
              [StateId] = @StateId, 
              [Latitude] = @Latitude, 
              [Longitude] = @Longitude, 
              [ModifiedBy] = @ModifiedBy,
			  [DateModified] = @DateModified
        WHERE Id = @Id;

        UPDATE [dbo].[Resources]
          SET 
              [Name] = @Name, 
              [Headline] = @Headline, 
              [Description] = @Description, 
              [Logo] = @Logo, 
              [LocationId] = @LocationId, 
              [ContactName] = @ContactName, 
              [ContactEmail] = @ContactEmail, 
              [Phone] = @Phone, 
              [SiteUrl] = @SiteUrl,
			  [DateModified] = @DateModified
        WHERE Id = @Id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_Update_V3]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Resources_Update_V3] @Id                 INT, 
                                       @Name               NVARCHAR(200), 
                                       @Headline           NVARCHAR(200), 
                                       @Description        NVARCHAR(1000), 
                                       @Logo               NVARCHAR(255), 
                                       @LocationId         INT, 
                                       @ContactName        NVARCHAR(200), 
                                       @ContactEmail       NVARCHAR(255), 
                                       @Phone              NVARCHAR(50), 
                                       @SiteUrl            NVARCHAR(255), 
                                       @ConsultingTypeId   INT, 
                                       @ContractingTypeId  INT, 
                                       @LocationTypeId INT, 
                                       @SpecialTopicsTypes AS RESOURCESPECIALTOPICSTYPE READONLY, 
                                       @CapitalTypes AS     RESOURCECAPITALTYPE READONLY, 
                                       @ComplianceTypes AS  RESOURCECOMPLIANCETYPE READONLY, 
                                       @DemographicTypes AS RESOURCEDEMOGRAPHICSTYPE READONLY, 
                                       @IndustryTypes AS    RESOURCEINDUSTRYTYPE READONLY
               
AS

/*-------TEST CODE--------

	EXECUTE [dbo].[Resources_SelectAll_WithCatTypes]

    DECLARE	@Id int = 29,
			@Name nvarchar(200) = 'Resources_Update_V3',
			@Headline nvarchar(200) = 'Update Test',
			@Description nvarchar(1000) = 'Update Test',
			@Logo nvarchar(255) = 'Logo',
			@LocationId int = 1,
			@ContactName nvarchar(200) = 'Joshua Bloomburg Jr.',
			@ContactEmail nvarchar(255) = 'sabiola@sabio.com',
			@Phone nvarchar(50) = '949-555-5555',
			@SiteUrl nvarchar(255) = 'sabiola.com',
			@ConsultingTypeId int = 2,
			@ContractingTypeId int = 2,
			@LocationTypeId int = 2,
			@SpecialTopicsTypes AS ResourceSpecialTopicsType,
			@CapitalTypes AS ResourceCapitalType,
			@ComplianceTypes AS ResourceComplianceType,
			@DemographicTypes AS ResourceDemographicsType,
			@IndustryTypes AS ResourceIndustryType

			INSERT into @CapitalTypes ([CapitalTypesId]) values (2)
			INSERT into @CapitalTypes ([CapitalTypesId]) values (3)
			INSERT into @ComplianceTypes ([ComplianceTypesId]) values (2)
			INSERT into @ComplianceTypes ([ComplianceTypesId]) values (3)
			INSERT into @DemographicTypes ([DemographicTypesId]) values (1)
			INSERT into @SpecialTopicsTypes ([SpecialTopicId]) values (1)
			INSERT into @SpecialTopicsTypes ([SpecialTopicId]) values (2)
			INSERT into @SpecialTopicsTypes ([SpecialTopicId]) values (3)
			INSERT into @SpecialTopicsTypes ([SpecialTopicId]) values (4)
			INSERT into @SpecialTopicsTypes ([SpecialTopicId]) values (5)
			INSERT into @SpecialTopicsTypes ([SpecialTopicId]) values (6)
			INSERT into @IndustryTypes ([IndustryTypesId]) values (1)
			INSERT into @IndustryTypes ([IndustryTypesId]) values (2)
			INSERT into @IndustryTypes ([IndustryTypesId]) values (3)

			EXECUTE [dbo].[Resources_SpecialTopics_Update]  
					      @Id, 
                          @SpecialTopicsTypes 
			EXECUTE [dbo].[Resources_CapitalTypes_Update] 
						  @Id,  
                          @CapitalTypes 
			EXECUTE [dbo].[Resources_ComplianceTypes_Update]  
						  @Id, 
                          @ComplianceTypes 
			EXECUTE [dbo].[Resources_DemographicTypes_Update] 
						  @Id, 
                          @DemographicTypes
            EXECUTE [dbo].[Resources_IndustryTypes_Update]  
						  @Id, 
                          @IndustryTypes

	EXECUTE [dbo].[Resources_Update_V3] 
			@Id, 
			@Name, 
			@Headline, 
			@Description, 
			@Logo,
			@LocationId, 
			@ContactName, 
			@ContactEmail,
			@Phone, 
			@SiteUrl,
			@ConsultingTypeId,
			@ContractingTypeId,
			@LocationTypeId,
			@SpecialTopicsTypes,
			@CapitalTypes,
			@ComplianceTypes,
			@DemographicTypes,
			@IndustryTypes

Execute [dbo].[Resources_SelectAll_WithCatTypes]

*/

    ------------------------

    BEGIN
        UPDATE [dbo].[Resources]
          SET 
              [Name] = @Name, 
              [Headline] = @Headline, 
              [Description] = @Description, 
              [Logo] = @Logo, 
              [LocationId] = @LocationId, 
              [ContactName] = @ContactName, 
              [ContactEmail] = @ContactEmail, 
              [Phone] = @Phone, 
              [SiteUrl] = @SiteUrl
        WHERE Id = @Id;
        UPDATE [dbo].[ResourceCategories]
          SET 
              [ConsultingTypeId] = @ConsultingTypeId, 
              [ContractingTypeId] = @ContractingTypeId, 
              [LocationZoneTypeId] = @LocationTypeId
        WHERE ResourceId = @Id;
        EXECUTE [dbo].[Resources_SpecialTopics_Update] 
                @Id, 
                @SpecialTopicsTypes;
        EXECUTE [dbo].[Resources_CapitalTypes_Update] 
                @Id, 
                @CapitalTypes;
        EXECUTE [dbo].[Resources_ComplianceTypes_Update] 
                @Id, 
                @ComplianceTypes;
        EXECUTE [dbo].[Resources_DemographicTypes_Update] 
                @Id, 
                @DemographicTypes;
        EXECUTE [dbo].[Resources_IndustryTypes_Update] 
                @Id, 
                @IndustryTypes;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Resources_Update_WithCategoryTypes]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[Resources_Update_WithCategoryTypes] 
			@Id int,
			@Name nvarchar(200),
			@Headline nvarchar(200),
			@Description nvarchar(1000),
			@Logo nvarchar(255),
			@LocationId int,
			@ContactName nvarchar(200),
			@ContactEmail nvarchar(255),
			@Phone  nvarchar(50),
			@SiteUrl nvarchar(255),
			@ConsultingTypeId int,
			@ContractingTypeId int,
			@LocationZoneTypeId int, 
			@SpecialTopics AS ResourceSpecialTopicsType READONLY,
			@CapitalTypes AS ResourceCapitalType READONLY


		
AS

/*-------TEST CODE--------

    Declare	@Id int = 7,
			@Name nvarchar(200) = 'Sabio Resource',
			@Headline nvarchar(200) = 'Update Test',
			@Description nvarchar(1000) = 'Update Test',
			@Logo nvarchar(255) = 'Logo',
			@LocationId int = 1,
			@ContactName nvarchar(200) = 'Jake',
			@ContactEmail nvarchar(255) = 'sabiola@sabio.com',
			@Phone nvarchar(50) = '949-555-5555',
			@SiteUrl nvarchar(255) = 'sabiola.com'
Select * 
FROM dbo.Resources 
WHERE Id = @Id

	Execute [dbo].[Resources_Update_WithCategoryTypes]  
			@Id, 
			@Name, 
			@Headline, 
			@Description, 
			@Logo,
			@LocationId, 
			@ContactName, 
			@ContactEmail,
			@Phone, 
			@SiteUrl

Select * 
FROM dbo.Resources 
WHERE Id = @Id

*/------------------------
BEGIN
UPDATE [dbo].[Resources] 
	          SET  
				[Name] = @Name,
				[Headline] = @Headline,
				[Description] = @Description,
				[Logo] = @Logo,
				[LocationId] = @LocationId,
				[ContactName] = @ContactName,
				[ContactEmail] = @ContactEmail,
				[Phone] = @Phone,
				[SiteUrl] = @SiteUrl
			  WHERE Id = @Id
			  
UPDATE [dbo].[ResourceCategories]
		SET 
		[ConsultingTypeId] = @ConsultingTypeId,
		[ContractingTypeId] = @ContractingTypeId,
		[LocationZoneTypeId] = @LocationZoneTypeId
		WHERE ResourceId = @Id

UPDATE [dbo]. [ResourceSpecialTopics]
		SET 
		[SpecialTopicId] = (SELECT [SpecialTopicId] 
							from @SpecialTopics)
		WHERE ResourceId = @Id
END


GO
/****** Object:  StoredProcedure [dbo].[ResourceSpecialTopics_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResourceSpecialTopics_Insert]
											@ResourceId int
											,@SpecialTopicId int

AS

/*

DECLARE @ResourceId int = 3
		,@SpecialTopicId int = 4

EXECUTE dbo.ResourceSpecialTopics_Insert @ResourceId
										,@SpecialTopicId

SELECT * 
FROM dbo.ResourceSpecialTopics

*/

BEGIN

INSERT INTO [dbo].[ResourceSpecialTopics]
           ([ResourceId]
           ,[SpecialTopicId])

     VALUES
           (@ResourceId
           ,@SpecialTopicId)

END


GO
/****** Object:  StoredProcedure [dbo].[ResourceSpecialTopics_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResourceSpecialTopics_SelectAll]

AS

/*

EXECUTE dbo.ResourceSpecialTopics_SelectAll

*/

BEGIN

SELECT [ResourceId]
      ,[SpecialTopicId]

  FROM [dbo].[ResourceSpecialTopics]

END


GO
/****** Object:  StoredProcedure [dbo].[ResourceSpecialTopics_Update]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ResourceSpecialTopics_Update] @SpecialTopicId INT
AS

/* --TEST CODE------------------------------------------


SELECT * 
FROM [dbo].[ResourceSpecialTopics]
WHERE SpecialTopicId = @SpecialTopicId

DECLARE @SpecialTopicId int = 9

EXECUTE [dbo].[ResourceSpecialTopics_Update]
											@SpecialTopicId
										
SELECT * 
FROM [dbo].[ResourceSpecialTopics]
WHERE SpecialTopicId = @SpecialTopicId
											
*/

    BEGIN
        UPDATE [dbo].[ResourceSpecialTopics]
          SET 
              [SpecialTopicId] = @SpecialTopicId
        WHERE SpecialTopicId = @SpecialTopicId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Reviews_Update]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Reviews_Update]
			@Id int,
			@UserId int,
			@Review nvarchar(1000),
			@StarRating int

AS

/* ---------- TEST CODE -----------

DECLARE 
	@Id int = 1,
	@UserId int = 124,
	@Review nvarchar(1000) = 'A true real estate guru.',
	@StarRating int = 5

SELECT * 
FROM dbo.Reviews
Where Id = @Id

EXECUTE dbo.Reviews_Update
	@Id, 
	@UserId,
	@Review,
	@StarRating

SELECT * 
FROM dbo.Reviews
Where Id = @Id

*/

BEGIN

	DECLARE @DateModified datetime2(7) = GETUTCDATE();

	UPDATE [dbo].[Reviews]

	   SET [Review] = @Review,
		   [StarRating] = @StarRating,
		   [DateModified] = @DateModified

	WHERE Id = @Id AND UserId = @UserId

 END


GO
/****** Object:  StoredProcedure [dbo].[Roles_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[Roles_SelectAll]
				@PageIndex int,  
				@PageSize int 
AS
/*
		Declare 
		@PageIndex int=0, 
		@PageSize int=10

		EXEC dbo.Roles_SelectAll
		@PageIndex, 
		@PageSize;

*/
BEGIN
		Declare @Offset int = @PageIndex * @PageSize
		SELECT
				[Id],
				[Name],
				

				TotalCount = COUNT(1) OVER()
		FROM
				[dbo].[Roles]

		ORDER BY Id  

		OFFSET @offSet Rows
		Fetch Next @pageSize Rows ONLY
		
				

END
GO
/****** Object:  StoredProcedure [dbo].[SelectAll_Resources_With_Categories]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SelectAll_Resources_With_Categories]

AS
BEGIN

/*

EXEC [dbo].[SelectAll_Resources_With_Categories] 
		
*/

        DECLARE @TABLE TABLE
        (Id INT,
			Code         NVARCHAR(50), 
         CategoryType NVARCHAR(50)
        );

        --CT-----------------------------------------------------
        INSERT INTO @TABLE
		 SELECT 
                      R.Id, 
					  CT.Code, 
                      CategoryType = 'Consulting'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = R.Id
                    JOIN dbo.ConsultingTypes AS CT ON CT.Id = RC.ConsultingTypeId
             
        --CON-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.Id,
                      CON.Code, 
                      CategoryType = 'Contracting'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = R.Id
                    JOIN dbo.ContractingTypes AS CON ON CON.Id = RC.ContractingTypeId
             
        --LZ-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.Id,
                      LZ.Code, 
                      CategoryType = 'LocationZone'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = R.Id
                    JOIN dbo.LocationZoneTypes AS LZ ON LZ.Id = RC.LocationZoneTypeId
             
        --CPT-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.Id,
                      CPT.Code, 
                      CategoryType = 'Capital'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceCapital AS RSC ON RSC.ResourceId = R.Id
                    JOIN dbo.CapitalTypes AS CPT ON CPT.Id = RSC.CapitalTypesId
             

        --SPT-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.Id,
                      SPT.Code,  
                      CategoryType = 'SpecialTopic'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceSpecialTopics AS RCST ON RCST.ResourceId = R.Id
                    JOIN dbo.SpecialTopicTypes AS SPT ON SPT.Id = RCST.SpecialTopicId
             

        --CMP-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.Id,
						CMP.Code, 
                      CategoryType = 'Compliance'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceCompliances AS RCM ON RCM.ResourceId = R.Id
                    JOIN dbo.ComplianceTypes AS CMP ON CMP.Id = RCM.ComplianceTypesId
             

        --DGT-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT
					R.Id,
                      DGT.Code, 
                      CategoryType = 'Demographic'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceDemographics AS RCD ON RCD.ResourceId = R.Id
                    JOIN dbo.DemographicTypes AS DGT ON DGT.Id = RCD.DemographicTypesId
             

        --IND-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT 
					R.Id,
                      IND.Code, 
                      CategoryType = 'Industry'
               FROM [C80].[dbo].[Resources] AS R
                    JOIN dbo.ResourceIndustries AS RIND ON RIND.ResourceId = R.Id
                    JOIN dbo.IndustryTypes AS IND ON IND.Id = RIND.IndustryTypesId
             
        SELECT Id, 
               Code, 
               CategoryType
        FROM @TABLE
END
GO
/****** Object:  StoredProcedure [dbo].[SelectAll_Resources_With_Categories_By_ResourceId]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SelectAll_Resources_With_Categories_By_ResourceId] @Id INT
AS
    BEGIN

/*

DECLARE @Id int = 13;
EXEC [dbo].[SelectAll_Resources_With_Categories_By_ResourceId]   @Id 
		
*/

        DECLARE @TABLE TABLE
        (ResourceId   INT, 
         CatId        INT, 
         Code         NVARCHAR(50), 
         [Name]       NVARCHAR(50), 
         CategoryType NVARCHAR(50)
        );

        --CT-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.[Id], 
                      CT.Id, 
                      CT.Code, 
                      CT.[Name], 
                      CategoryType = 'Consulting'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = R.Id
                    JOIN dbo.ConsultingTypes AS CT ON CT.Id = RC.ConsultingTypeId
               WHERE R.Id = @Id;
        --CON-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.[Id], 
                      CON.Id, 
                      CON.Code, 
                      CON.[Name], 
                      CategoryType = 'Contracting'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = R.Id
                    JOIN dbo.ContractingTypes AS CON ON CON.Id = RC.ContractingTypeId
               WHERE R.Id = @Id;
        --LZ-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.[Id], 
                      LZ.Id, 
                      LZ.Code, 
                      LZ.[Name], 
                      CategoryType = 'LocationZone'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = R.Id
                    JOIN dbo.LocationZoneTypes AS LZ ON LZ.Id = RC.LocationZoneTypeId
               WHERE R.Id = @Id;
        --CPT-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.[Id], 
                      CPT.Id, 
                      CPT.Code, 
                      CPT.[Name], 
                      CategoryType = 'Capital'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceCapital AS RSC ON RSC.ResourceId = R.Id
                    JOIN dbo.CapitalTypes AS CPT ON CPT.Id = RSC.CapitalTypesId
               WHERE R.Id = @Id;

        --SPT-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.[Id], 
                      SPT.Id, 
                      SPT.Code, 
                      SPT.[Name], 
                      CategoryType = 'SpecialTopic'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceSpecialTopics AS RCST ON RCST.ResourceId = R.Id
                    JOIN dbo.SpecialTopicTypes AS SPT ON SPT.Id = RCST.SpecialTopicId
               WHERE R.Id = @Id;

        --CMP-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.[Id], 
                      CMP.Id, 
                      CMP.Code, 
                      CMP.[Name], 
                      CategoryType = 'Compliance'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceCompliances AS RCM ON RCM.ResourceId = R.Id
                    JOIN dbo.ComplianceTypes AS CMP ON CMP.Id = RCM.ComplianceTypesId
               WHERE R.Id = @Id;

        --DGT-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.[Id], 
                      DGT.Id, 
                      DGT.Code, 
                      DGT.[Name], 
                      CategoryType = 'Demographic'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceDemographics AS RCD ON RCD.ResourceId = R.Id
                    JOIN dbo.DemographicTypes AS DGT ON DGT.Id = RCD.DemographicTypesId
               WHERE R.Id = @Id;

        --IND-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.[Id], 
                      IND.Id, 
                      IND.Code, 
                      IND.[Name], 
                      CategoryType = 'Industry'
               FROM [C80].[dbo].[Resources] AS R
                    JOIN dbo.ResourceIndustries AS RIND ON RIND.ResourceId = R.Id
                    JOIN dbo.IndustryTypes AS IND ON IND.Id = RIND.IndustryTypesId
               WHERE R.Id = @Id;
        SELECT ResourceId, 
               CatId, 
               [Name], 
               Code, 
               CategoryType
        FROM @TABLE
        ORDER BY ResourceId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SelectAll_Resources_With_Categories_By_ResourceId_v2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SelectAll_Resources_With_Categories_By_ResourceId_v2] @Id INT
AS
    BEGIN

/*

DECLARE @Id int = 13;
EXEC [dbo].[SelectAll_Resources_With_Categories_By_ResourceId_v2]   @Id 
		
*/

        DECLARE @TABLE TABLE
        (Code         NVARCHAR(50), 
         [Name]       NVARCHAR(50), 
         CategoryType NVARCHAR(50)
        );

        --CT-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT CT.Code, 
                      CT.[Name],
                      CategoryType = 'Consulting'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = R.Id
                    JOIN dbo.ConsultingTypes AS CT ON CT.Id = RC.ConsultingTypeId
               WHERE R.Id = @Id;
        --CON-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT CON.Code, 
                      CON.[Name],
                      CategoryType = 'Contracting'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = R.Id
                    JOIN dbo.ContractingTypes AS CON ON CON.Id = RC.ContractingTypeId
               WHERE R.Id = @Id;
        --LZ-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT LZ.Code, 
                      LZ.[Name], 
                      CategoryType = 'LocationZone'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = R.Id
                    JOIN dbo.LocationZoneTypes AS LZ ON LZ.Id = RC.LocationZoneTypeId
               WHERE R.Id = @Id;
        --CPT-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT CPT.Code, 
                      CPT.[Name], 
                      CategoryType = 'Capital'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceCapital AS RSC ON RSC.ResourceId = R.Id
                    JOIN dbo.CapitalTypes AS CPT ON CPT.Id = RSC.CapitalTypesId
               WHERE R.Id = @Id;

        --SPT-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT SPT.Code, 
                      SPT.[Name], 
                      CategoryType = 'SpecialTopic'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceSpecialTopics AS RCST ON RCST.ResourceId = R.Id
                    JOIN dbo.SpecialTopicTypes AS SPT ON SPT.Id = RCST.SpecialTopicId
               WHERE R.Id = @Id;

        --CMP-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT CMP.Code, 
                      CMP.[Name], 
                      CategoryType = 'Compliance'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceCompliances AS RCM ON RCM.ResourceId = R.Id
                    JOIN dbo.ComplianceTypes AS CMP ON CMP.Id = RCM.ComplianceTypesId
               WHERE R.Id = @Id;

        --DGT-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT DGT.Code, 
                      DGT.[Name], 
                      CategoryType = 'Demographic'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceDemographics AS RCD ON RCD.ResourceId = R.Id
                    JOIN dbo.DemographicTypes AS DGT ON DGT.Id = RCD.DemographicTypesId
               WHERE R.Id = @Id;

        --IND-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT IND.Code, 
                      IND.[Name], 
                      CategoryType = 'Industry'
               FROM [C80].[dbo].[Resources] AS R
                    JOIN dbo.ResourceIndustries AS RIND ON RIND.ResourceId = R.Id
                    JOIN dbo.IndustryTypes AS IND ON IND.Id = RIND.IndustryTypesId
               WHERE R.Id = @Id;
        SELECT Code, 
               [Name], 
               CategoryType
        FROM @TABLE
        ORDER BY CategoryType;
        --for JSON AUTO
    END;
GO
/****** Object:  StoredProcedure [dbo].[SelectAll_Resources_With_Categories_v2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SelectAll_Resources_With_Categories_v2]
AS

/*

EXEC [dbo].[SelectAll_Resources_With_Categories_v2] 
		
*/

    BEGIN
        DECLARE @TABLE TABLE
        (Id           INT, 
         CatId        INT, 
         Code         NVARCHAR(50), 
         [Name]       NVARCHAR(50), 
         CategoryType NVARCHAR(50)
        );

        --CT-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.Id, 
                      CT.Id, 
                      CT.Code, 
                      CT.[Name], 
                      CategoryType = 'Consulting'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = R.Id
                    JOIN dbo.ConsultingTypes AS CT ON CT.Id = RC.ConsultingTypeId;

        --CON-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.Id, 
                      CON.Id, 
                      CON.Code, 
                      CON.[Name], 
                      CategoryType = 'Contracting'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = R.Id
                    JOIN dbo.ContractingTypes AS CON ON CON.Id = RC.ContractingTypeId;

        --LZ-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.Id, 
                      LZ.Id, 
                      LZ.Code, 
                      LZ.[Name], 
                      CategoryType = 'LocationZone'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = R.Id
                    JOIN dbo.LocationZoneTypes AS LZ ON LZ.Id = RC.LocationZoneTypeId;

        --CPT-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.Id, 
                      CPT.Id, 
                      CPT.Code, 
                      CPT.[Name], 
                      CategoryType = 'Capital'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceCapital AS RSC ON RSC.ResourceId = R.Id
                    JOIN dbo.CapitalTypes AS CPT ON CPT.Id = RSC.CapitalTypesId;

        --SPT-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.Id, 
                      SPT.Id, 
                      SPT.Code, 
                      SPT.[Name], 
                      CategoryType = 'SpecialTopic'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceSpecialTopics AS RCST ON RCST.ResourceId = R.Id
                    JOIN dbo.SpecialTopicTypes AS SPT ON SPT.Id = RCST.SpecialTopicId;

        --CMP-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.Id, 
                      CMP.Id, 
                      CMP.Code, 
                      CMP.[Name], 
                      CategoryType = 'Compliance'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceCompliances AS RCM ON RCM.ResourceId = R.Id
                    JOIN dbo.ComplianceTypes AS CMP ON CMP.Id = RCM.ComplianceTypesId;

        --DGT-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.Id, 
                      DGT.Id, 
                      DGT.Code, 
                      DGT.[Name], 
                      CategoryType = 'Demographic'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceDemographics AS RCD ON RCD.ResourceId = R.Id
                    JOIN dbo.DemographicTypes AS DGT ON DGT.Id = RCD.DemographicTypesId;

        --IND-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.Id, 
                      IND.Id, 
                      IND.Code, 
                      IND.[Name], 
                      CategoryType = 'Industry'
               FROM [C80].[dbo].[Resources] AS R
                    JOIN dbo.ResourceIndustries AS RIND ON RIND.ResourceId = R.Id
                    JOIN dbo.IndustryTypes AS IND ON IND.Id = RIND.IndustryTypesId;
        SELECT Id, 
			   CatId,
               Code, 
               [Name], 
               CategoryType
        FROM @TABLE;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SelectAll_Resources_With_Categories_v3]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SelectAll_Resources_With_Categories_v3]
AS

/*

EXEC [dbo].[SelectAll_Resources_With_Categories_v3] 
		
*/

    BEGIN
        DECLARE @TABLE TABLE
        (Id           INT, 
         Code         NVARCHAR(50), 
         [Name]       NVARCHAR(50), 
         CategoryType NVARCHAR(50)
        );

        --CT-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.Id, 
                      CT.Code, 
                      CT.[Name], 
                      CategoryType = 'Consulting'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = R.Id
                    JOIN dbo.ConsultingTypes AS CT ON CT.Id = RC.ConsultingTypeId;

        --CON-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.Id, 
                      CON.Code, 
                      CON.[Name], 
                      CategoryType = 'Contracting'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = R.Id
                    JOIN dbo.ContractingTypes AS CON ON CON.Id = RC.ContractingTypeId;

        --LZ-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.Id, 
                      LZ.Code, 
                      LZ.[Name], 
                      CategoryType = 'LocationZone'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceCategories AS RC ON RC.ResourceId = R.Id
                    JOIN dbo.LocationZoneTypes AS LZ ON LZ.Id = RC.LocationZoneTypeId;

        --CPT-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.Id, 
                      CPT.Code, 
                      CPT.[Name], 
                      CategoryType = 'Capital'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceCapital AS RSC ON RSC.ResourceId = R.Id
                    JOIN dbo.CapitalTypes AS CPT ON CPT.Id = RSC.CapitalTypesId;

        --SPT-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.Id, 
                      SPT.Code, 
                      SPT.[Name], 
                      CategoryType = 'SpecialTopic'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceSpecialTopics AS RCST ON RCST.ResourceId = R.Id
                    JOIN dbo.SpecialTopicTypes AS SPT ON SPT.Id = RCST.SpecialTopicId;

        --CMP-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.Id, 
                      CMP.Code, 
                      CMP.[Name], 
                      CategoryType = 'Compliance'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceCompliances AS RCM ON RCM.ResourceId = R.Id
                    JOIN dbo.ComplianceTypes AS CMP ON CMP.Id = RCM.ComplianceTypesId;

        --DGT-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.Id, 
                      DGT.Code, 
                      DGT.[Name], 
                      CategoryType = 'Demographic'
               FROM [C80].[dbo].[Resources] R
                    JOIN dbo.ResourceDemographics AS RCD ON RCD.ResourceId = R.Id
                    JOIN dbo.DemographicTypes AS DGT ON DGT.Id = RCD.DemographicTypesId;

        --IND-----------------------------------------------------
        INSERT INTO @TABLE
               SELECT R.Id, 
                      IND.Code, 
                      IND.[Name], 
                      CategoryType = 'Industry'
               FROM [C80].[dbo].[Resources] AS R
                    JOIN dbo.ResourceIndustries AS RIND ON RIND.ResourceId = R.Id
                    JOIN dbo.IndustryTypes AS IND ON IND.Id = RIND.IndustryTypesId;
        SELECT Id, 
               Code, 
               [Name], 
               CategoryType
        FROM @TABLE;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SpecialTopicTypes_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SpecialTopicTypes_SelectAll]
AS

/*
		EXEC dbo.SpecialTopicTypes_SelectAll

*/

    BEGIN
        SELECT [Id], 
               [Code], 
               [Name]
        FROM [dbo].[SpecialTopicTypes]
        ORDER BY Id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[States_SelectByUSA]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[States_SelectByUSA]
				@CountryId INT

AS

/*

Declare 
	@CountryId int = 247

Execute dbo.States_SelectByUSA
	@CountryId

*/

BEGIN

SELECT[Id] 
	  ,[CountryId]
      ,[StateProvinceCode]
      ,[Name]

  FROM [dbo].[States]
  Where [CountryId] = 247

END


GO
/****** Object:  StoredProcedure [dbo].[SurveyAnswers_Analytics]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SurveyAnswers_Analytics] @QuestionId as QuestionIdType ReADONLY


AS

/*

DECLARE @QuestionId as QuestionIdType

insert into @QuestionId ([questionId]) values (9)
insert into @QuestionId ([questionId]) values (10)
insert into @QuestionId ([questionId]) values (11)

EXECUTE dbo.SurveyAnswers_Analytics @QuestionId

*/


    BEGIN
        SELECT COUNT(SA.[QuestionId]) AS Number, 
               SQAO.[Text] AS AnswerText, 
               SQ.Question AS QuestionText,
			   SA.QuestionId
        FROM [C80].[dbo].[SurveyAnswers] AS SA
             JOIN dbo.SurveyQuestionAnswerOptions AS SQAO ON SQAO.QuestionId = SA.QuestionId
                                                             AND SA.AnswerOptionId = SQAO.Id
             JOIN dbo.SurveyQuestions AS SQ ON SQ.Id = SQAO.QuestionId
        WHERE SA.QuestionId IN (SELECT * FROM @QuestionId)
        GROUP BY SA.[QuestionId], 
                 SQAO.[Text], 
                 SQ.Question;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SurveyAnswers_Analytics_byDate]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SurveyAnswers_Analytics_byDate] @QuestionId as QuestionIdType ReADONLY,
												  @Start nvarchar(30),
												  @End nvarchar(30)


AS

/*

DECLARE @QuestionId as QuestionIdType

insert into @QuestionId ([questionId]) values (9)
insert into @QuestionId ([questionId]) values (10)
insert into @QuestionId ([questionId]) values (11)

DECLARE @Start nvarchar(30) = '2019-12-10'
DECLARE	@End nvarchar(30) = '2019-12-10'

EXECUTE dbo.SurveyAnswers_Analytics_byDate @QuestionId,
									@Start,
									@End

*/


    BEGIN
        SELECT COUNT(SA.[QuestionId]) AS Number, 
               SQAO.[Text] AS AnswerText, 
               SQ.Question AS QuestionText,
			   SA.QuestionId,
			   SS.SurveyId,
			   S.Id,
			   SI.DateCreated
        FROM [C80].[dbo].[SurveyAnswers] AS SA
             JOIN dbo.SurveyQuestionAnswerOptions AS SQAO ON SQAO.QuestionId = SA.QuestionId
                                                             AND SA.AnswerOptionId = SQAO.Id
             JOIN dbo.SurveyQuestions AS SQ ON SQ.Id = SQAO.QuestionId
			 JOIN dbo.SurveySections AS SS ON SQ.SectionId = SS.Id
			 JOIN dbo.Surveys as S ON S.Id = SS.SurveyId
			 JOIN dbo.SurveysInstances as SI ON SI.SurveyId = S.Id
        WHERE SA.QuestionId IN (SELECT * FROM @QuestionId) AND (SI.DateCreated BETWEEN @start AND @end)
        GROUP BY SA.[QuestionId], 
                 SQAO.[Text], 
                 SQ.Question,SS.SurveyId,
				 S.Id,
				 SI.DateCreated;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SurveyAnswers_Analytics_Questions]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[SurveyAnswers_Analytics_Questions]

AS

/*

EXECUTE dbo.SurveyAnswers_Analytics_Questions

*/

BEGIN
select SA.[questionId],
		SQ.Question
from dbo.SurveyAnswers AS SA
join dbo.SurveyQuestions AS SQ ON SQ.Id = SA.QuestionId
group by SA.[questionId], SQ.[Question]
END
GO
/****** Object:  StoredProcedure [dbo].[SurveyAnswers_DeleteById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SurveyAnswers_DeleteById]
			@Id int
as

/*
	DECLARE @_id int = 0;
	EXEC dbo.SurveyAnswers_DeleteById @_id;

*/


BEGIN
	DELETE FROM [dbo].[SurveyAnswers]
		  WHERE Id = @Id
END


GO
/****** Object:  StoredProcedure [dbo].[SurveyAnswers_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SurveyAnswers_Insert]
			@Id int OUTPUT,
			@InstanceId int,
			@QuestionId int,
			@AnswerOptionId int
as
/*
	DECLARE @Id int, 
			@InstanceId int = 19,
			@QuestionId int = 39,
			@AnswerOptionId int = 24
			
	EXEC dbo.SurveyAnswers_Insert 
			@Id OUTPUT,
			@InstanceId, 
			@QuestionId, 
			@AnswerOptionId 
							
	SELECT *
	FROM dbo.SurveyAnswers
	WHERE Id = @Id 

*/
BEGIN
	INSERT INTO [dbo].[SurveyAnswers]
			(
			[InstanceId],
			[QuestionId],
			[AnswerOptionId]
			)
		 VALUES
			(
			@InstanceId, 
			@QuestionId,
			@AnswerOptionId   
			);

		SET @Id = SCOPE_IDENTITY();
END


GO
/****** Object:  StoredProcedure [dbo].[SurveyAnswers_Insert_Multiple]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC  [dbo].[SurveyAnswers_Insert_Multiple] 
			@InstanceId int,
			@QuestionId INT,
		    @AnswersList as [dbo].[AnswersListType] READONLY

as
BEGIN
/*

DECLARE 
			@InstanceId int = 5,
			@QuestionId int = 27,
			@AnswersList as AnswersListType

INSERT INTO @AnswersList (AnswerOptionId) values (24) 
INSERT INTO @AnswersList (AnswerOptionId) values (30) 

EXECUTE [dbo].SurveyAnswers_Insert_Multiple 
			@InstanceId,
			@QuestionId,
			@AnswersList


SELECT * 
FROM dbo.SurveyAnswers

*/


INSERT INTO dbo.SurveyAnswers
			(
			[InstanceId],
			[QuestionId],
			[AnswerOptionId]
			)
SELECT 
			@InstanceId,
			@QuestionId,
			AnswerOptionId

from @AnswersList


END
GO
/****** Object:  StoredProcedure [dbo].[SurveyAnswers_Insert_Multiple_Id]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC  [dbo].[SurveyAnswers_Insert_Multiple_Id] 
		    @AnswersList as [dbo].[AnswersListType] READONLY

as
BEGIN
/*

DECLARE @AnswersList as AnswersListType
		
INSERT INTO @AnswersList (AnswerOptionId) values (24) 
INSERT INTO @AnswersList (AnswerOptionId) values (30) 

execute [dbo].[SurveyAnswers_Insert_Multiple_Id]   @AnswersList


*/

EXECUTE [dbo].[Resource_Recommendation_Config_Select_ById]
			@AnswersList



END
GO
/****** Object:  StoredProcedure [dbo].[SurveyAnswers_Insert_Multiple_V2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC  [dbo].[SurveyAnswers_Insert_Multiple_V2] 
			@InstanceId int,
		    @AnswersList as [dbo].QuestionAnswerOptionListType READONLY

as
BEGIN
/*

DECLARE 
			@InstanceId int = 35,
			@AnswersList as QuestionAnswerOptionListType


INSERT INTO @AnswersList (QuestionId, AnswerOptionId) values (62,94) 
INSERT INTO @AnswersList (QuestionId, AnswerOptionId) values (69, 100)
INSERT INTO @AnswersList (QuestionId, AnswerOptionId) values (70, 109)
INSERT INTO @AnswersList (QuestionId, AnswerOptionId) values (84, 135)
INSERT INTO @AnswersList (QuestionId, AnswerOptionId) values (85, 139)
INSERT INTO @AnswersList (QuestionId, AnswerOptionId) values (86, 168)
INSERT INTO @AnswersList (QuestionId, AnswerOptionId) values (87, 184)
INSERT INTO @AnswersList (QuestionId, AnswerOptionId) values (98, 194) 

EXECUTE [dbo].SurveyAnswers_Insert_Multiple_V2 
			@InstanceId,
			@AnswersList


SELECT * 
FROM dbo.SurveyAnswers

*/


INSERT INTO dbo.SurveyAnswers
			(
			[InstanceId],
			[QuestionId],
			[AnswerOptionId]
			)
SELECT 
			@InstanceId,
			QuestionId,
			AnswerOptionId

from @AnswersList


END
GO
/****** Object:  StoredProcedure [dbo].[SurveyAnswers_Select_ByCreatedBy]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SurveyAnswers_Select_ByCreatedBy]

AS

/*

	EXEC dbo.SurveyAnswers_Select_ByCreatedBy

*/

BEGIN
		Select
				[Id]
				,[InstanceId]
				,[QuestionId]
				,[AnswerOptionId]
				,[Answer]
				,[AnswerNumber]
				,[DateCreated]
				,[DateModified]
			
				FROM [dbo].SurveyAnswers 
			
		  


END


GO
/****** Object:  StoredProcedure [dbo].[SurveyAnswers_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SurveyAnswers_SelectAll]
			 @pageIndex INT
			,@pageSize INT
AS
/*
DECLARE 
			 @pageIndex int = 0
			,@pageSize int = 10

EXECUTE [dbo].[SurveyAnswers_SelectAll]
			 @pageIndex,
			 @pageSize

*/

BEGIN
	
	DECLARE @offset int = @pageIndex * @pageSize

	SELECT 
			[Id]
			,[InstanceId]
			,[QuestionId]
			,[AnswerOptionId]
			,[DateCreated]
			,[DateModified]
			,TotalCount = COUNT(1) OVER()

	  FROM [dbo].[SurveyAnswers]
	  ORDER BY dbo.SurveyAnswers.Id
	  OFFSET @offset Rows
	  FETCH Next @pageSize Rows ONLY

END

GO
/****** Object:  StoredProcedure [dbo].[SurveyAnswers_SelectById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SurveyAnswers_SelectById]
			@Id INT
	
AS
/*
DECLARE     @Id INT = 24;

EXEC dbo.SurveyAnswers_SelectById 
			@Id
*/
BEGIN

	SELECT [Id] --primary key
		  ,[InstanceId]
		  ,[QuestionId]
		  ,[AnswerOptionId]
		  ,[DateCreated]
		  ,[DateModified]
	  FROM [dbo].[SurveyAnswers]

	  WHERE Id = @Id;

  END


GO
/****** Object:  StoredProcedure [dbo].[SurveyAnswers_SelectByQuestionId]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SurveyAnswers_SelectByQuestionId]
													@QuestionId INT
	
AS
/*
DECLARE @QuestionId INT = 23;

EXEC dbo.SurveyAnswers_SelectByQuestionId 
							@QuestionId

select * from dbo.SurveyAnswers

*/

BEGIN

	SELECT [Id]
		  ,[InstanceId]
		  ,[QuestionId]
		  ,[AnswerOptionId]
		  ,[DateCreated]
		  ,[DateModified]
	  FROM [dbo].[SurveyAnswers]

	  WHERE QuestionId = @QuestionId;

  END


GO
/****** Object:  StoredProcedure [dbo].[SurveyAnswers_selectQuestionDetailsById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[SurveyAnswers_selectQuestionDetailsById] @QuestionId int

as

/*

DECLARE @QuestionId int = 23
EXECUTE dbo.SurveyAnswers_selectQuestionDetailsById @QuestionId

*/

begin

SELECT SA.[Id]
      ,SA.[InstanceId]
      ,SA.[QuestionId]
      ,SA.[AnswerOptionId]
      ,SA.[DateCreated]
      ,SA.[DateModified]
	  ,SQAO.[Text]
	  ,SQ.Question
  FROM [C80].[dbo].[SurveyAnswers] AS SA
  join dbo.SurveyQuestionAnswerOptions AS SQAO ON SQAO.QuestionId = SA.QuestionId AND SA.AnswerOptionId = SQAO.Id
  join dbo.SurveyQuestions AS SQ ON SQ.Id = @QuestionId
  where SA.QuestionId = @QuestionId

  end
GO
/****** Object:  StoredProcedure [dbo].[SurveyAnswers_Update]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SurveyAnswers_Update]
			@Id int OUTPUT,
			@InstanceId int,
			@QuestionId int,
			@AnswerOptionId int
			


AS
/*
DECLARE      @Id int = 24
			,@InstanceId int = 5
			,@QuestionId int = 27
			,@AnswerOptionId int = 2
			

EXEC dbo.SurveyAnswers_Update
			 @Id 
			,@InstanceId
			,@QuestionId 
			,@AnswerOptionId 
			

SELECT * 
FROM [dbo].[SurveyAnswers]
WHERE Id = @Id;



*/	

BEGIN
DECLARE @DateModified DATETIME2(7)=GETUTCDATE() 
UPDATE [dbo].[SurveyAnswers]

SET 
		 [InstanceId] = @InstanceId
		,[QuestionId] = @QuestionId
		,[AnswerOptionId] = @AnswerOptionId
			
		 WHERE Id = @Id;
END


GO
/****** Object:  StoredProcedure [dbo].[SurveyBuilder]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SurveyBuilder] @NewSurveyId                INT OUTPUT, 
                                 @NewSectionId               INT OUTPUT, 
                                 @NewQuestionId              INT OUTPUT, 
                                 @NewQAOId                   INT OUTPUT, 
                                 @Name                       NVARCHAR(100), 
                                 @Description                NVARCHAR(2000), 
                                 @StatusId                   INT, 
                                 @SurveyTypeId               INT, 
                                 @CreatedBy                  INT, 
                                 @SurveySections AS             SURVEYSECTIONSTYPEV2 READONLY, 
                                 @UserId                     INT, 
                                 @SurveyQuestions AS            SURVEYQUESTIONSTYPEV2 READONLY, 
                                 @SurveyQuestionAnswerOption AS SURVEYQUESTIONANSWEROPTIONSTYPE READONLY
AS

/*

DECLARE @NewSurveyId int = 0,
		 @NewSectionId INT = 0, 
		 @NewQuestionId INT = 0,
		 @NewQAOId INT = 0,
		 @UserId int = 2

DECLARE @Name NVARCHAR(100) = 'Main Survey',
        @Description NVARCHAR(2000) = 'This is our main survey.',
        @StatusId INT = 1,
        @SurveyTypeId INT = 1,
        @CreatedBy INT = 2

DECLARE @SurveySections AS SurveySectionsTypeV2
DECLARE @SurveyQuestions AS SurveyQuestionsTypeV2
DECLARE @SurveyQuestionAnswerOption AS SurveyQuestionAnswerOptionsType

-- 3 Sections
-- 5 Questions
-- 8 Answer Options

INSERT INTO @SurveySections ([Title],
							 [Description],
							 [SortOrder],
							 [TempId])
Values ('Section 1', 'This is where the description for section 1 goes.', 1, 105)

INSERT INTO @SurveyQuestions ([UserId],
							 [Question],
							 [HelpText], 
							 [IsRequired], 
							 [IsMultipleAllowed], 
							 [QuestionTypeId], 
							 [StatusId], 
							 [SortOrder],
							 [TempId]) 
Values (2, 'Q1 S1', 'Help me.', 1,0, 4, 1, 1,105)

INSERT INTO @SurveyQuestionAnswerOption ([Text], 
											 [Value], 
											 [AdditionalInfo],
											 SortOrder) 
Values ('A1 Q1 S1', 'TA01', 'This is a helpful resource.', 1)

INSERT INTO @SurveyQuestions ([UserId],
							 [Question],
							 [HelpText], 
							 [IsRequired], 
							 [IsMultipleAllowed], 
							 [QuestionTypeId], 
							 [StatusId], 
							 [SortOrder],
							 [TempId]) 
Values (2, 'Q2 S1', 'Help me.', 1,0, 4, 1, 2, 105)

INSERT INTO @SurveyQuestionAnswerOption ([Text], 
											 [Value], 
											 [AdditionalInfo],
											 SortOrder) 
Values ('A1 Q2 S1', 'TA01', 'This is a helpful resource.', 2)

INSERT INTO @SurveyQuestionAnswerOption ([Text], 
											 [Value], 
											 [AdditionalInfo],
											 SortOrder) 
Values ('A2 Q2 S1', 'TA02', 'This is a super helpful resource.', 2)

INSERT INTO @SurveySections ([Title],
							 [Description],
							 [SortOrder],
							 [TempId])
Values ('Section 2', 'This is where the description would go.', 2, 106)

INSERT INTO @SurveyQuestions ([UserId],
							 [Question],
							 [HelpText], 
							 [IsRequired], 
							 [IsMultipleAllowed], 
							 [QuestionTypeId], 
							 [StatusId], 
							 [SortOrder],
							 [TempId]) 
Values (2, 'Q1 S2', 'Help me.', 1,0, 4, 1, 3,106)

INSERT INTO @SurveyQuestionAnswerOption ([Text], 
											 [Value], 
											 [AdditionalInfo],
											 SortOrder) 
Values ('A1 Q1 S2', 'TA01', 'This is a helpful resource.', 3)

INSERT INTO @SurveyQuestionAnswerOption ([Text], 
											 [Value], 
											 [AdditionalInfo],
											 SortOrder) 
Values ('A2 Q1 S2', 'TA02', 'This is a super helpful resource.', 3)

INSERT INTO @SurveyQuestions ([UserId],
							 [Question],
							 [HelpText], 
							 [IsRequired], 
							 [IsMultipleAllowed], 
							 [QuestionTypeId], 
							 [StatusId], 
							 [SortOrder],
							 [TempId]) 
Values (2, 'Q2 S2', 'Help me.', 1,0, 4, 1, 4,106)

INSERT INTO @SurveyQuestionAnswerOption ([Text], 
											 [Value], 
											 [AdditionalInfo],
											 SortOrder) 
Values ('A1 Q2 S2', 'TA01', 'This is a helpful resource.', 4)

INSERT INTO @SurveySections ([Title],
							 [Description],
							 [SortOrder],
							 [TempId])
Values ('Section 3', 'This is where the description would go.', 2, 107)


INSERT INTO @SurveyQuestions ([UserId], 
							 [Question], 
							 [HelpText], 
							 [IsRequired], 
							 [IsMultipleAllowed], 
							 [QuestionTypeId], 
							 [StatusId], 
							 [SortOrder],
							 [TempId]) 
Values (2, 'Q1 S3', 'Help me, help you.', 0, 1, 2, 1, 5,107)

INSERT INTO @SurveyQuestionAnswerOption ([Text], 
											 [Value], 
											 [AdditionalInfo],
											 SortOrder) 
Values ('A1 Q1 S3', 'TA01', 'This is a helpful resource.', 5)

INSERT INTO @SurveyQuestionAnswerOption ([Text], 
											 [Value], 
											 [AdditionalInfo],
											 SortOrder) 
Values ('A2 Q1 S3', 'TA02', 'This is a super helpful resource.', 5)

EXECUTE dbo.SurveyBuilder   @NewSurveyId OUTPUT,
							@NewSectionId OUTPUT,
							@NewQuestionId OUTPUT,
							@NewQAOId OUTPUT,
							@Name, 
							@Description, 
							@StatusId, 
							@SurveyTypeId, 
							@CreatedBy, 
							@SurveySections, 
							@UserId,
							@SurveyQuestions,
							@SurveyQuestionAnswerOption

*/

     SET XACT_ABORT ON;
     DECLARE @tran NVARCHAR(50)= 'transaction';
    BEGIN TRY
        BEGIN TRANSACTION @tran;
        DECLARE @Date DATETIME2(7)= GETUTCDATE();
        DECLARE @SectionPairs AS SECTIONPAIRSTYPE;
        DECLARE @QuestionPairs AS QUESTIONPAIRTYPE;
        INSERT INTO dbo.Surveys
        ([Name], 
         [Description], 
         [StatusId], 
         [SurveyTypeId], 
         [CreatedBy], 
         [DateCreated], 
         [DateModified]
        )
        VALUES
        (@Name, 
         @Description, 
         @StatusId, 
         @SurveyTypeId, 
         @CreatedBy, 
         @Date, 
         @Date
        );
        SET @NewSurveyId = SCOPE_IDENTITY();
        IF EXISTS
        (
            SELECT 1
            FROM @SurveySections
        )
            BEGIN
                INSERT INTO @SectionPairs
                ([TempId], 
                 [Id]
                )
                EXECUTE dbo.SurveySections_MultipleInsert 
                        @NewSectionId, 
                        @NewSurveyId, 
                        @SurveySections;
        END;
        IF EXISTS
        (
            SELECT 1
            FROM @SurveyQuestions
        )
            BEGIN
                INSERT INTO @QuestionPairs
                (SortOrder, 
                 [Id]
                )
                EXECUTE dbo.SurveyQuestions_MultipleInsert 
                        @NewQuestionId, 
                        @UserId, 
                        @NewSectionId, 
                        @SurveyQuestions, 
                        @SectionPairs;
        END;
        IF EXISTS
        (
            SELECT 1
            FROM @SurveyQuestionAnswerOption
        )
            BEGIN
                EXECUTE dbo.SurveyQuestionAnswerOptions_Builder_InsertMultiple 
                        @NewQAOId, 
                        @CreatedBy, 
                        @QuestionPairs, 
                        @SurveyQuestionAnswerOption;
						Select @NewSurveyId
        END;
        COMMIT TRANSACTION @tran;
    END TRY
    BEGIN CATCH
        IF(XACT_STATE()) = -1
            BEGIN
                PRINT 'The transaction is in an uncommittable state.' + ' Rolling back transaction.';
                ROLLBACK TRANSACTION @Tran;
        END;
        IF(XACT_STATE()) = 1
            BEGIN
                PRINT 'The transaction is committable.' + ' Committing transaction.';
                COMMIT TRANSACTION @Tran;
        END;
        THROW;
    END CATCH;
     SET XACT_ABORT OFF;
GO
/****** Object:  StoredProcedure [dbo].[SurveyInstance_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SurveyInstance_Insert]
								@NewSurveyId                INT OUTPUT, 
                                 @NewSectionId               INT OUTPUT, 
                                 @NewQuestionId              INT OUTPUT, 
                                 @NewQAOId                   INT OUTPUT, 
                                 @Name                       NVARCHAR(100), 
                                 @Description                NVARCHAR(2000), 
                                 @StatusId                   INT, 
                                 @SurveyTypeId               INT, 
                                 @CreatedBy                  INT, 
                                 @SurveySections AS             SURVEYSECTIONSTYPEV2 READONLY, 
                                 @UserId                     INT, 
                                 @SurveyQuestions AS            SURVEYQUESTIONSTYPEV2 READONLY, 
                                 @SurveyQuestionAnswerOption AS SURVEYQUESTIONANSWEROPTIONSTYPE READONLY
AS

/*

DECLARE @NewSurveyId int = 0,
		 @NewSectionId INT = 0, 
		 @NewQuestionId INT = 0,
		 @NewQAOId INT = 0,
		 @UserId int = 2

DECLARE @Name NVARCHAR(100) = 'Main Survey',
        @Description NVARCHAR(2000) = 'This is our main survey.',
        @StatusId INT = 1,
        @SurveyTypeId INT = 1,
        @CreatedBy INT = 2

DECLARE @SurveySections AS SurveySectionsTypeV2
DECLARE @SurveyQuestions AS SurveyQuestionsTypeV2
DECLARE @SurveyQuestionAnswerOption AS SurveyQuestionAnswerOptionsType

-- 3 Sections
-- 5 Questions
-- 8 Answer Options

INSERT INTO @SurveySections ([Title],
							 [Description],
							 [SortOrder],
							 [TempId])
Values ('Section 1', 'This is where the description for section 1 goes.', 1, 105)

INSERT INTO @SurveyQuestions ([UserId],
							 [Question],
							 [HelpText], 
							 [IsRequired], 
							 [IsMultipleAllowed], 
							 [QuestionTypeId], 
							 [StatusId], 
							 [SortOrder],
							 [TempId]) 
Values (2, 'Q1 S1', 'Help me.', 1,0, 4, 1, 1,105)

INSERT INTO @SurveyQuestionAnswerOption ([Text], 
											 [Value], 
											 [AdditionalInfo],
											 SortOrder) 
Values ('A1 Q1 S1', 'TA01', 'This is a helpful resource.', 1)

INSERT INTO @SurveyQuestions ([UserId],
							 [Question],
							 [HelpText], 
							 [IsRequired], 
							 [IsMultipleAllowed], 
							 [QuestionTypeId], 
							 [StatusId], 
							 [SortOrder],
							 [TempId]) 
Values (2, 'Q2 S1', 'Help me.', 1,0, 4, 1, 2, 105)

INSERT INTO @SurveyQuestionAnswerOption ([Text], 
											 [Value], 
											 [AdditionalInfo],
											 SortOrder) 
Values ('A1 Q2 S1', 'TA01', 'This is a helpful resource.', 2)

INSERT INTO @SurveyQuestionAnswerOption ([Text], 
											 [Value], 
											 [AdditionalInfo],
											 SortOrder) 
Values ('A2 Q2 S1', 'TA02', 'This is a super helpful resource.', 2)

INSERT INTO @SurveySections ([Title],
							 [Description],
							 [SortOrder],
							 [TempId])
Values ('Section 2', 'This is where the description would go.', 2, 106)

INSERT INTO @SurveyQuestions ([UserId],
							 [Question],
							 [HelpText], 
							 [IsRequired], 
							 [IsMultipleAllowed], 
							 [QuestionTypeId], 
							 [StatusId], 
							 [SortOrder],
							 [TempId]) 
Values (2, 'Q1 S2', 'Help me.', 1,0, 4, 1, 3,106)

INSERT INTO @SurveyQuestionAnswerOption ([Text], 
											 [Value], 
											 [AdditionalInfo],
											 SortOrder) 
Values ('A1 Q1 S2', 'TA01', 'This is a helpful resource.', 3)

INSERT INTO @SurveyQuestionAnswerOption ([Text], 
											 [Value], 
											 [AdditionalInfo],
											 SortOrder) 
Values ('A2 Q1 S2', 'TA02', 'This is a super helpful resource.', 3)

INSERT INTO @SurveyQuestions ([UserId],
							 [Question],
							 [HelpText], 
							 [IsRequired], 
							 [IsMultipleAllowed], 
							 [QuestionTypeId], 
							 [StatusId], 
							 [SortOrder],
							 [TempId]) 
Values (2, 'Q2 S2', 'Help me.', 1,0, 4, 1, 4,106)

INSERT INTO @SurveyQuestionAnswerOption ([Text], 
											 [Value], 
											 [AdditionalInfo],
											 SortOrder) 
Values ('A1 Q2 S2', 'TA01', 'This is a helpful resource.', 4)

INSERT INTO @SurveySections ([Title],
							 [Description],
							 [SortOrder],
							 [TempId])
Values ('Section 3', 'This is where the description would go.', 2, 107)


INSERT INTO @SurveyQuestions ([UserId], 
							 [Question], 
							 [HelpText], 
							 [IsRequired], 
							 [IsMultipleAllowed], 
							 [QuestionTypeId], 
							 [StatusId], 
							 [SortOrder],
							 [TempId]) 
Values (2, 'Q1 S3', 'Help me, help you.', 0, 1, 2, 1, 5,107)

INSERT INTO @SurveyQuestionAnswerOption ([Text], 
											 [Value], 
											 [AdditionalInfo],
											 SortOrder) 
Values ('A1 Q1 S3', 'TA01', 'This is a helpful resource.', 5)

INSERT INTO @SurveyQuestionAnswerOption ([Text], 
											 [Value], 
											 [AdditionalInfo],
											 SortOrder) 
Values ('A2 Q1 S3', 'TA02', 'This is a super helpful resource.', 5)

EXECUTE dbo.SurveyBuilder   @NewSurveyId OUTPUT,
							@NewSectionId OUTPUT,
							@NewQuestionId OUTPUT,
							@NewQAOId OUTPUT,
							@Name, 
							@Description, 
							@StatusId, 
							@SurveyTypeId, 
							@CreatedBy, 
							@SurveySections, 
							@UserId,
							@SurveyQuestions,
							@SurveyQuestionAnswerOption

*/

     SET XACT_ABORT ON;
     DECLARE @tran NVARCHAR(50)= 'transaction';
    BEGIN TRY
        BEGIN TRANSACTION @tran;
        DECLARE @Date DATETIME2(7)= GETUTCDATE();
        DECLARE @SectionPairs AS SECTIONPAIRSTYPE;
        DECLARE @QuestionPairs AS QUESTIONPAIRTYPE;
        INSERT INTO dbo.Surveys
        ([Name], 
         [Description], 
         [StatusId], 
         [SurveyTypeId], 
         [CreatedBy], 
         [DateCreated], 
         [DateModified]
        )
        VALUES
        (@Name, 
         @Description, 
         @StatusId, 
         @SurveyTypeId, 
         @CreatedBy, 
         @Date, 
         @Date
        );
        SET @NewSurveyId = SCOPE_IDENTITY();
        IF EXISTS
        (
            SELECT 1
            FROM @SurveySections
        )
            BEGIN
                INSERT INTO @SectionPairs
                ([TempId], 
                 [Id]
                )
                EXECUTE dbo.SurveySections_MultipleInsert 
                        @NewSectionId, 
                        @NewSurveyId, 
                        @SurveySections;
        END;
        IF EXISTS
        (
            SELECT 1
            FROM @SurveyQuestions
        )
            BEGIN
                INSERT INTO @QuestionPairs
                (SortOrder, 
                 [Id]
                )
                EXECUTE dbo.SurveyQuestions_MultipleInsert 
                        @NewQuestionId, 
                        @UserId, 
                        @NewSectionId, 
                        @SurveyQuestions, 
                        @SectionPairs;
        END;
        IF EXISTS
        (
            SELECT 1
            FROM @SurveyQuestionAnswerOption
        )
            BEGIN
                EXECUTE dbo.SurveyQuestionAnswerOptions_Builder_InsertMultiple 
                        @NewQAOId, 
                        @CreatedBy, 
                        @QuestionPairs, 
                        @SurveyQuestionAnswerOption;
        END;
        COMMIT TRANSACTION @tran;
    END TRY
    BEGIN CATCH
        IF(XACT_STATE()) = -1
            BEGIN
                PRINT 'The transaction is in an uncommittable state.' + ' Rolling back transaction.';
                ROLLBACK TRANSACTION @Tran;
        END;
        IF(XACT_STATE()) = 1
            BEGIN
                PRINT 'The transaction is committable.' + ' Committing transaction.';
                COMMIT TRANSACTION @Tran;
        END;
        THROW;
    END CATCH;
     SET XACT_ABORT OFF;
GO
/****** Object:  StoredProcedure [dbo].[SurveyInstance_Select_AnswerId]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SurveyInstance_Select_AnswerId]

@Id INT

AS

/*
DECLARE @Id INT = 19
EXECUTE SurveyInstance_Select_AnswerId @Id
*/

BEGIN
				
SELECT Answers.Id as AnswerId


         FROM [dbo].[SurveysInstances] as Si 
		 Join dbo.Surveys as S 
			on Si.SurveyId =S.Id 
		 Join dbo.SurveyStatus as Sst
			on Sst.Id =S.StatusId
		 Join dbo.SurveyTypes as St 
			on St.Id= S.SurveyTypeId
		JOIN SurveySections as SS
			on S.Id=Ss.[SurveyId] AND Ss.SurveyId =S.Id
		JOIN dbo.SurveyQuestions as Questions  
			on Ss.Id=Questions.SectionId
		JOIN dbo.SurveyAnswers as Answers 
			on Answers.QuestionId= Questions.Id AND Answers.InstanceId = @Id
		JOIN dbo.SurveyQuestionAnswerOptions as AnswerValues
			on Answers.AnswerOptionId = AnswerValues.Id
		 
        Where Si.Id=@Id

END


GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestionAnswerOptions_Builder_InsertMultiple]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SurveyQuestionAnswerOptions_Builder_InsertMultiple] @Id                              INT OUTPUT, 
                                                                      @CreatedBy                       INT, 
                                                                      @QuestionPairs AS                   QuestionPairType READONLY,
																	  @SurveyQuestionAnswerOptions AS SurveyQuestionAnswerOptionsType READONLY
AS

/**
DECLARE @Id int = 0,
		@QuestionId int = 25,
		@SurveyQuestionAnswerOptionsType AS SURVEYQUESTIONANSWEROPTIONSTYPE,
        @CreatedBy int = 4
INSERT INTO @SurveyQuestionAnswerOptionsType([Text], 
											 [Value], 
											 [AdditionalInfo]) 
VALUES ('Restaurants','TA01','This is where the additiona; info would be stored.')
INSERT INTO @SurveyQuestionAnswerOptionsType([Text], 
											 [Value], 
											 [AdditionalInfo]) 
VALUES ('Retail','TA02','This is where the correct additional info would be stored.')
EXECUTE dbo.SurveyQuestionAnswerOptions_Builder_InsertMultiple @Id OUT, @QuestionId, @SurveyQuestionAnswerOptionsType, @CreatedBy
SELECT * FROM [SurveyQuestionAnswerOptions]
**/

    BEGIN
        INSERT INTO [dbo].[SurveyQuestionAnswerOptions]
        ([QuestionId], 
         [Text], 
         [Value], 
         [AdditionalInfo], 
         [CreatedBy],
		 [SortOrder]
        )
               SELECT QP.Id, 
                      S.[Text], 
                      S.[Value], 
                      S.[AdditionalInfo], 
                      @CreatedBy,
					  S.SortOrder
               FROM @SurveyQuestionAnswerOptions AS S
                    INNER JOIN @QuestionPairs AS QP ON QP.SortOrder = S.SortOrder;
	END;
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestionAnswerOptions_Builder_InsertMultiple_v1]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SurveyQuestionAnswerOptions_Builder_InsertMultiple_v1] 
																	@Id                              INT OUTPUT, 
                                                                    @QuestionId                      INT, 
                                                                    @SurveyQuestionAnswerOptionsType AS SURVEYQUESTIONANSWEROPTIONSTYPE READONLY, 
                                                                    @CreatedBy                       INT
AS

/**

		DECLARE @Id int = 69,
				@QuestionId int = 98,
				@SurveyQuestionAnswerOptionsType AS SURVEYQUESTIONANSWEROPTIONSTYPE,
				@CreatedBy int = 2

		INSERT INTO @SurveyQuestionAnswerOptionsType([Text], 
													 [Value], 
													 [AdditionalInfo]) 
		VALUES ('Women','DEMO1','')
		
		INSERT INTO @SurveyQuestionAnswerOptionsType([Text], 
													 [Value], 
													 [AdditionalInfo]) 
		VALUES ('African Americans','DEMO2','')
	
		INSERT INTO @SurveyQuestionAnswerOptionsType([Text], 
													 [Value], 
													 [AdditionalInfo]) 
		VALUES ('Latinx','DEMO3','')
		
		INSERT INTO @SurveyQuestionAnswerOptionsType([Text], 
													 [Value], 
													 [AdditionalInfo]) 
		VALUES ('Asian & Pacific Islanders','DEMO4','')
		
		INSERT INTO @SurveyQuestionAnswerOptionsType([Text], 
													 [Value], 
													 [AdditionalInfo]) 
		VALUES ('Veterans','DEMO5','')
		
		INSERT INTO @SurveyQuestionAnswerOptionsType([Text], 
													 [Value], 
													 [AdditionalInfo]) 
		VALUES ('Low income**','DEMO6','')
		
		INSERT INTO @SurveyQuestionAnswerOptionsType([Text], 
													 [Value], 
													 [AdditionalInfo]) 
		VALUES ('Homeless','DEMO7','')
		
		INSERT INTO @SurveyQuestionAnswerOptionsType([Text], 
													 [Value], 
													 [AdditionalInfo]) 
		VALUES ('Justice Involved','DEMO8','')
		
		INSERT INTO @SurveyQuestionAnswerOptionsType([Text], 
													 [Value], 
													 [AdditionalInfo]) 
		VALUES ('Disabilities','DEMO9','')
		
		INSERT INTO @SurveyQuestionAnswerOptionsType([Text], 
													 [Value], 
													 [AdditionalInfo]) 
		VALUES ('Youth','DEMO10','')
		
		INSERT INTO @SurveyQuestionAnswerOptionsType([Text], 
													 [Value], 
													 [AdditionalInfo]) 
		VALUES ('Foster Youth','DEMO11','')

			EXECUTE dbo.SurveyQuestionAnswerOptions_Builder_InsertMultiple_v1 

			@Id OUT, 
			@QuestionId, 
			@SurveyQuestionAnswerOptionsType, 
			@CreatedBy
	
			SELECT * 
			FROM [SurveyQuestionAnswerOptions]
**/

    BEGIN
        INSERT INTO [dbo].[SurveyQuestionAnswerOptions]
        ([QuestionId], 
         [Text], 
         [Value], 
         [AdditionalInfo], 
         [CreatedBy]
        )
               SELECT @QuestionId, 
                      [Text], 
                      [Value], 
                      [AdditionalInfo], 
                      @CreatedBy
               FROM @SurveyQuestionAnswerOptionsType;
        SET @Id = SCOPE_IDENTITY();
    END;
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestionAnswerOptions_Delete]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[SurveyQuestionAnswerOptions_Delete]
				@Id int
AS
/*		
		Select * from SurveyQuestionAnswerOptions
		DECLARE @Id INT = 38;
		EXEC dbo.SurveyQuestionAnswerOptions_Delete @Id;
		Select * from SurveyQuestionAnswerOptions

*/
BEGIN

		DELETE FROM
				[dbo].[SurveyAnswers]			
		WHERE
				QuestionId=@Id;
		DELETE FROM
				[dbo].[SurveyQuestionAnswerOptions]			
		WHERE
				QuestionId=@Id;

END
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestionAnswerOptions_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[SurveyQuestionAnswerOptions_Insert]
			@Id int OUTPUT,
			@QuestionId int,
			@Text nvarchar(500),
			@Value nvarchar(100),
			@AdditionalInfo nvarchar(100),
			@CreatedBy int
			



as
/*

DECLARE
		@Id int,
		@QuestionId int= 70,
		@Text nvarchar(500)='Hiring Staff',
		@Value nvarchar(100)='ST2',
		@AdditionalInfo nvarchar(100)='',
		@CreatedBy int=2;
	
	EXECUTE [dbo].[SurveyQuestionAnswerOptions_Insert]
			@Id output,
			@QuestionId,
			@Text,
			@Value,
			@AdditionalInfo,
			@CreatedBy;

		
		
	SELECT * FROM [dbo].[SurveyQuestionAnswerOptions] Where Id=@Id ;

*/
BEGIN


	INSERT INTO 
		[dbo].[SurveyQuestionAnswerOptions]
           ([QuestionId]
           ,[Text]
           ,[Value]
           ,[AdditionalInfo]
           ,[CreatedBy]
		   ) VALUES (
			@QuestionId,
			@Text,
			@Value,
			@AdditionalInfo,
			@CreatedBy
			);

	SET @Id = SCOPE_IDENTITY()

 END


GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestionAnswerOptions_InsertMultiple]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[SurveyQuestionAnswerOptions_InsertMultiple]
	@AnswerOptionsList as [dbo].[AnswerOptionsListType] READONLY
			
			
as
/**
DECLARE @AnswerOptionsList as AnswerOptionsListType,
        @CreatedBy int = 4
INSERT INTO @AnswerOptionsList(Url, FileTypeId) values
EXECUTE dbo.SurveyQuestionAnswerOptions_InsertMultiple @AnswerOptionsLis, @CreatedBy
SELECT * FROM [SurveyQuestionAnswerOptions]
**/

begin

	insert into [dbo].[SurveyQuestionAnswerOptions]
			([QuestionId]
           ,[Text]
           ,[Value]
           ,[AdditionalInfo]
           ,[CreatedBy]
		   )
		 select * from @AnswerOptionsList
	
end

GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestionAnswerOptions_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[SurveyQuestionAnswerOptions_SelectAll]
				@PageIndex int,  
				@PageSize int 
AS
/*
		Declare 
		@PageIndex int=0, 
		@PageSize int=300

		EXEC dbo.SurveyQuestionAnswerOptions_SelectAll 
		@PageIndex, 
		@PageSize;

*/
BEGIN
		Declare @Offset int = @PageIndex * @PageSize
		SELECT
				AO.[Id],
				AO.[QuestionId],
				SQ.[Question] as Question,
				AO.[Text],
				AO.[Value],
				AO.[AdditionalInfo],
				UP.[FirstName]+' '+
				UP.[LastName] as CreatedBy,
				AO.[DateCreated],
				AO.[DateModified],
				SQ.[QuestionTypeId] as QuestionTypeId,
				QT.[Name] AS QuestionTypeName,

				TotalCount = COUNT(1) OVER()
		FROM
				[dbo].[SurveyQuestionAnswerOptions] AS AO
		
		Join	[dbo].[SurveyQuestions] as SQ on SQ.Id=AO.QuestionId
		Join    [dbo].QuestionTypes as QT on QT.Id= SQ.QuestionTypeId
		Join	[dbo].[UserProfiles] as UP on UP.UserId=AO.CreatedBy

		ORDER BY AO.Id  

		OFFSET @offSet Rows
		Fetch Next @pageSize Rows ONLY
		
				

END
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestionAnswerOptions_SelectByCreatedBy]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[SurveyQuestionAnswerOptions_SelectByCreatedBy]
				@CreatedBy int,
				@PageIndex int,  
				@PageSize int 
AS
/*
		Declare 
		@CreatedBy int=2, 
		@PageIndex int=0, 
		@PageSize int=10

		EXEC dbo.SurveyQuestionAnswerOptions_SelectByCreatedBy 
		@CreatedBy, 
		@PageIndex,
		@PageSize;

*/
BEGIN
		Declare @Offset int = @PageIndex * @PageSize
		SELECT
				AO.[Id],
				AO.[QuestionId],
				SQ.[Question] as Question,
				AO.[Text],
				AO.[Value],
				AO.[AdditionalInfo],
				UP.[FirstName]+' '+
				UP.[LastName] as CreatedBy,
				AO.[DateCreated],
				AO.[DateModified],
				SQ.[QuestionTypeId] as QuestionTypeId,
				QT.[Name] AS QuestionTypeName

		FROM
				[dbo].[SurveyQuestionAnswerOptions] AS AO
		
		Join	[dbo].[SurveyQuestions] as SQ on SQ.Id=AO.QuestionId
		Join    [dbo].QuestionTypes as QT on QT.Id= SQ.QuestionTypeId
		Join	[dbo].[UserProfiles] as UP on UP.UserId=AO.CreatedBy
		WHERE AO.[CreatedBy]=@CreatedBy
		ORDER BY AO.Id  

		OFFSET @offSet Rows
		Fetch Next @pageSize Rows ONLY
		
				

END
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestionAnswerOptions_SelectById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[SurveyQuestionAnswerOptions_SelectById]
				@Id int
AS
/*
		DECLARE @Id INT = 8;
		EXEC dbo.SurveyQuestionAnswerOptions_SelectById @Id;

*/
BEGIN

		SELECT
				AO.[Id],
				AO.[QuestionId],
				SQ.[Question] as Question,
				AO.[Text],
				AO.[Value],
				AO.[AdditionalInfo],
				UP.[FirstName]+' '+
				UP.[LastName] as CreatedBy,
				AO.[DateCreated],
				AO.[DateModified],
				SQ.[QuestionTypeId] as QuestionTypeId,
				QT.[Name] AS QuestionTypeName
		FROM
				[dbo].[SurveyQuestionAnswerOptions] AS AO
		
		Join	[dbo].[SurveyQuestions] as SQ on SQ.Id=AO.QuestionId
		Join    [dbo].QuestionTypes as QT on QT.Id= SQ.QuestionTypeId
		Join	[dbo].[UserProfiles] as UP on UP.UserId=AO.CreatedBy
		
		WHERE
				AO.QuestionId=@Id;

END
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestionAnswerOptions_SelectByQuestionId]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[SurveyQuestionAnswerOptions_SelectByQuestionId]
				@QId int
AS
/*
		DECLARE @QId INT = 38;
		EXEC dbo.[SurveyQuestionAnswerOptions_SelectByQuestionId] @QId

*/
BEGIN

	SELECT
				AO.[Id],
				AO.[QuestionId],
				SQ.[Question] as Question,
				AO.[Text],
				AO.[Value],
				AO.[AdditionalInfo],
				UP.[FirstName]+' '+
				UP.[LastName] as CreatedBy,
				AO.[DateCreated],
				AO.[DateModified],
				SQ.[QuestionTypeId] as QuestionTypeId,
				QT.[Name] AS QuestionTypeName
		FROM
				[dbo].[SurveyQuestionAnswerOptions] AS AO
		Join	[dbo].[UserProfiles] as UP on UP.UserId=AO.CreatedBy
		Join	[dbo].[SurveyQuestions] as SQ on SQ.Id = AO.QuestionId
		Join    [dbo].QuestionTypes as QT on QT.Id= SQ.QuestionTypeId

		WHERE
				AO.QuestionId=@QId;
	

END
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestionAnswerOptions_Update]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[SurveyQuestionAnswerOptions_Update]
			@Id int,
			@QuestionId int,
			@Text nvarchar(500),
			@Value nvarchar(100),
			@AdditionalInfo nvarchar(100),
			@CreatedBy int



AS
/*

DECLARE
		@Id int=1,
		@QuestionId int=2,
		@Text nvarchar(500)='This is updated value',
		@Value nvarchar(100)='the test value2',
		@AdditionalInfo nvarchar(100)='testingInfo2',
		@CreatedBy int=2;
	
	EXECUTE [dbo].[SurveyQuestionAnswerOptions_Update]
			@Id,
			@QuestionId,
			@Text,
			@Value,
			@AdditionalInfo,
			@CreatedBy;

		
		
	SELECT * FROM [dbo].[SurveyQuestionAnswerOptions] Where Id=@Id ;

*/
BEGIN

	DECLARE @DateModified DATETIME2(7) = GETUTCDATE()
	UPDATE 
		[dbo].[SurveyQuestionAnswerOptions]
	SET			
			[QuestionId]=@QuestionId,
			[Text]=@Text,
			[Value]=@Value,
			[AdditionalInfo]=@AdditionalInfo,
			[CreatedBy]=@CreatedBy,
			[DateModified]=@DateModified
	WHERE 
			Id=@Id

 END


GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestionAnswerOptions_UpdateMultiple]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SurveyQuestionAnswerOptions_UpdateMultiple]
 @AnswerOptionsList  as dbo.AnswerOptionsUpdateListType READONLY
 as
 /*
 declare  @AnswerOptionsList  as AnswerOptionsUpdateListType
 Insert INTo @AnswerOptionsList VALUES (8, 'Hello Ivan')
Insert INTo @AnswerOptionsList VALUES (9, 'Bye Ivan')
execute [dbo].[SurveyQuestionAnswerOptions_UpdateMultiple] @AnswerOptionsList
select * from dbo.SurveyQuestionAnswerOptions
 */
 begin


Update dbo.SurveyQuestionAnswerOptions

SET [Text] =  s.[Text]

from @AnswerOptionsList as S
Where dbo.SurveyQuestionAnswerOptions.Id = s.Id

end
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestions_Delete_ById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SurveyQuestions_Delete_ById] 
@Id INT
AS

/*
DECLARE @_id int = 1
EXECUTE [dbo].[SurveyQuestions_Delete_ById] @_id
*/

    BEGIN
        DELETE FROM [dbo].[SurveyQuestions]
        WHERE @Id = Id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestions_GetAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SurveyQuestions_GetAll]
	
AS

/*------------- TEST CODE --------------

EXECUTE [dbo].[SurveyQuestions_GetAll]
	
*/--------------------------------------
    BEGIN
       
        SELECT [Id], 
               [UserId], 
               [Question], 
               [HelpText], 
               [IsRequired], 
               [IsMultipleAllowed], 
               [QuestionTypeId], 
               [SectionId], 
               [StatusId], 
               [SortOrder], 
               [DateCreated], 
               [DateModified] 
               
        FROM [dbo].[SurveyQuestions]
       
    END
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestions_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SurveyQuestions_Insert]
	@Id                INT OUTPUT,
	@UserId            INT, 
	@Question          NVARCHAR(500), 
	@HelpText          NVARCHAR(255), 
	@IsRequired        BIT, 
	@IsMultipleAllowed BIT, 
	@QuestionTypeId    INT, 
	@SectionId         INT, 
	@StatusId          INT, 
	@SortOrder         INT

AS

/*--------------- TEST CODE --------------------		
DECLARE @_id INT,
	@_userId INT = 2,
	@_question NVARCHAR(500) = 'Are you seeking capital for your businesses?',
	@_helpText NVARCHAR(255) = 'Please select necessary capital types.',
	@_isRequired BIT = 1,
	@_isMultipleAllowed BIT = 1,
	@_questionTypeId INT = 2,
	@_sectionId INT = 64,
	@_statusId INT = 2,
	@_sortOrder INT = 1

EXECUTE [dbo].[SurveyQuestions_Insert] 
	@_id,
	@_userId,
	@_question,
	@_helpText,
	@_isRequired,
	@_isMultipleAllowed,
	@_questionTypeId,
	@_sectionId,
	@_statusId,
	@_sortOrder
	

		SELECT *
		FROM [dbo].[SurveyQuestions]
*/

    BEGIN
        INSERT INTO [dbo].[SurveyQuestions]
        ([UserId], 
         [Question], 
         [HelpText], 
         [IsRequired], 
         [IsMultipleAllowed], 
         [QuestionTypeId], 
         [SectionId], 
         [StatusId], 
         [SortOrder]
        )
        VALUES
        (@UserId, 
         @Question, 
         @HelpText, 
         @IsRequired, 
         @IsMultipleAllowed, 
         @QuestionTypeId, 
         @SectionId, 
         @StatusId, 
         @SortOrder
        );
        SET @Id = SCOPE_IDENTITY();
    END;
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestions_MultipleInsert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SurveyQuestions_MultipleInsert] @Id              INT OUTPUT, 
                                                  @UserId          INT, 
                                                  @SectionId       INT, 
                                                  @SurveyQuestions AS SURVEYQUESTIONSTYPEV2 READONLY, 
                                                  @SectionPairs AS    SectionPairsType READONLY
AS

/*--------------- TEST CODE --------------------		
DECLARE @Id INT = 0, @UserId INT = 2, @SectionId INT = 9, @SurveyQuestions AS SURVEYQUESTIONSTYPEV2;
INSERT INTO @SurveyQuestions
([Question], 
 [HelpText], 
 [IsRequired], 
 [IsMultipleAllowed], 
 [QuestionTypeId], 
 [StatusId], 
 [SortOrder],
 [TempId])
VALUES ('What is your Question?','This is the help text.',1,0,2,1,1,43)
INSERT INTO @SurveyQuestions
([Question], 
 [HelpText], 
 [IsRequired], 
 [IsMultipleAllowed], 
 [QuestionTypeId], 
 [StatusId], 
 [SortOrder],
 [TempId])
VALUES ('What is your other Question?','This is the new help text.',1,0,2,1,1,12)
EXECUTE [dbo].[SurveyQuestions_MultipleInsert] 
        @Id OUT, 
        @UserId, 
		@SectionId,
        @SurveyQuestions
SELECT *
FROM [dbo].[SurveyQuestions];
*/

    BEGIN
        DECLARE @Date DATETIME2(7)= GETUTCDATE();
        INSERT INTO [dbo].[SurveyQuestions]
        ([UserId], 
         [Question], 
         [HelpText], 
         [IsRequired], 
         [IsMultipleAllowed], 
         [QuestionTypeId], 
         [SectionId], 
         [StatusId], 
         [SortOrder], 
         [DateCreated], 
         [DateModified], 
         [TempId]
        )
               SELECT @UserId, 
                      SQ.[Question], 
                      SQ.[HelpText], 
                      SQ.[IsRequired], 
                      SQ.[IsMultipleAllowed], 
                      SQ.[QuestionTypeId], 
                      SP.Id, 
                      SQ.[StatusId], 
                      SQ.[SortOrder], 
                      @Date, 
                      @Date, 
                      SQ.TempId
               FROM @SurveyQuestions AS SQ
                    INNER JOIN @SectionPairs AS SP ON SP.TempId = SQ.TempId;
        SELECT SQ.SortOrder, 
               SQ.Id
        FROM dbo.SurveyQuestions AS SQ
             INNER JOIN @SectionPairs AS SP ON SP.TempId = SQ.TempId
        WHERE SectionId = SP.Id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestions_OptionsDetails_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SurveyQuestions_OptionsDetails_SelectAll]
AS

/*
			EXEC dbo.SurveyQuestions_OptionsDetails_SelectAll

*/

    BEGIN
        EXEC dbo.QuestionTypes_SelectAll;
        EXEC dbo.SurveySections_GetAll;
        EXEC dbo.SurveyStatus_SelectAll;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestions_Search]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SurveyQuestions_Search]
				 @Query nvarchar(100)
/*

	declare @Query nvarchar(100) = 'What', @pageIndex int=0, @pageSize int=5
	Execute [dbo].[SurveyQuestions_Search] @Query,@pageIndex,@pageSize

*/

as
BEGIN
		


        SELECT [Id], 
               [UserId], 
               [Question], 
               [HelpText], 
               [IsRequired], 
               [IsMultipleAllowed], 
               [QuestionTypeId], 
               [SectionId], 
               [StatusId], 
               [SortOrder], 
               [DateCreated], 
               [DateModified],
        
			   TotalCount = COUNT(1) OVER()
        FROM [dbo].[SurveyQuestions]

		WHERE Question LIKE '%' + @Query + '%'
	 
		ORDER BY Question

		
END;
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestions_Select_ByCreatedBy]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SurveyQuestions_Select_ByCreatedBy]
			@CreatedBy int
AS

/*
DECLARE @_createdBy int = 1
EXECUTE [dbo].[SurveyQuestions_Select_ByCreatedBy] @_createdBy
*/

    BEGIN
        SELECT [Id], 
               [UserId], 
               [Question], 
               [HelpText], 
               [IsRequired], 
               [IsMultipleAllowed], 
               [QuestionTypeId], 
               [SectionId], 
               [StatusId], 
               [SortOrder], 
               [DateCreated], 
               [DateModified]
        FROM [dbo].[SurveyQuestions]
        WHERE @CreatedBy = UserId 
    END;
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestions_Select_ById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SurveyQuestions_Select_ById] 
			@Id INT
AS

/* --------------TEST CODE ---------------
DECLARE @_id int = 84

EXECUTE [dbo].[SurveyQuestions_Select_ById] 
		@_id
*/---------------------------------------

    BEGIN
        SELECT [Id], 
               [UserId], 
               [Question], 
               [HelpText], 
               [IsRequired], 
               [IsMultipleAllowed], 
               [QuestionTypeId], 
               [SectionId], 
               [StatusId], 
               [SortOrder], 
               [DateCreated], 
               [DateModified]
        FROM [dbo].[SurveyQuestions]
        WHERE @Id = Id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestions_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SurveyQuestions_SelectAll]
		@PageIndex INT, 
		@PageSize  INT
AS

/*------------- TEST CODE --------------
DECLARE @PageIndex int = 0,
		@PageSize int = 6

EXECUTE [dbo].[SurveyQuestions_SelectAll]
		@PageIndex,
		@PageSize
*/--------------------------------------
    BEGIN
        DECLARE @Offset INT= @PageIndex * @PageSize;
        SELECT [Id], 
               [UserId], 
               [Question], 
               [HelpText], 
               [IsRequired], 
               [IsMultipleAllowed], 
               [QuestionTypeId], 
               [SectionId], 
               [StatusId], 
               [SortOrder], 
               [DateCreated], 
               [DateModified], 
               TotalCount = COUNT(1) OVER()
        FROM [dbo].[SurveyQuestions]
        ORDER BY [dbo].[SurveyQuestions].Id
        OFFSET @Offset ROWS 
		FETCH NEXT @PageSize ROWS ONLY;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestions_SelectAllWithDetails]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SurveyQuestions_SelectAllWithDetails] @PageIndex INT, 
                                                        @PageSize  INT
AS

/*------------- TEST CODE --------------

DECLARE @PageIndex int = 0,
		@PageSize int = 6

EXECUTE [dbo].[SurveyQuestions_SelectAllWithDetails]
		@PageIndex,
		@PageSize

*/

    BEGIN
        DECLARE @Offset INT= @PageIndex * @PageSize;
        SELECT SQ.[Id], 
               SQ.[UserId], 
               SQ.[Question], 
               SQ.[HelpText], 
               SQ.[IsRequired], 
               SQ.[IsMultipleAllowed], 
               SQ.[QuestionTypeId], 
               SQ.[SectionId], 
               SQ.[StatusId], 
               SQ.[SortOrder], 
               SQ.[DateCreated], 
               SQ.[DateModified], 
               QT.[Name] AS QuestionTypeName, 
               SS.[Title] AS SectionName, 
               ST.[Name] AS StatusName, 
               totalCount = COUNT(1) OVER()
        FROM dbo.SurveyQuestions AS SQ
             JOIN dbo.QuestionTypes AS QT ON SQ.QuestionTypeId = QT.Id
             JOIN dbo.SurveySections AS SS ON SQ.SectionId = SS.Id
             JOIN dbo.SurveyStatus AS ST ON SQ.StatusId = ST.Id
        ORDER BY SQ.Id
        OFFSET @offset ROWS FETCH NEXT @pageSize ROWS ONLY;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestions_Update]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SurveyQuestions_Update] 
			@Id                INT, 
			@UserId            INT, 
			@Question          NVARCHAR(500), 
			@HelpText          NVARCHAR(255), 
			@IsRequired        BIT, 
			@IsMultipleAllowed BIT, 
			@QuestionTypeId    INT, 
			@SectionId         INT, 
			@StatusId          INT, 
			@SortOrder         INT
AS

/*-------------TEST CODE -------------
DECLARE @_id INT = 84,
	@_userId INT = 2,
	@_question NVARCHAR(500) = 'Are you seeking capital for your businesses?',
	@_helpText NVARCHAR(255) = 'Please select necessary capital types.',
	@_isRequired BIT = 1,
	@_isMultipleAllowed BIT = 1,
	@_questionTypeId INT = 2,
	@_sectionId INT = 65,
	@_statusId INT = 2,
	@_sortOrder INT = 1

EXECUTE [dbo].[SurveyQuestions_Update] 
	@_id,
	@_userId,
	@_question,
	@_helpText,
	@_isRequired,
	@_isMultipleAllowed,
	@_questionTypeId,
	@_sectionId,
	@_statusId,
	@_sortOrder
*/

    ------------------------------------

    BEGIN
        DECLARE @DateModified DATETIME2(7)= GETUTCDATE();
        UPDATE [dbo].[SurveyQuestions]
          SET 
              [UserId] = @UserId, 
              [Question] = @Question, 
              [HelpText] = @HelpText, 
              [IsRequired] = @IsRequired, 
              [IsMultipleAllowed] = @IsMultipleAllowed, 
              [QuestionTypeId] = @QuestionTypeId, 
              [SectionId] = @SectionId, 
              [StatusId] = @StatusId, 
              [SortOrder] = @SortOrder, 
              [DateModified] = @DateModified
        WHERE @Id = Id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Surveys_ByCreatedBy]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Surveys_ByCreatedBy] 
			@pageIndex INT = 0, 
			@pageSize  INT = 10, 
			@CreatedBy INT
AS

/* 

DECLARE		@pageIndex int = 0
			,@pageSize int = 5
			,@CreatedBy int = 90

EXECUTE dbo.Surveys_ByCreatedBy 
			@pageIndex
			,@pageSize
			,@CreatedBy

*/

    BEGIN
        DECLARE @offset INT= @pageIndex * @pageSize;
        SELECT [CreatedBy], 
               [Name], 
               [Description], 
               [StatusId], 
               [SurveyTypeId], 
               TotalCount = COUNT(1) OVER()
        FROM dbo.Surveys
        WHERE @CreatedBy = CreatedBy
        ORDER BY Surveys.Id
        OFFSET @offset ROWS FETCH NEXT @pageSize ROWS ONLY;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Surveys_DeleteById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Surveys_DeleteById]

		@Id int

as

/*

	DECLARE @Id int

	SELECT *
	FROM dbo.Surveys
	WHERE Id = @Id

	EXECUTE dbo.Users_DeleteById @Id

	SELECT *
	FROM dbo.Surveys
	WHERE Id = @Id
*/

BEGIN

		DELETE FROM dbo.Surveys

		WHERE Id = @Id

END


GO
/****** Object:  StoredProcedure [dbo].[Surveys_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Surveys_Insert]
			@Id           INT OUTPUT,
			@CreatedBy INT,
			@Name         NVARCHAR(100), 
			@Description  NVARCHAR(2000), 
			@StatusId     INT, 
			@SurveyTypeId INT


/* --------Test Code----------

	DECLARE @Id int = 0

	DECLARE 
			
			@Name nvarchar(100) = 'LA Pathway's Survey'
			,@CreatedBy INT = 2
			,@Description nvarchar(2000) = 'Users are taken through an initial assessment that allows small business owners and entrepreneurs the opportunity to seek services and resource information to help grow their business.'
			,@StatusId int = 2
			,@SurveyTypeId int = 2

	Execute dbo.Surveys_Insert
			@Id OUTPUT		
			,@CreatedBy
			,@Name
			,@Description
			,@StatusId
			,@SurveyTypeId


	Select *
	From dbo.Surveys
	WHERE Id = @Id

*/

AS
    BEGIN
        INSERT INTO [dbo].[Surveys]
        ([Name], 
		[CreatedBy],
         [Description], 
         [StatusId], 
         [SurveyTypeId]
        )
        VALUES
        (@Name, 
		@CreatedBy,
         @Description, 
         @StatusId, 
         @SurveyTypeId
        );
        SET @Id = SCOPE_IDENTITY();
    END;
GO
/****** Object:  StoredProcedure [dbo].[Surveys_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Surveys_SelectAll] @pageIndex INT, 
                                     @pageSize  INT
AS

/* 

DECLARE		@pageIndex int = 0
			,@pageSize int = 5

EXECUTE dbo.Surveys_SelectAll

			@pageIndex,
			@pageSize
*/

    BEGIN
        DECLARE @offset INT= @pageIndex * @pageSize;
        SELECT S.[Id], 
               S.[Name], 
               S.[Description], 
               S.[StatusId], 
               S.[SurveyTypeId],
               S.[CreatedBy], 
               S.[DateCreated], 
               S.[DateModified], 
               TotalCount = COUNT(1) OVER()
        FROM dbo.Surveys as S
        ORDER BY S.Id
        OFFSET @offset ROWS FETCH NEXT @pageSize ROWS ONLY;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Surveys_SelectAll_Users]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Surveys_SelectAll_Users] @pageIndex INT, 
                                           @pageSize  INT
AS

/* 

DECLARE		@pageIndex int = 0
			,@pageSize int = 5

EXECUTE dbo.[Surveys_SelectAll_Users]

			@pageIndex,
			@pageSize
*/

    BEGIN
        DECLARE @offset INT= @pageIndex * @pageSize;
        SELECT S.[Id], 
               S.[Name], 
               S.[Description], 
               S.[StatusId], 
               SS.[Name] AS StatusName, 
               S.[SurveyTypeId], 
               ST.[Name] AS SurveyTypeName,
			   S.CreatedBy,
               UP.[FirstName] as FirstName,
			   UP.[LastName] as LastName, 
               S.[DateCreated], 
               S.[DateModified], 
               TotalCount = COUNT(1) OVER()
        FROM dbo.Surveys AS S 
             JOIN dbo.UserProfiles AS UP ON S.CreatedBy = UP.UserId
             JOIN dbo.SurveyTypes AS ST ON ST.Id = S.SurveyTypeId
             JOIN dbo.SurveyStatus AS SS ON SS.Id = S.StatusId
        ORDER BY S.Id
        OFFSET @offset ROWS FETCH NEXT @pageSize ROWS ONLY;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Surveys_SelectAllDetails]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Surveys_SelectAllDetails] @pageIndex INT, 
                                        @pageSize  INT
AS

/* ------------ TEST CODE -----------

DECLARE @pageIndex int = 0,
		@pageSize int = 10

EXECUTE dbo.Surveys_SelectAllDetails @pageIndex
									,@pageSize

*/

    BEGIN
        DECLARE @offset INT= @pageIndex * @pageSize;
        SELECT S.[Id], 
               S.[Name], 
               S.[Description], 
               S.[StatusId], 
               S.[SurveyTypeId], 
               S.[CreatedBy], 
               S.[DateCreated], 
               S.[DateModified], 
        (
            SELECT SS.Id as SurveysSectionsId,
				   SS.Title as Title,
				   SS.SortOrder as SortOrder,
                   SQ.Question as Question,
                   SQ.HelpText as HelpText,
				   SQ.IsRequired as IsRequired,
				   SQ.QuestionTypeId as QuestionTypeId,
                   PossibleAnswers.QuestionId as QuestionId, 
                   PossibleAnswers.[Text] as [Text], 
                   PossibleAnswers.[Value] as [Value],
				   PossibleAnswers.AdditionalInfo as AdditionalInfo
            FROM dbo.SurveySections AS SS
                 JOIN dbo.SurveyQuestions AS SQ ON SS.Id = SQ.SectionId
                 JOIN dbo.SurveyQuestionAnswerOptions AS PossibleAnswers ON PossibleAnswers.QuestionId = SQ.Id
            WHERE SS.SurveyId = S.Id FOR JSON AUTO
        ) AS Results
        FROM [dbo].[Surveys] AS S
        ORDER BY S.Id
        OFFSET @offset ROWS FETCH NEXT @pageSize ROWS ONLY;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Surveys_SelectById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Surveys_SelectById] @Id INT
AS

/*

DECLARE @Id int = 3

EXECUTE dbo.Surveys_SelectById @Id

*/

    BEGIN
          SELECT S.[Id], 
               S.[Name], 
               S.[Description], 
               S.[StatusId], 
               SS.[Name] AS StatusName, 
               S.[SurveyTypeId], 
               ST.[Name] AS SurveyTypeName,
               UP.[FirstName] as FirstName,
			   UP.[LastName] as LastName, 
               S.[DateCreated], 
               S.[DateModified]
        FROM [dbo].[Surveys] as S
		             JOIN dbo.UserProfiles AS UP ON S.CreatedBy = UP.UserId
             JOIN dbo.SurveyTypes AS ST ON ST.Id = S.SurveyTypeId
             JOIN dbo.SurveyStatus AS SS ON SS.Id = S.StatusId
        WHERE S.Id = @Id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Surveys_SelectById_WithUsers]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Surveys_SelectById_WithUsers] @Id int
AS

/* 

DECLARE		@Id int = 2

EXECUTE dbo.[Surveys_SelectById_WithUsers] @Id
*/

    BEGIN
        SELECT S.[Id], 
               S.[Name], 
               S.[Description], 
               S.[StatusId], 
               SS.[Name] AS StatusName, 
               S.[SurveyTypeId], 
               ST.[Name] AS SurveyTypeName,
			   S.CreatedBy,
               UP.[FirstName] as FirstName,
			   UP.[LastName] as LastName, 
               S.[DateCreated], 
               S.[DateModified], 
               TotalCount = COUNT(1) OVER()
        FROM dbo.Surveys AS S 
             JOIN dbo.UserProfiles AS UP ON S.CreatedBy = UP.UserId
             JOIN dbo.SurveyTypes AS ST ON ST.Id = S.SurveyTypeId
             JOIN dbo.SurveyStatus AS SS ON SS.Id = S.StatusId
		WHERE S.Id = @Id
    END;
GO
/****** Object:  StoredProcedure [dbo].[Surveys_SelectDetails_byId]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Surveys_SelectDetails_byId] @Id INT
AS

/*

DECLARE @Id INT = 4
EXECUTE dbo.Surveys_SelectDetails_byId @Id

*/

    BEGIN
        SELECT S.[Id], 

        (
            SELECT SS.Id as SurveysSectionsId,
				   SS.Title as Title,
				   SS.SortOrder as SortOrder,
				   Questions.Id as QuestionId,
                   Questions.Question as Question,
                   Questions.HelpText as HelpText,
				   Questions.IsRequired as IsRequired,
				   Questions.QuestionTypeId as QuestionTypeId,
                   AnswerOptions.Id as AnswerOptionId,
                   AnswerOptions.[Text] as [Text], 
                   AnswerOptions.[Value] as [Value]
				   --AnswerOptions.AdditionalInfo as AdditionalInfo
            FROM dbo.SurveySections as SS
                 JOIN dbo.SurveyQuestions AS Questions ON SS.Id = Questions.SectionId
                 JOIN dbo.SurveyQuestionAnswerOptions AS AnswerOptions ON AnswerOptions.QuestionId = Questions.Id
            WHERE SS.SurveyId = S.Id 
			order by SS.Id
			FOR JSON AUTO
        ) AS Results
        FROM [dbo].[Surveys] AS S
        WHERE S.Id = @Id
    END;

GO
/****** Object:  StoredProcedure [dbo].[Surveys_SelectDetails_byId_V2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Surveys_SelectDetails_byId_V2] @Id INT
AS

/*

DECLARE @Id INT = 98
EXECUTE dbo.Surveys_SelectDetails_byId_V2 @Id

*/

    BEGIN
        SELECT S.[Id], 
               S.[Name], 
               S.[Description], 
               S.[StatusId], 
               SS.[Name] AS StatusName, 
               S.[SurveyTypeId], 
               ST.[Name] AS SurveyTypeName,
			   S.CreatedBy,
               UP.[FirstName] as FirstName,
			   UP.[LastName] as LastName, 
               S.[DateCreated], 
               S.[DateModified], 

        (Select	  Questions.Id as QuestionId,
				  Questions.Question as Question

				From dbo.SurveySections As Ss 
				JOIN Surveys as S 
					on S.Id=Ss.[SurveyId] AND S.Id = @Id
				JOIN dbo.SurveyQuestions as Questions  
					on Ss.Id=Questions.SectionId
				FOR JSON AUTO ) AS QuestionsAnswers
        FROM [dbo].[Surveys] AS S
             JOIN dbo.UserProfiles AS UP ON S.CreatedBy = UP.UserId
             JOIN dbo.SurveyTypes AS ST ON ST.Id = S.SurveyTypeId
             JOIN dbo.SurveyStatus AS SS ON SS.Id = S.StatusId
        WHERE S.Id = @Id;
    END;

GO
/****** Object:  StoredProcedure [dbo].[Surveys_Update]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[Surveys_Update]
		@CreatedBy int
		,@Name nvarchar(100)
		,@Description nvarchar(2000)
		,@StatusId int
		,@SurveyTypeId int
		,@Id int

as

/* ---------------Test Code ----------------


	DECLARE @Id int = 5;

	DECLARE @CreatedBy int = 90
		,@Name nvarchar(100) = 'George'
		,@Description nvarchar(2000) = 'Harrison'
		,@StatusId int = 45
		,@SurveyTypeId int = 35

	Execute dbo.Surveys_Update
						@CreatedBy
						,@Name
						,@Description
						,@StatusId
						,@SurveyTypeId
						,@Id

	Select *
	From dbo.Surveys
	WHERE Id = @Id

*/

BEGIN 

	DECLARE @DatNow datetime2(7) = GETUTCDATE()

UPDATE dbo.Surveys
	SET [DateModified] = @DatNow
		,[CreatedBy] = @CreatedBy
		,[Name] = @Name
		,[Description] = @Description
		,[StatusId] = @StatusId
		,[SurveyTypeId] = @SurveyTypeId

	WHERE Id = @Id

END
GO
/****** Object:  StoredProcedure [dbo].[SurveySections_DeleteById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SurveySections_DeleteById]
		@Id int

as
/*
DECLARE @Id int = 1

SELECT * 
FROM dbo.SurveySections
WHERE Id = @Id

EXECUTE dbo.SurveySections_DeleteById
		@Id

SELECT *
From dbo.SurveySections
Where Id = @Id
*/
BEGIN
DELETE FROM [dbo].[SurveySections]
      WHERE Id = @Id
END


GO
/****** Object:  StoredProcedure [dbo].[SurveySections_GetAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SurveySections_GetAll]

AS

/*

Execute dbo.SurveySections_GetAll

*/

BEGIN

SELECT [Id]
      ,[SurveyId]
      ,[Title]
      ,[Description]
      ,[SortOrder]
      ,[DateCreated]
      ,[DateModified]

  FROM [dbo].[SurveySections]

END

GO
/****** Object:  StoredProcedure [dbo].[SurveySections_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SurveySections_Insert]
		@Id int OUT,
		@SurveyId int,
		@Title nvarchar(100),
		@Description nvarchar(2000),
		@SortOrder int

AS
/*
DECLARE 
		@Id int = 0,
		@SurveyId int = 0,
		@Title nvarchar(100) = '',
		@Description nvarchar(2000) = '',
		@SortOrder int = 1


Execute dbo.SurveySections_Insert
		@Id OUT,
		@SurveyId,
		@Title,
		@Description,
		@SortOrder


SELECT *
FROM dbo.SurveySections
WHERE Id = @id
*/

BEGIN
INSERT INTO [dbo].[SurveySections]
           ([SurveyId]
           ,[Title]
           ,[Description]
           ,[SortOrder])
     VALUES
           (
		     @SurveyId
			,@Title
            ,@Description
            ,@SortOrder)
		SET @Id = SCOPE_IDENTITY()
END


GO
/****** Object:  StoredProcedure [dbo].[SurveySections_MultipleInsert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SurveySections_MultipleInsert] @Id             INT OUT, 
                                                  @SurveyId       INT, 
                                                  @SurveySections AS SURVEYSECTIONSTYPEV2 READONLY
AS

/*

DECLARE 
		@Id int = 0,
		@SurveyId int = 3,
		@SurveySections AS SurveySectionsTypeV2

INSERT INTO @SurveySections 

Execute dbo.SurveySections_MultipleInsert
		@Id OUT,
		@SurveyId,
		@Title,
		@Description,
		@SortOrder


SELECT *
FROM dbo.SurveySections
WHERE Id = @id

*/

    BEGIN
	DECLARE @Date datetime2(7) = GETUTCDATE()
        INSERT INTO [dbo].[SurveySections]
        ([SurveyId], 
         [Title], 
         [Description], 
         [SortOrder],
		 [DateCreated],
		 [DateModified],
		 [TempId]
        )
               SELECT @SurveyId, 
                      [Title], 
                      [Description], 
                      [SortOrder],
					  @Date,
					  @Date,
					  [TempId]
               FROM @SurveySections;

	SELECT TempId, Id
	from dbo.SurveySections
	where SurveyId = @SurveyId
    END;
GO
/****** Object:  StoredProcedure [dbo].[SurveySections_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SurveySections_SelectAll]
		@PageIndex int
		,@PageSize int 
as
/*
DECLARE @PageIndex int = 0
		,@PageSize int = 20
EXECUTE dbo.SurveySections_SelectAll
		@PageIndex
		,@PageSize
*/
BEGIN
DECLARE @offset int = @PageIndex * @PageSize;
SELECT [Id]
      ,[SurveyId]
      ,[Title]
      ,[Description]
      ,[SortOrder]
      ,[DateCreated]
      ,[DateModified]
	  ,TotalCount = COUNT (1) OVER()
  FROM [dbo].[SurveySections]
  
  ORDER BY SurveySections.Id desc
  OFFSET @offset ROWS 
  FETCH NEXT @pageSize ROWS ONLY


END


GO
/****** Object:  StoredProcedure [dbo].[SurveySections_SelectById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SurveySections_SelectById]
		@Id int
as
/*
DECLARE @Id int = 10

Execute dbo.SurveySections_SelectById
		@Id

*/
BEGIN

SELECT [Id]
      ,[SurveyId]
      ,[Title]
      ,[Description]
      ,[SortOrder]
      ,[DateCreated]
      ,[DateModified]
  FROM [dbo].[SurveySections]
  Where Id = @Id
END


GO
/****** Object:  StoredProcedure [dbo].[SurveySections_Update]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SurveySections_Update]
		@Id int
		,@SurveyId int
		,@Title nvarchar(100)
		,@Description nvarchar(2000)
		,@SortOrder int


as

/*
	DECLARE
		@Id int = 10
		,@SurveyId int = 1
		,@Title nvarchar(100) = 'Title'
		,@Description nvarchar(2000) = 'Hello there this would be an extremely long description'
		,@SortOrder int = 1

SELECT *
FROM dbo.SurveySections
Where Id = @Id

Execute dbo.SurveySections_Update
		@Id
		,@SurveyId
		,@Title
		,@Description
		,@SortOrder

SELECT *
FROM dbo.SurveySections
Where Id = @Id


*/
BEGIN

DECLARE @DateModified datetime2(7) = GETUTCDATE();

UPDATE [dbo].[SurveySections]

   SET [SurveyId] = @SurveyId
      ,[Title] = @Title
      ,[Description] = @Description
      ,[SortOrder]  = @SortOrder
	  ,[DateModified] = @DateModified

 WHERE Id = @Id

end


GO
/****** Object:  StoredProcedure [dbo].[SurveysInstances_Delete_ById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[SurveysInstances_Delete_ById]
			@Id int
AS

/*			TEST CODE

	DECLARE 
			@Id int = 7;

	EXECUTE dbo.SurveysInstances_Delete_ById 
			@Id

*/


BEGIN
		DELETE 
		FROM [dbo].[SurveysInstances]
		WHERE Id = @Id
END


GO
/****** Object:  StoredProcedure [dbo].[SurveysInstances_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SurveysInstances_Insert]

			@Id int OUTPUT
			,@SurveyId int
			,@UserId int
			
AS

/*			TEST CODE

	DECLARE  @Id int
			,@SurveyId int = 12345
			,@UserId int = 12345

	EXECUTE dbo.SurveysInstances_Insert 

			@Id
			,@SurveyId
			,@UserId

	SELECT *
	FROM dbo.SurveysInstances
*/

BEGIN

	INSERT INTO  [dbo].[SurveysInstances]
				([SurveyId]
				,[UserId])
	VALUES
				(@SurveyId
				,@UserId)

		SET @Id = SCOPE_IDENTITY()

END
GO
/****** Object:  StoredProcedure [dbo].[SurveysInstances_Insert_V2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SurveysInstances_Insert_V2]
@Id INT OUTPUT,
@SurveyId INT,
@UserId INT,
			@InstanceId int,
			@QuestionId int, 
		    @AnswersList as [dbo].[AnswersListType] READONLY


AS


/*
DECLARE @Id INT OUTPUT,
@SurveyId INT =27,
@UserId INT =2

EXECUTE dbo.SurveysInstances_Insert_V2
@Id INT OUTPUT,
@SurveyId INT,
@UserId INT

DECLARE 
			@InstanceId int = 5,
			@QuestionId int = 27,
			@AnswersList as AnswersListType

INSERT INTO @AnswersList (AnswerOptionId) values (24) 
INSERT INTO @AnswersList (AnswerOptionId) values (30) 

EXECUTE [dbo].SurveyAnswers_Insert_Multiple 
			@InstanceId,
			@QuestionId,
			@AnswersList

*/
DECLARE @QuestionIdTable TABLE (QuestionId INT, AnswerOptionId INT)

BEGIN

INSERT INTO [dbo].[SurveysInstances]
           ([SurveyId]
           ,[UserId])
     VALUES
           (@SurveyId,
		   @UserId)

		   SET @Id = SCOPE_IDENTITY()

EXECUTE [dbo].SurveyAnswers_Insert_Multiple 
			@Id,
			@QuestionId,
			@AnswersList

			
					--select from specific survey and insert answer at that instance Id (should be receievedd and passed), questionId (get the ID and insert at it), and answeroptionId (get the Id and insert at it)
						SELECT SQ.Id as QuestionId
						from Surveys AS S
							JOIN SurveySections AS SS ON SS.SurveyId = S.Id
							JOIN SurveyQuestions AS SQ ON SQ.SectionId = SS.Id
						WHERE s.Id = 50

								--SQAO.Id
							--JOIN SurveyQuestionAnswerOptions AS SQAO ON SQAO.QuestionId = SQ.Id

							--SA.AnswerOptionId
						--JOIN SurveyAnswers AS SA ON SQ.Id = SA.QuestionId


END


GO
/****** Object:  StoredProcedure [dbo].[SurveysInstances_Search]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SurveysInstances_Search] @start     NVARCHAR(100), 
                                           @end       NVARCHAR(100), 
                                           @pageIndex INT, 
                                           @pageSize  INT
AS
    BEGIN

/*
		Execute dbo.SurveysInstances_Search @start = "2019-10-22", 
			   @end = "2019-12-05", @pageIndex = 0, @pageSize = 6


			   	SELECT * FROM dbo.SurveysInstances
*/

        DECLARE @offset INT= @pageIndex * @pageSize;
        SELECT I.[Id], 
               I.SurveyId, 
               S.[Name], 
               I.[DateCreated], 
               I.[DateModified], 
               TotalCount = COUNT(1) OVER()
        FROM [dbo].[SurveysInstances] AS I
             JOIN [dbo].[Surveys] AS S ON S.Id = I.SurveyId
        WHERE I.DateCreated BETWEEN @start AND @end
        ORDER BY I.Id
        OFFSET @offSet ROWS FETCH NEXT @pageSize ROWS ONLY;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SurveysInstances_Select_ById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SurveysInstances_Select_ById]
			@Id int
as

/*			TEST CODE


		--Use this to take a peek into the table -- > SELECT * FROM [dbo].[SurveysInstances]

			--Then use the code below for select by Id 

				DECLARE @Id int = 6;
						
				EXECUTE dbo.SurveysInstances_Select_ById
						@Id;
*/

BEGIN

		SELECT
			 [Id]
			,[SurveyId]
			,[UserId]
			,[DateCreated]
			,[DateModified]

		FROM [dbo].[SurveysInstances]
		WHERE Id = @Id
END


GO
/****** Object:  StoredProcedure [dbo].[SurveysInstances_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[SurveysInstances_SelectAll]
				@pageIndex int
                ,@pageSize int
AS

BEGIN

/*
		Execute dbo.SurveysInstances_SelectAll @pageIndex = 0, @pageSize = 50
*/

   Declare @offset int = @pageIndex * @pageSize

        SELECT		
				I.[Id]
			   ,I.SurveyId
			   ,S.[Name]
			   ,I.[DateCreated]
			   ,I.[DateModified]
			   ,TotalCount = COUNT(1) OVER() 

        FROM	[dbo].[SurveysInstances] AS I
		JOIN	[dbo].[Surveys] AS S
				ON S.Id = I.SurveyId

        ORDER BY I.Id DESC

		OFFSET @offSet ROWS FETCH NEXT @pageSize ROWS ONLY

	END
GO
/****** Object:  StoredProcedure [dbo].[SurveysInstances_SelectAll_WithDetails]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[SurveysInstances_SelectAll_WithDetails]
              
as
BEGIN
/*

DECLARE @Id int = 22;
Exec dbo.SurveysInstances_SelectDetails_ById @Id

*/
				
SELECT Si.[Id]
	  ,Si.[UserId]
	  ,Si.[DateCreated]
	  ,Si.[DateModified]
	  ,S.Id as SurveyId
	  ,S.[Name] as SurveyName
	  ,S.[Description] as SurveyDescription
	  ,S.[CreatedBy]
	  ,Sst.[Name] as SurveyStatus
	  ,St.[Name] as SurveyType
	  ,(Select	  Questions.SectionId ,
				  Questions.Id as QuestionId,
				  Questions.Question as Question,
				  Questions.HelpText as HelpText,
				  Answers.Id as AnswerId,
				  AnswerValues.Text as AnswerText,
				  AnswerValues.Value as AnswerValue

				From dbo.SurveySections As Ss 
				JOIN Surveys as S 
					on S.Id=Ss.[SurveyId] AND Ss.SurveyId =S.Id
				JOIN dbo.SurveyQuestions as Questions  
					on Ss.Id=Questions.SectionId
				JOIN dbo.SurveyAnswers as Answers 
					on Answers.QuestionId= Questions.Id AND Answers.InstanceId = Si.Id
				JOIN dbo.SurveyQuestionAnswerOptions as AnswerValues
					on Answers.AnswerOptionId = AnswerValues.Id
				FOR JSON AUTO ) AS QuestionsAnswers

         FROM [dbo].[SurveysInstances] as Si 
		 Join dbo.Surveys as S 
			on Si.SurveyId =S.Id 
		 Join dbo.SurveyStatus as Sst
			on Sst.Id =S.StatusId
		 Join dbo.SurveyTypes as St 
			on St.Id= S.SurveyTypeId
		 

END


GO
/****** Object:  StoredProcedure [dbo].[SurveysInstances_SelectDetails]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SurveysInstances_SelectDetails] @PageIndex INT, 
                                                  @PageSize  INT
AS

/*
DECLARE @_pageIndex int = 0,
		@_pageSize int = 5

EXECUTE [dbo].[SurveysInstances_SelectDetails]
		@_pageIndex,
		@_pageSize
*/

    BEGIN
        DECLARE @Offset INT= @PageIndex * @PageSize;
        SELECT SI.[Id], 
               SI.[UserId], 
               SI.[DateCreated], 
               SI.[DateModified], 
               S.Id AS SurveyId, 
               S.[Name] AS SurveyName, 
               S.[Description] AS SurveyDescription, 
               S.[CreatedBy], 
               SST.[Name] AS SurveyStatus, 
               ST.[Name] AS SurveyType, 
        (
            SELECT Questions.SectionId, 
                   Questions.Id AS QuestionId, 
                   Questions.Question AS Question, 
                   Questions.HelpText AS HelpText, 
                   Answers.Id AS AnswerId, 
                   AnswerValues.Text AS AnswerText, 
                   AnswerValues.Value AS AnswerValue
            FROM dbo.SurveySections AS Ss
                 JOIN Surveys AS S ON S.Id = Ss.[SurveyId]
                                      AND Ss.SurveyId = S.Id
                 JOIN dbo.SurveyQuestions AS Questions ON Ss.Id = Questions.SectionId
                 JOIN dbo.SurveyAnswers AS Answers ON Answers.QuestionId = Questions.Id
                 JOIN dbo.SurveyQuestionAnswerOptions AS AnswerValues ON Answers.AnswerOptionId = AnswerValues.Id FOR JSON AUTO
        ) AS QuestionsAnswers
        FROM [dbo].[SurveysInstances] AS Si
             JOIN dbo.Surveys AS S ON Si.SurveyId = S.Id
             JOIN dbo.SurveyStatus AS Sst ON Sst.Id = S.StatusId
             JOIN dbo.SurveyTypes AS St ON St.Id = S.SurveyTypeId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SurveysInstances_SelectDetails_ById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[SurveysInstances_SelectDetails_ById]
 @Id int
              
as
BEGIN
/*

DECLARE @Id int =19;
Exec dbo.SurveysInstances_SelectDetails_ById @Id

*/
				
SELECT Si.[Id]
	  --,Si.[UserId]
	  ,Si.[DateCreated]
	  ,Si.[DateModified]
	  ,S.Id as SurveyId
	  ,S.[Name] as SurveyName
	  ,S.[Description] as SurveyDescription
	  ,S.[CreatedBy]
	  ,Sst.[Name] as SurveyStatus
	  ,St.[Name] as SurveyType
	  ,(Select	  Questions.SectionId ,
				  Questions.Id as QuestionId,
				  Questions.Question as Question,
				  Questions.HelpText as HelpText,
				  Answers.Id as AnswerId,
				  AnswerValues.Text as AnswerText,
				  AnswerValues.Value as AnswerValue

				From dbo.SurveySections As Ss 
				JOIN Surveys as S 
					on S.Id=Ss.[SurveyId] AND Ss.SurveyId =S.Id
				JOIN dbo.SurveyQuestions as Questions  
					on Ss.Id=Questions.SectionId
				JOIN dbo.SurveyAnswers as Answers 
					on Answers.QuestionId= Questions.Id AND Answers.InstanceId = @Id
				JOIN dbo.SurveyQuestionAnswerOptions as AnswerValues
					on Answers.AnswerOptionId = AnswerValues.Id
				FOR JSON AUTO ) AS QuestionsAnswers

         FROM [dbo].[SurveysInstances] as Si 
		 Join dbo.Surveys as S 
			on Si.SurveyId =S.Id 
		 Join dbo.SurveyStatus as Sst
			on Sst.Id =S.StatusId
		 Join dbo.SurveyTypes as St 
			on St.Id= S.SurveyTypeId
		 
        Where Si.Id=@Id

END


GO
/****** Object:  StoredProcedure [dbo].[SurveysInstances_Update]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SurveysInstances_Update]
			@Id int
			,@SurveyId int
			,@UserId int
AS

/*			TEST CODE

	DECLARE	
			@Id int = 10
			,@SurveyId int = 980
			,@UserId int = 980

	SELECT * FROM [dbo].[SurveysInstances]

	EXECUTE dbo.SurveysInstances_Update

			@Id
			,@SurveyId
			,@UserId

	SELECT * FROM [dbo].[SurveysInstances]

*/

BEGIN

	DECLARE @DateModified datetime2(7) = GETUTCDATE()

	UPDATE
			dbo.SurveysInstances	
	SET
			[SurveyId] = @SurveyId 
			,[UserId] = @UserId 

	WHERE 
			Id = @Id
END


GO
/****** Object:  StoredProcedure [dbo].[SurveyStatus_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SurveyStatus_SelectAll]
AS
    BEGIN

/*
	EXECUTE dbo.SurveyStatus_SelectAll
*/

        SELECT [Id], 
               [Name]
        FROM [dbo].[SurveyStatus]
        ORDER BY Id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SurveyStatus_SurveyTypes_Select]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SurveyStatus_SurveyTypes_Select]
AS
    BEGIN

/*
	EXECUTE [dbo].[SurveyStatus_SurveyTypes_Select]
*/

        EXECUTE dbo.SurveyTypes_SelectAll;
        EXECUTE dbo.SurveyStatus_SelectAll;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SurveyStatus_SurveyTypes_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SurveyStatus_SurveyTypes_SelectAll]
AS
    BEGIN

/*
	EXECUTE SurveyStatus_SurveyTypes_SelectAll
*/

        SELECT SS.[Id] as SurveyStatusId, 
               SS.[Name] as SurveyStatusName,
			   ST.[Id] as SurveyTypeId,
			   ST.[Name] as SurveyTypeName
        FROM [dbo].[SurveyStatus] as SS
			JOIN dbo.SurveyTypes as ST on SS.Id = ST.Id
    END
GO
/****** Object:  StoredProcedure [dbo].[SurveyTypes_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[SurveyTypes_SelectAll]

AS
/*

		EXEC dbo.SurveyTypes_SelectAll

*/
BEGIN
		SELECT
				[Id],
				[Name]

		FROM [dbo].[SurveyTypes]
		ORDER BY Id  
		
				

END
GO
/****** Object:  StoredProcedure [dbo].[TokenTypes_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[TokenTypes_SelectAll]
			@pageIndex int = 0,
			@pageSize int = 10
as
/*
		DECLARE 
				@pageIndex int = 0
				,@pageSize int = 10

		DECLARE @offset int = @pageIndex * @pageSize

		SELECT 
				[Id]
				,[Name]
				,TotalCount = count(1) over()
	

		FROM dbo.TokenTypes

		ORDER BY TokenTypes.Id
		
		OFFSET @offset ROWS
		
		Fetch Next @pageSize Rows ONLY
		
		EXEC dbo.TokenTypes_SelectAll;

*/

BEGIN
		DECLARE @offset int = @pageIndex * @pageSize

		SELECT [Id]
			  ,[Name]
			  ,totalCount = Count(1) Over()

		  FROM [dbo].[TokenTypes]
		  ORDER BY dbo.TokenTypes.Id
		  OFFSET @offset ROWS
		  Fetch Next @pageSize Rows ONLY

END


GO
/****** Object:  StoredProcedure [dbo].[UrlFileTypes_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UrlFileTypes_Insert]
@Url NVARCHAR(MAX),
@FileTypeId INT

as

/*
DECLARE @Url NVARCHAR(MAX) = 'https://bit.ly/2N9880T',
		@FileTypeId INT = 2

EXECUTE dbo.UrlFileTypes_Insert
		@Url,
		@FileTypeId		

*/

BEGIN

INSERT INTO [dbo].[UrlFileTypes]
           ([Url]
           ,[FileTypeId])
     VALUES
           (@Url
           ,@FileTypeId)
END


GO
/****** Object:  StoredProcedure [dbo].[UrlFileTypes_Insert_Multiple]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UrlFileTypes_Insert_Multiple]
@UrlFileTypeList as UrlFileTypeListType READONLY,
	@CreatedBy int
AS

/*

DECLARE @urlFileTypeList as UrlFileTypeListType,
		@CreatedBy int = 4

INSERT INTO @urlFileTypeList(Url, FileTypeId) values ('https://bit.ly/2N9880T', 3)

EXECUTE dbo.UrlFileTypes_Insert_Multiple @urlFileTypeList, @CreatedBy
SELECT * FROM [Files]

*/

BEGIN
INSERT INTO [dbo].[Files]
		([Url],
		[FileTypeId],
		[CreatedBy])
SELECT [Url],[FileTypeId],@CreatedBy FROM @UrlFileTypeList

END
GO
/****** Object:  StoredProcedure [dbo].[UserProfiles_DeleteById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UserProfiles_DeleteById]
										@Id int

AS

/*

SELECT *
FROM dbo.UserProfiles

DECLARE @Id int = 1

EXECUTE dbo.UserProfiles_DeleteById 
									@Id

SELECT *
FROM dbo.UserProfiles

*/

BEGIN

DELETE FROM dbo.UserProfiles
WHERE Id = @Id

END
GO
/****** Object:  StoredProcedure [dbo].[UserProfiles_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UserProfiles_Insert]
									@UserId int
									,@FirstName nvarchar(100)
									,@LastName nvarchar(100)
									,@Mi nvarchar(2)
									,@AvatarUrl varchar(255)
									,@Id int OUTPUT
									

AS

/*

		DECLARE @Id int = 0

		Declare	 
				@UserId int = 2
				,@FirstName nvarchar(100) = 'Jake'
				,@LastName nvarchar(100) = 'doe'
				,@Mi nvarchar(2) = 'A'
				,@AvatarUrl varchar(255) = 'https://bit.ly/2MT2azR'
	


		EXECUTE dbo.UserProfiles_Insert 
										@UserId
										,@FirstName
										,@LastName
										,@Mi
										,@AvatarUrl
										,@Id out
								
		SELECT @Id
		SELECT *
		FROM dbo.UserProfiles
		WHERE Id = @Id;

*/

BEGIN

		INSERT INTO [dbo].[UserProfiles]
				   ([UserId]
				   ,[FirstName]
				   ,[LastName]
				   ,[Mi]
				   ,[AvatarUrl])
			 VALUES
					(@UserId
					,@FirstName
					,@LastName
					,@Mi
					,@AvatarUrl)

		SET @Id = SCOPE_IDENTITY()

END


GO
/****** Object:  StoredProcedure [dbo].[UserProfiles_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC	[dbo].[UserProfiles_SelectAll]
										@pageIndex int
										,@pageSize int
AS

/*

		DECLARE 
				@pageIndex int = 0
				,@pageSize int = 5

		EXECUTE dbo.UserProfiles_SelectAll
											@pageIndex
											,@pageSize

*/

BEGIN

		DECLARE @offset int = @pageIndex * @pageSize

		SELECT
				[Id]
				,[UserId]
				,[FirstName]
				,[LastName]
				,[Mi]
				,[AvatarUrl]
				,[DateCreated]
				,[DateModified]
				,TotalCount = COUNT (1) OVER()

		FROM dbo.UserProfiles 

		ORDER BY UserProfiles.Id DESC

		OFFSET @offset ROWS
		FETCH NEXT @pageSize ROWS ONLY

END
GO
/****** Object:  StoredProcedure [dbo].[UserProfiles_SelectAllDetails]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[UserProfiles_SelectAllDetails]

			@pageIndex int
			,@pageSize int
AS 

/*	--The reason that the data doesnt matchup is because 
	--there is no matching UserProfiles.UserId w/ Users.Id

	DECLARE 
			@pageIndex int = 0
			,@pageSize int = 5

	EXECUTE dbo.UserProfiles_SelectAllDetails
			@pageIndex
			,@pageSize

*/
BEGIN
	DECLARE @offset int = @pageIndex * @pageSize

	SELECT 
			 U.[Email]
			,U.[Id]
			,UP.[UserId]
		  ,TotalCount = COUNT(1) OVER()

	FROM UserProfiles AS UP
	JOIN Users AS U ON UP.UserId = U.Id
	ORDER BY UP.UserId DESC

	OFFSET @offset ROWS 
	FETCH NEXT @pageSize ROWS ONLY

END
GO
/****** Object:  StoredProcedure [dbo].[UserProfiles_SelectById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UserProfiles_SelectById]
										@Id int
AS

/*


		DECLARE 
				@Id int = 3

		EXECUTE dbo.UserProfiles_SelectById 
											@Id

*/

BEGIN

		SELECT [Id]
			   ,[UserId]
			   ,[FirstName]
			   ,[LastName]
			   ,[Mi]
			   ,[AvatarUrl]
			   ,[DateCreated]
			   ,[DateModified]

		FROM dbo.UserProfiles
		WHERE Id = @Id

END
GO
/****** Object:  StoredProcedure [dbo].[UserProfiles_SelectByUserId_Verify]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[UserProfiles_SelectByUserId_Verify]
										@UserId int
AS

/*
		--for current user logged in to get his info

		DECLARE 
				@UserId int = 121

		EXECUTE dbo.UserProfiles_SelectByUserId_Verify
											@UserId

*/

BEGIN

		SELECT [Id]
			   ,[UserId]
			   ,[FirstName]
			   ,[LastName]
			   ,[Mi]
			   ,[AvatarUrl]
			   ,[DateCreated]
			   ,[DateModified]

		FROM dbo.UserProfiles
		WHERE UserId = @UserId

END
GO
/****** Object:  StoredProcedure [dbo].[UserProfiles_SelectDetails_ByUserId]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[UserProfiles_SelectDetails_ByUserId]
			@Id int
AS 


/*	--The reason that the data show anything is 
	--because there is no matching UserProfiles.UserId w/ Users.Id

	DECLARE @Id int = 1
	EXECUTE dbo.UserProfiles_SelectDetails_ByUserId
			@Id

*/
BEGIN

	SELECT 
		 U.[Email]
		,U.[Id]
		,UP.[UserId]
	FROM UserProfiles AS UP
	JOIN Users AS U ON UP.UserId = U.Id 

	WHERE UP.UserId = @Id

END
GO
/****** Object:  StoredProcedure [dbo].[UserProfiles_Update]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UserProfiles_Update]
									@Id int
									,@FirstName nvarchar(100)
									,@LastName nvarchar(100)
									,@Mi nvarchar(2)
									,@AvatarUrl varchar(255)


AS

/*

		DECLARE
				@Id int = 7
				,@FirstName nvarchar(100) = 'Jim'
				,@LastName nvarchar(100) = 'H'
				,@Mi nvarchar(2) = 'D'
				,@AvatarUrl varchar(255) = 'https://bit.ly/2MT2azR'

		EXECUTE dbo.UserProfiles_Update
										@Id
										,@FirstName
										,@LastName
										,@Mi
										,@AvatarUrl

		select *
		FROM dbo.UserProfiles

*/

BEGIN

		DECLARE @DateModified datetime2(7) = GETUTCDATE()

		UPDATE dbo.UserProfiles

		SET 
			[FirstName] = @FirstName
			,[LastName] = @LastName
			,[Mi] = @Mi
			,[AvatarUrl] = @AvatarUrl
			,[DateModified] = @DateModified

		WHERE Id = @Id

END
GO
/****** Object:  StoredProcedure [dbo].[UserRoles_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[UserRoles_Insert]
			@UserId int 
			,@RoleId int

AS

/* Declare 
		@UserId int = 1,
		@RoleId int = 1

Execute dbo.UserRole_Insert
		@UserId OUT,
		@RoleId

*/

BEGIN

INSERT INTO [dbo].[UserRoles]
           ([UserId],
		   [RoleId])
     VALUES
           (@UserId,
		   @RoleId)
	--SET @UserId = SCOPE_IDENTITY()
END


GO
/****** Object:  StoredProcedure [dbo].[UserRoles_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[UserRoles_SelectAll] @pageIndex INT = 0,
									@pageSize INT = 10

As

/*----------------TEST CODE------------------

Declare @pageIndex int = 0
		,@pageSize int = 5

Execute dbo.UserRoles_SelectAll

		@pageIndex
		,@pageSize

*/

	Begin
		Declare @offset INT = @pageIndex * @pageSize;
		SELECT  [UserId],
				[RoleId],
				TOTALCOUNT = COUNT(1) OVER()
  FROM [dbo].[UserRoles]
  Order by UserRoles.UserId
  OFFSET @offset ROWS FETCH NEXT @pageSize ROWS ONLY;

END


GO
/****** Object:  StoredProcedure [dbo].[Users_ComfirmedUpdater]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Users_ComfirmedUpdater]
	@Guid nvarchar(200)

AS
BEGIN
/*

DECLARE @Guid nvarchar(200) = 'FD470D27-D976-40A1-A06F-D2A53B516787'
		
Exec dbo.Users_ComfirmedUpdater @Guid

*/
DECLARE @UserId int;

	SET @UserId = ( SELECT 
			UserId
	FROM dbo.UserTokens 
	WHERE Token = @Guid )

IF @UserId > 0		
	UPDATE dbo.Users
		SET 
			[IsConfirmed] = 1
            ,[UserStatusId] = 1
		WHERE Id = @UserId

	DELETE FROM dbo.UserTokens
		WHERE Token = @Guid
END
GO
/****** Object:  StoredProcedure [dbo].[Users_Confirm]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Users_Confirm] @Id          INT, 
                                 @IsConfirmed BIT
AS

/* ------------ TEST CODE ---------------

DECLARE 
		@Id int = 2
		,@IsConfirmed  BIT = 'True'

SELECT *
FROM dbo.Users
WHERE Id = @Id

EXECUTE dbo.Users_Confirm 
						@Id 
						,@IsConfirmed

SELECT *
FROM dbo.Users
WHERE Id = @Id

*/

    BEGIN
        UPDATE dbo.Users
          SET 
              [IsConfirmed] = @IsConfirmed
        WHERE Id = @Id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Users_DeleteById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Users_DeleteById] 
									@Id int 

AS

/* --------------TEST CODE -------------

    DECLARE 
			@Id int = 6

    SELECT *
    FROM dbo.Users
    WHERE Id = @Id

    EXECUTE dbo.Users_DeleteById 
								  @Id

    SELECT *
    FROM dbo.Users
    WHERE Id = @Id

*/

BEGIN   
        DELETE FROM [dbo].[Users]
        WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[Users_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Users_Insert] @Id           INT OUTPUT, 
                                @Email        NVARCHAR(100), 
                                @Password     NVARCHAR(100), 
                                @RoleId       INT,
								@IsConfirmed  bit
AS

/* ------------- TEST CODE ---------------

		DECLARE 
				@Id	int

		DECLARE 
				@Email				nvarchar(100) = 'cornflakes@email.com'
				,@Password			nvarchar(100) = 'Password!1'
				,@RoleId			int = 2

		EXECUTE dbo.Users_Insert 

								@Id OUTPUT
								,@Email
								,@Password
								,@RoleId

*/

     SET XACT_ABORT ON;
     DECLARE @Tran NVARCHAR(50)= 'USER';
    BEGIN TRY
        BEGIN TRANSACTION @Tran;
        INSERT INTO [dbo].[Users]
        ([Email], 
         [Password], 
         [RoleId],
		 [IsConfirmed]
        )
        VALUES
        (@Email, 
         @Password, 
         @RoleId,
		 @IsConfirmed
        );
        SET @Id = SCOPE_IDENTITY();
        COMMIT TRANSACTION @Tran;
    END TRY
    BEGIN CATCH
        IF(XACT_STATE()) = -1
            BEGIN
                PRINT 'The transaction is in an uncommittable state.' + ' Rolling back transaction.';
                ROLLBACK TRANSACTION @Tran;
        END;
        IF(XACT_STATE()) = 1
            BEGIN
                PRINT 'The transaction is committable.' + ' Committing transaction.';
                COMMIT TRANSACTION @Tran;
        END;
        THROW;
    END CATCH;
     SET XACT_ABORT OFF;
GO
/****** Object:  StoredProcedure [dbo].[Users_ResetPassword]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Users_ResetPassword]
	@Guid nvarchar(200),
	@Password nvarchar(100)
AS
BEGIN
/*

DECLARE @Guid nvarchar(200) = 'FD470D27-D976-40A1-A06F-D2A53B516787',
		@Password nvarchar(100) = 'Password1!'
Exec dbo.Users_ResetPassword @Guid

*/
DECLARE @UserId int

	SET @UserId = ( SELECT 
			UserId
	FROM dbo.UserTokens 
	WHERE Token = @Guid )

IF @UserId > 0		
	UPDATE dbo.Users
		SET 
			[Password] = @Password
		WHERE Id = @UserId

	DELETE FROM dbo.UserTokens
		WHERE Token = @Guid
END
GO
/****** Object:  StoredProcedure [dbo].[Users_Select_AuthData]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Users_Select_AuthData] @Email nvarchar(100)
AS

/*

DECLARE @Email nvarchar(100) = 'admin@lapathways.org'
EXECUTE dbo.Users_Select_AuthData @Email


*/

    BEGIN
        SELECT U.[Id], 
               U.[Email], 
			   U.[Password],
               R.[Name] AS 'Role'
        FROM dbo.[Users] AS U
             JOIN dbo.Roles AS R ON U.RoleId = R.Id
        WHERE U.[Email] = @Email;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Users_SelectAll] 
									@pageIndex int
								   ,@pageSize int

as

/* ------------ TEST CODE -----------------

		DECLARE 
				@pageIndex int = 0
				,@pageSize int = 5

		EXECUTE dbo.Users_SelectAll
									@pageIndex
									,@pageSIze

*/

BEGIN

		DECLARE @offset int = @pageIndex * @pageSize

		SELECT [Id]
			   ,[Email]
			   ,[Password]
			   ,[IsConfirmed]
			   ,[UserStatusId]
			   ,TotalCount = COUNT(1) OVER()

		FROM dbo.Users

		ORDER BY Users.Id

		OFFSET @offset ROWS
		FETCH NEXT @pageSize ROWS ONLY

END
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectByEmail]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Users_SelectByEmail]

									@Email nvarchar(100)

AS

/* --------------- TEST CODE -------------------

		DECLARE

				@Email nvarchar(100) = 'admin@lapathways.org'

		EXECUTE dbo.Users_SelectByEmail
									@Email

*/

BEGIN

		SELECT [Id]
		FROM dbo.Users
		WHERE Email = @Email

END
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Users_SelectById]
									@Id int

AS

/* --------------- TEST CODE -------------------

		DECLARE
				@Id int = 3

		EXECUTE dbo.Users_SelectById
									@Id

*/

BEGIN

		SELECT [Id]
			   ,[Email]
			   ,[Password]
			   ,[IsConfirmed]
			   ,[UserStatusId]

		FROM dbo.Users
		WHERE Id = @Id

END
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectEmailToVerify]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Users_SelectEmailToVerify]

									@Email nvarchar(100)

AS

/* --------------- TEST CODE -------------------

		DECLARE

				@Email nvarchar(100) = 'admin@lapathways.org'

		EXECUTE dbo.Users_SelectEmailToVerify
									@Email

*/

BEGIN

		SELECT	
				[IsConfirmed],
				[Id]
		FROM dbo.Users
		WHERE Email = @Email

END
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectPass_ByEmail]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Users_SelectPass_ByEmail] @Email        NVARCHAR(100) 
                                
AS

/* ------------ TEST CODE ---------------

DECLARE 
		@Email nvarchar(100) = 'MyNewEmail@NewEmail.com'


EXECUTE dbo.[Users_SelectPass_ByEmail] 
					
						@Email
						
						
SELECT *
FROM dbo.Users
WHERE Id = @Id

*/

    BEGIN
        
          SELECT 
          [Password] 

		  From dbo.Users

        WHERE Email = @Email;

    END
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectTokenById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[Users_SelectTokenById]
									@Id int

AS

/* --------------- TEST CODE -------------------

		DECLARE
				@Id int = 3

		EXECUTE dbo.Users_SelectTokenById
									@Id

*/

BEGIN

		SELECT 
			   [Token]
		
		FROM dbo.UserTokens
		WHERE UserId = @Id

END
GO
/****** Object:  StoredProcedure [dbo].[Users_Update]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Users_Update] 
				@Id           INT, 
                @Email        NVARCHAR(100), 
	            @Password     NVARCHAR(100), 
                @IsConfirmed  BIT, 
                @UserStatusId INT

AS

/* ------------ TEST CODE ---------------

DECLARE 
		@Id int = 12
		,@Email nvarchar(100) = 'mattdoe@email.com'
		,@Password nvarchar(100) = 'Sabiopass1!'
		,@IsConfirmed bit = '0'
		,@UserStatusId int = 1

SELECT *
FROM dbo.Users
WHERE Id = @Id

EXECUTE dbo.Users_Update 
						@Id 
						,@Email
						,@Password
						,@IsConfirmed
						,@UserStatusId
						

SELECT *
FROM dbo.Users
WHERE Id = @Id

*/

    BEGIN
        UPDATE dbo.Users
          SET 
              [Email] = @Email, 
              [Password] = @Password, 
              [IsConfirmed] = @IsConfirmed, 
              [UserStatusId] = @UserStatusId
        WHERE Id = @Id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Users_UpdateStatus]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Users_UpdateStatus]	@Id           INT, 
										@UserStatusId INT
AS

/* ------------ TEST CODE ---------------

DECLARE 
		@Id int = 2
		,@UserStatusId int = '2'

SELECT *
FROM dbo.Users
WHERE Id = @Id

EXECUTE dbo.Users_UpdateStatus 
						@Id 
						,@UserStatusId

SELECT *
FROM dbo.Users
WHERE Id = @Id

*/

    BEGIN
        UPDATE dbo.Users
          SET 
              [UserStatusId] = @UserStatusId
        WHERE Id = @Id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[UserTokens_ConfirmEmailToken]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[UserTokens_ConfirmEmailToken]
			@UserId int
			,@Token nvarchar(200)
			,@TokenType int

AS

/*


DECLARE @UserId int = 1
		,@Token nvarchar(100) = 'fb9ed8d1-50db-4eee-82c4-d8a64f8caa5b'
		,@TokenType int = 1

EXECUTE dbo.UserTokens_ConfirmEmailToken
		@UserId
		,@Token
		,@TokenType

	SELECT @UserId
		SELECT *
		FROM dbo.UserTokens_ConfirmEmailToken
		WHERE UserId = @UserId;

*/

    BEGIN

	INSERT INTO [dbo].[UserTokens]
				   ([UserId]
					,[Token]
					,[TokenType])
			 VALUES
					(@UserId
					,@Token
					,@TokenType)

    END
GO
/****** Object:  StoredProcedure [dbo].[VenueImages_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[VenueImages_Insert]
					@Id int OUTPUT,
					@Name nvarchar(255),
					@Description nvarchar(4000),
					@LocationId int,
					@Url nvarchar(255),
					@CreatedBy int,

					@FileUrl NVARCHAR(225), 
					@FileTypeId INT, 
					@CreatedByFiles  INT
AS
/* Test Code
Declare		@Id int,
			@Name nvarchar(225) = 'Improv #2',
			@Description nvarchar(4000) = 'Comedy Central',
			@LocationId int = 11,
			@Url nvarchar(225) = 'www.sabiola/irvine.com',
			@CreatedBy int = 4,

			@UrlFiles NVARCHAR(225) = 'https://business.lacity.org/',
			@FileTypeId int = 4,
			@CreatedByFiles int = 3

Execute dbo.VenueImages_Insert
			@Id OUTPUT,
		    @Name,
            @Description,
            @LocationId,
            @Url,
            @CreatedBy,

			@UrlFiles,
			@FileTypeId,
			@CreatedByFiles

SELECT * FROM [dbo].[Files]
SELECT * FROM [dbo].[Venues]

*/
SET XACT_ABORT ON

BEGIN TRANSACTION [TranVenueImages]

DECLARE  @FileId int,
		 @VenueId int

  EXECUTE [dbo].[Files_Insert]
		 @FileId OUTPUT,
         @FileUrl, 
         @FileTypeId, 
         @CreatedByFiles


	EXECUTE [dbo].[Venues_Insert]
		   @VenueId OUTPUT,
           @Name,
           @Description,
           @LocationId,
           @Url,
           @CreatedBy

		INSERT INTO [dbo].[VenueImages]
			([FileId],
			[VenueId])

		VALUES
			(@FileId,
			@VenueId)

		COMMIT TRANSACTION [TranVenueImages];

GO
/****** Object:  StoredProcedure [dbo].[VenueImages_Update]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc  [dbo].[VenueImages_Update]
			@Id int,
			@Name nvarchar(255),
			@Description nvarchar(4000),
			@LocationId int,
			@Url nvarchar(255),
			@ModifiedBy int,
--- Files	
			@FileId int,
			@FileUrl nvarchar(225)



AS
/*-------TEST CODE-----------


Declare	   @Id int = 1,
		   @Name nvarchar(255) = 'UPDATE SQL #3',
		   @Description nvarchar(4000) = 'Update Test',
		   @LocationId int = 6,
		   @Url nvarchar(255) = 'http://www.google.com',
		   @ModifiedBy int = 3,
		   @FileId int=2,
		   @FileUrl NVARCHAR(255) = 'TESTINGzonaws.com/LaPathways-010c9781-8721-46e1-bcd7-99b23621a4bd-lacitypic.JPG'
FROM dbo.Venues
WHERE Id = @Id


Execute dbo.VenueImages_Update
		   @Id,
		   @Name,
		   @Description,
		   @LocationId,
		   @Url,
		   @ModifiedBy,
		   @FileUrl


Select * 
FROM [dbo].[Venues]
SELECT * 
FROM [dbo].[Files]
WHERE Id = @Id

*/---------------------------
SET XACT_ABORT ON

BEGIN TRANSACTION [TranVenueImagesUpdate]

DECLARE @DateModified datetime = GETUTCDATE()


UPDATE [dbo].[Venues]

		   SET
	       [Name] = @Name,
		   [Description] = @Description,
		   [LocationId] = @LocationId,
		   [Url] = @Url, 
		   [ModifiedBy] = @ModifiedBy,
		   [DateModified] = @DateModified

		   WHERE Id = @Id






UPDATE [dbo].[Files]
			
			SET
			[Url] = @FileUrl
			
			WHERE Id =@FileId;

			COMMIT TRANSACTION [TranVenueImagesUpdate]



GO
/****** Object:  StoredProcedure [dbo].[Venues_Delete_ById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[Venues_Delete_ById]
			@Id int
AS
/*----------TEST CODE----------

	Declare 
		   @Id int = 3

SELECT *
FROM dbo.Venues 
WHERE Id = @Id

Execute dbo.Venues_Delete_ById 
		   @Id

SELECT *
FROM dbo.Venues 
WHERE Id = @Id

*/------------------------------
BEGIN

DELETE FROM [dbo].[Venues]

WHERE Id = @Id

END


GO
/****** Object:  StoredProcedure [dbo].[Venues_Insert]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc  [dbo].[Venues_Insert]
			@Id int OUTPUT,
			@Name nvarchar(225),
			@Description nvarchar(4000),
			@LocationId int,
			@Url nvarchar(225),
			@CreatedBy int
AS
/*
Declare		@Id int,
			@Name nvarchar(225) = 'Improv',
			@Description nvarchar(4000) = 'Comedy Show',
			@LocationId int = 10,
			@Url nvarchar(225) = 'www.sabiola/irvine.com',
			@CreatedBy int = 2

Execute dbo.Venues_Insert
			@Id OUTPUT,
		    @Name,
            @Description,
            @LocationId,
            @Url,
            @CreatedBy
Select * 
FROM dbo.Venues

*/
BEGIN

INSERT INTO [dbo].[Venues]
           ([Name],
            [Description],
            [LocationId],
            [Url],
            [CreatedBy],
            [ModifiedBy])
 
 VALUES
          (@Name,
           @Description,
           @LocationId,
           @Url,
           @CreatedBy,
           @CreatedBy)

		   SET @Id = SCOPE_IDENTItY()
END


GO
/****** Object:  StoredProcedure [dbo].[Venues_Insert_V2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Venues_Insert_V2]
							@Id int OUTPUT,
							@Name nvarchar(255),
							@Description nvarchar(4000),				
							@Url nvarchar(255),
							@CreatedBy int,
							

							@LocationTypeId int,
							@LineOne  nvarchar(255) ,
							@LineTwo  nvarchar(255),
							@City  nvarchar(225) ,
							@Zip  nvarchar(50),
							@StateId  int ,
							@Latitude float ,
							@Longitude  float 	


AS

/* Test Code

DECLARE						@Id int,
							@Name nvarchar(255) = 'Venue',
							@Description nvarchar(4000) = 'Its in LA Live Descritptiono',
							@Url nvarchar(255) = 'http:',
							@CreatedBy int = 4,
							

							@LocationTypeId int = 4,
							@LineOne  nvarchar(255) = 'Adrress line one',
							@LineTwo  nvarchar(255) = 'address line two',
							@City  nvarchar(225) = 'L',
							@Zip  nvarchar(50) = 35253,
							@StateId  int =  43,
							@Latitude float =  43.44,
							@Longitude  float = 43.66 

EXECUTE [dbo].[Venues_Insert_V2]
							@Id OUTPUT,
							@Name,
							@Description,
							@Url,
							@CreatedBy,

							@LocationTypeId,
							@LineOne,
							@LineTwo,
							@City,
							@Zip,
							@StateId,
							@Latitude,
							@Longitude 


SELECT * FROM [dbo].[Locations]
SELECT * FROM [dbo].[Venues]


*/

BEGIN

DECLARE @LocationId int

		

EXECUTE [dbo].[Locations_Insert]
			@LocationId OUTPUT,
			@LocationTypeId,
			@LineOne,
			@LineTwo,
			@City,
			@Zip,
			@StateId,
			@Latitude,
			@Longitude,
			@CreatedBy
	

Execute [dbo].[Venues_Insert]
			@Id OUTPUT,
		    @Name,
            @Description,
            @LocationId,
            @Url,
            @CreatedBy,
			@CreatedBy
	
	

 END
GO
/****** Object:  StoredProcedure [dbo].[Venues_Select_ById]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  proc [dbo].[Venues_Select_ById]
			@Id int

AS


/*--------TEST CODE------------

Declare @Id int = 2

Execute dbo.Venues_Select_ById @Id
		 
*/------------------------------

BEGIN



SELECT     [Id],
           [Name],
           [Description],
           [LocationId],
           [Url],
           [CreatedBy],
           [ModifiedBy],
           [DateCreated],
           [DateModified]
	

FROM [dbo].[Venues]
WHERE Id = @Id




END


GO
/****** Object:  StoredProcedure [dbo].[Venues_Select_CreatedBy]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  proc [dbo].[Venues_Select_CreatedBy]
			@CreatedBy Int

AS


/*--------TEST CODE------------

Declare     @CreatedBy int = 3

Execute dbo.Venues_Select_CreatedBy 
		    @CreatedBy
		 
*/------------------------------

BEGIN



SELECT     [Id],
           [Name],
           [Description],
           [LocationId],
           [Url],
           [CreatedBy],
           [ModifiedBy],
           [DateCreated],
           [DateModified]
	

FROM [dbo].[Venues]
WHERE CreatedBy = @CreatedBy




END


GO
/****** Object:  StoredProcedure [dbo].[Venues_SelectAll]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[Venues_SelectAll] 
			@pageIndex int = 0,
			@pageSize int = 5

AS


/*--------TEST CODE------------

Declare	   @pageIndex int = 0,
		   @pageSize int = 5

Execute dbo.Venues_SelectAll
		   @pageIndex,
		   @pageSize

*/-----------------------------
BEGIN

Declare    @offset int = @pageIndex * @pageSize

SELECT     [Id],
           [Name],
           [Description],
           [LocationId],
           [Url],
           [CreatedBy],
           [ModifiedBy],
           [DateCreated],
           [DateModified],
		   TotalCount = COUNT(1) OVER()

FROM [dbo].[Venues]
ORDER BY Venues.Id
OFFSET @offset Rows 
FETCH Next @pageSize Rows ONLY


END


GO
/****** Object:  StoredProcedure [dbo].[Venues_SelectAllV2]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[Venues_SelectAllV2] 
			@pageIndex int = 0,
			@pageSize int = 5

AS


/*--------TEST CODE------------

Declare	   @pageIndex int = 0,
		   @pageSize int = 20

Execute dbo.Venues_SelectAllV2
		   @pageIndex,
		   @pageSize

*/-----------------------------
BEGIN

Declare    @offset int = @pageIndex * @pageSize

SELECT     V.[Id],
           V.[Name],
           V.[Description],
           V.[LocationId],
           V.[Url],
           V.[CreatedBy],
           V.[ModifiedBy],
           V.[DateCreated],
           V.[DateModified],
		   (SELECT  
				F.[Id] AS [FileId],
			   F.[Url] As [ImageUrl],
			   F.[FileTypeId],
			   F.[CreatedBy] AS [ImageCreatedBy],
			   F.[DateCreated] AS [ImageDateCreated]
			   
			   from dbo.VenueImages AS VI
			   JOIN dbo.Files AS F ON F.Id = VI.FileId
			   where VI.VenueId  = V.Id
			   for JSON AUTO, WITHOUT_ARRAY_WRAPPER
			   ) as PrimaryImage,
		 
		   TotalCount = COUNT(1) OVER()

FROM [dbo].[Venues] AS V
		
ORDER BY V.Id
OFFSET @offset Rows 
FETCH Next @pageSize Rows ONLY


END


GO
/****** Object:  StoredProcedure [dbo].[Venues_Update]    Script Date: 1/6/2020 7:14:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc  [dbo].[Venues_Update]
			@Id int,
			@Name nvarchar(255),
			@Description nvarchar(4000),
			@LocationId int,
			@Url nvarchar(255),
			@ModifiedBy int

AS
/*-------TEST CODE-----------


Declare	   @Id int = 2,
		   @Name nvarchar(255) = 'Sabio Update Test v.1',
		   @Description nvarchar(4000) = 'This is an Update Test',
		   @LocationId int = 11,
		   @Url nvarchar(255) = 'www.sabioLa/irvine.com',
		   @ModifiedBy int = 3
Select * 
FROM dbo.Venues
WHERE Id = @Id

Execute dbo.Venues_Update
		   @Id,
		   @Name,
		   @Description,
		   @LocationId,
		   @Url,
		   @ModifiedBy

Select * 
FROM dbo.Venues
WHERE Id = @Id
*/---------------------------
BEGIN

DECLARE @DateModified datetime = GETUTCDATE()

UPDATE [dbo].[Venues]

		   SET
	       [Name] = @Name,
		   [Description] = @Description,
		   [LocationId] = @LocationId,
		   [Url] = @Url,
		   [DateModified] = @DateModified, 
		   [ModifiedBy] = @ModifiedBy
		   WHERE Id = @Id

END



GO
