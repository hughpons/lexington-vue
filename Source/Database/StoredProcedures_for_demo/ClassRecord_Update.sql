IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Lexington].[ClassRecord_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Lexington].[ClassRecord_Update]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
 * Procedure: [Lexington].[ClassRecord_Update]
 *
 * Description: update a Class record.
 * Input:
 *		@ClassId int = NULL
 * 		@ClassName nvarchar(100), the name of the Class.
 *		@Description nvarchar(128)
 * Output: none
 * Returns: 0 if success, otherwise failure.
 */
 
 CREATE PROCEDURE [Lexington].[ClassRecord_Update]
	@ClassId int = NULL,
	@ClassName nvarchar(100) = NULL,
	@Description nvarchar(128) = NULL
	--WITH ENCRYPTION
	
AS
	SET NOCOUNT ON
	
	IF (@ClassId IS NULL OR @ClassName IS NULL OR @ClassName = '')
		RETURN -1;
		
	UPDATE [Lexington].[Class]
	SET [Class_Name] = @ClassName
		, [Description] = @Description
		, [Modify_Date] = SYSDATETIMEOFFSET()
	WHERE [Class_Id] = @ClassId
	
	RETURN IIF(@@ERROR = 0, 0, -1)
GO
