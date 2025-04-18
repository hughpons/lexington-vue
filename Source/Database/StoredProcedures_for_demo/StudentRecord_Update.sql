IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Lexington].[StudentRecord_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Lexington].[StudentRecord_Update]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
 * Procedure: [Lexington].[StudentRecord_Update]
 *
 * Description: update a Student record.
 * Input:
 *		@StudentId int = NULL
 * 		@FirstName nvarchar(50) = NULL
 * 		@MiddleName nvarchar(50) = NULL
 * 		@LastName nvarchar(50) = NULL
 *		@Description nvarchar(128) = NULL
 * Output: none
 * Returns: 0 if success, otherwise failure.
 */
 
 CREATE PROCEDURE [Lexington].[StudentRecord_Update]
	@StudentId int = NULL,
	@FirstName nvarchar(50) = NULL,
	@MiddleName nvarchar(50) = NULL,
	@LastName nvarchar(50) = NULL,
	@Description nvarchar(128) = NULL
	--WITH ENCRYPTION

AS
	SET NOCOUNT ON
	
	IF (@StudentId IS NULL OR @FirstName IS NULL OR @FirstName = '' OR @LastName IS NULL OR @LastName = '')
		RETURN -1;
		
	UPDATE [Lexington].[Student]
	SET [First_Name] = @FirstName
		, [Middle_Name] = @MiddleName
		, [Last_Name] = @LastName
		, [Description] = @Description
		, [Modify_Date] = SYSDATETIMEOFFSET()
	WHERE [Student_Id] = @StudentId
	
	RETURN IIF(@@ERROR = 0, 0, -1)
GO
