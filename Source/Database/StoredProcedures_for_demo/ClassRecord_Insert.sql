IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Lexington].[ClassRecord_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Lexington].[ClassRecord_Insert]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
 * Procedure: [Lexington].[ClassRecord_Insert]
 *
 * Description: insert a Class record.
 * Input:
 * 		@ClassName nvarchar(100), the name of the Class.
 *		@Description nvarchar(128)
 * Output:
 *		@ClassId int
 * Returns: 0 if success, otherwise failure.
 */
 
 CREATE PROCEDURE [Lexington].[ClassRecord_Insert]
	@ClassName nvarchar(100) = NULL,
	@Description nvarchar(128) = NULL,
	@ClassId int = NULL OUTPUT
	--WITH ENCRYPTION
 
 AS
	SET NOCOUNT ON
	
	IF (@ClassName IS NULL OR @ClassName = '')
		RETURN -1;
	
	-- Check for duplication.
	SELECT @ClassId = [Class_Id]
	FROM [Lexington].[Class]
	WHERE [Class_Name] = @ClassName
	
	IF @ClassId IS NOT NULL
		RETURN -1;
		
	-- Insert a new record.
	INSERT INTO [Lexington].[Class]
	(
		[Class_Name]
		, [Description]
		, [Create_Date]
		, [Create_User]
	)
	VALUES
	(
		@ClassName
		, @Description
		, SYSDATETIMEOFFSET()
		, SUSER_SNAME()
	)
	
	SET @ClassId = CAST(SCOPE_IDENTITY() AS INT)
	
	RETURN IIF(@@ERROR = 0, 0, -1)
GO
