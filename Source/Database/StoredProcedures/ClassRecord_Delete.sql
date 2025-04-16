IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Lexington].[ClassRecord_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Lexington].[ClassRecord_Delete]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
 * Procedure: [Lexington].[ClassRecord_Delete]
 *
 * Description: delete a Class record.
 * Input: @ClassId int.
 * Output: none.
 * Returns: 0 if success, otherwise failure.
 */
 
 CREATE PROCEDURE [Lexington].[ClassRecord_Delete]
	@ClassId int = NULL
	--WITH ENCRYPTION
 
 AS
	SET NOCOUNT ON
	
	IF @ClassId IS NULL
		RETURN -1;
		
	DELETE FROM [Lexington].[Class]
	WHERE [Class_Id] = @ClassId
	
	RETURN IIF(@@ERROR = 0, 0, -1)
GO
