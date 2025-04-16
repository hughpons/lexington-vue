IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Lexington].[StudentRecord_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Lexington].[StudentRecord_Insert]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
 * Procedure: [Lexington].[StudentRecord_Insert]
 *
 * Description: insert a Student record and the associations with some classes if available.
 * Input:
 * 		@FirstName nvarchar(50) = NULL
 * 		@MiddleName nvarchar(50) = NULL
 * 		@LastName nvarchar(50) = NULL
 *		@Description nvarchar(128) = NULL
 *		@ClassIdList varchar(max) = NULL
 *		@Delimiter char(1), the specified separator character.
 * Output:
 *		@StudentId int = NULL
 * Returns: 0 if success, otherwise failure.
 */
 
 CREATE PROCEDURE [Lexington].[StudentRecord_Insert]
	@FirstName nvarchar(50) = NULL,
	@MiddleName nvarchar(50) = NULL,
	@LastName nvarchar(50) = NULL,
	@Description nvarchar(128) = NULL,
	@ClassIdList varchar(max) = NULL,
	@Delimiter char(1) = ',',
	@StudentId int = NULL OUTPUT
	--WITH ENCRYPTION
	
AS
	SET NOCOUNT ON
	
	DECLARE @errorNumber int,
			@errorMessage nvarchar(2048),
			@errorSeverity int,
			@errorState int,
			@errorText nvarchar(4000),
			@ReturnCode int
	
	SET @ReturnCode = 0
	
	-- Check for duplication (e.g. could use more fields such as DOB, ContactInfo, Alias and etc., if applicable).
	SELECT @StudentId = [Student_Id]
	FROM [Lexington].[Student]
	WHERE [First_Name] = @FirstName
		AND [Middle_Name] = @MiddleName
		AND [Last_Name] = @LastName
		AND [Description] = @Description

	IF @StudentId IS NOT NULL
		RETURN -1;
		
	BEGIN TRANSACTION
	BEGIN TRY
		-- Insert a student record.
		INSERT INTO [Lexington].[Student]
		(
			[First_Name]
			, [Middle_Name]
			, [Last_Name]
			, [Description]
			, [Create_Date]
			, [Create_User]
		)
		VALUES
		(
			@FirstName
			, @MiddleName
			, @LastName
			, @Description
			, SYSDATETIMEOFFSET()
			, SUSER_SNAME()
		)
		
		SET @StudentId = CAST(SCOPE_IDENTITY() AS INT)
		
		-- Insert records for associating classes with the Student.
		IF (@ClassIdList IS NOT NULL AND @ClassIdList <> '')
		BEGIN
			INSERT INTO [Lexington].[Student_Class]
			(
				[Student_Id]
				, [Class_Id]
				, [Create_Date]
				, [Create_User]
			)
			SELECT DISTINCT @StudentId, value = TRY_CONVERT(int, value), SYSDATETIMEOFFSET(), SUSER_SNAME()
			FROM STRING_SPLIT(@ClassIdList, @Delimiter)
		END
		
	END TRY
	BEGIN CATCH
	
		SELECT @errorNumber = ERROR_NUMBER()
			, @errorMessage = ERROR_MESSAGE()
			, @errorSeverity = ERROR_SEVERITY()
			, @errorState = ERROR_STATE()
			
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION
			
		SET @errorText = 'Student and associated class records insert error:' + CAST(@errorNumber AS varchar) + ', ' + @errorMessage
		SET @ReturnCode = -1

		RAISERROR (@errorText, @errorSeverity, @errorState)
		
	END CATCH

	IF @@TRANCOUNT > 0
		COMMIT TRANSACTION

	RETURN @ReturnCode
GO
