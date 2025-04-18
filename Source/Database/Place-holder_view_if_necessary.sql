/*
 * View: [Lexington].[view_StudentClassMapping]
 *
 * Description: this view returns all the students and the classes they registered.
 */
 
IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[Lexington].[view_StudentClassMapping]'))
DROP VIEW [Lexington].[view_StudentClassMapping]
GO

CREATE VIEW [Lexington].[view_StudentClassMapping]
AS
(
	SELECT std.[Student_Id], [First_Name], [Middle_Name], [Last_Name], std.[Description] AS [StudentMemo]
			, sc.[Student_Class_Id], sc.[Class_Id], cls.[Class_Name], cls.[Description] AS [ClassDescription]
	FROM [Lexington].[Student] std WITH (NOLOCK) 
	LEFT JOIN [Lexington].[Student_Class] sc WITH (NOLOCK)
	ON std.[Student_Id] = sc.[Student_Id]
	LEFT JOIN [Lexington].[Class] cls WITH (NOLOCK)
	ON sc.[Class_Id] = cls.[Class_Id]
)
GO
