IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Lexington].[StudentRecord_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Lexington].[StudentRecord_Delete]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
 * Procedure: [Lexington].[StudentRecord_Delete]
 *
 * Description: delete a Student record.
 * Input: @StudentId int.
 * Output: none.
 * Returns: 0 if success, otherwise failure.
 */
 
 CREATE PROCEDURE [Lexington].[StudentRecord_Delete]
	@StudentId int = NULL
	--WITH ENCRYPTION
 
 AS
	SET NOCOUNT ON
	
	IF @StudentId IS NULL
		RETURN -1;
		
	DELETE FROM [Lexington].[Student]
	WHERE [Student_Id] = @StudentId
	
	RETURN IIF(@@ERROR = 0, 0, -1)
GO
