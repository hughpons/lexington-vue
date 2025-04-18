/******************************************************************************
* DevOps Story/Task #XXXXXX: Creates tables in SchoolDB
******************************************************************************/
USE SchoolDB
GO

/****** Object:  Table [Lexington].[Student] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Lexington].[Student]') AND type IN (N'U'))
BEGIN

CREATE TABLE [Lexington].[Student](
	[Student_Id] [int] IDENTITY(100000, 1) NOT NULL,
	[First_Name] [nvarchar](50) NOT NULL,
	[Middle_Name] [nvarchar](50) NULL,
	[Last_Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar] (128) NULL,
	[Status_Flag] [bit] NOT NULL CONSTRAINT [DF_Constraint_Student_Status_Flag] DEFAULT (1),
	[Create_Date] [datetimeoffset](7) NULL,
	[Modify_Date] [datetimeoffset](7) NULL,
	[Create_User] [nvarchar](100) NULL,
CONSTRAINT [PK__Lexington__Student] PRIMARY KEY CLUSTERED
(
	[Student_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
CONSTRAINT [UQ__Lexington__Student__Name] UNIQUE NONCLUSTERED
(
	[First_Name] ASC,
	[Middle_Name] ASC,
	[Last_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

END
GO

/****** Object:  Table [Lexington].[Class] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Lexington].[Class]') AND type IN (N'U'))
BEGIN

CREATE TABLE [Lexington].[Class](
	[Class_Id] [int] IDENTITY(100000, 1) NOT NULL,
	[Class_Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar] (128) NULL,
	[Status_Flag] [bit] NOT NULL CONSTRAINT [DF_Constraint_Class_Status_Flag] DEFAULT (1),
	[Create_Date] [datetimeoffset](7) NULL,
	[Modify_Date] [datetimeoffset](7) NULL,
	[Create_User] [nvarchar](100) NULL,
CONSTRAINT [PK__Lexington__Class] PRIMARY KEY CLUSTERED
(
	[Class_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
CONSTRAINT [UQ__Lexington__Class__Name] UNIQUE NONCLUSTERED
(
	[Class_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

END
GO

/****** Object:  Table [Lexington].[Student_Class] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Lexington].[Student_Class]') AND type IN (N'U'))
BEGIN

CREATE TABLE [Lexington].[Student_Class] (
	[Student_Class_Id] [int] IDENTITY(100000, 1) NOT NULL,
	[Student_Id] [int] NOT NULL,
	[Class_Id] [int] NOT NULL,
	[Create_Date] [datetimeoffset](7) NULL,
	[Create_User] [nvarchar](100) NULL,
CONSTRAINT [PK__Lexington__Student_Class] PRIMARY KEY NONCLUSTERED
(
	[Student_Class_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

END
GO

IF (NOT EXISTS(SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Lexington].[FK__Lexington__Student_Class__Student]') AND parent_object_id = OBJECT_ID(N'[Lexington].[Student_Class]')))
ALTER TABLE [Lexington].[Student_Class] WITH CHECK ADD  CONSTRAINT [FK__Lexington__Student_Class__Student] FOREIGN KEY([Student_Id])
REFERENCES [Lexington].[Student] ([Student_Id])
ON DELETE CASCADE
GO

ALTER TABLE [Lexington].[Student_Class] CHECK CONSTRAINT [FK__Lexington__Student_Class__Student]
GO

IF (NOT EXISTS(SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Lexington].[FK__Lexington__Student_Class__Class]') AND parent_object_id = OBJECT_ID(N'[Lexington].[Student_Class]')))
ALTER TABLE [Lexington].[Student_Class] WITH CHECK ADD  CONSTRAINT [FK__Lexington__Student_Class__Class] FOREIGN KEY([Class_Id])
REFERENCES [Lexington].[Class] ([Class_Id])
ON DELETE CASCADE
GO

ALTER TABLE [Lexington].[Student_Class] CHECK CONSTRAINT [FK__Lexington__Student_Class__Class]
GO

/****** Object:  Table [Universal].[User] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Universal].[User]') AND type IN (N'U'))
BEGIN

CREATE TABLE [Universal].[User](
	[User_Id] [int] IDENTITY(100000, 1) NOT NULL,
	[First_Name] [nvarchar](50) NOT NULL,
	[Last_Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar] (128) NULL,
	[User_Name] [nvarchar](256) NULL,
	[Status_Flag] [bit] NOT NULL CONSTRAINT [DF_Constraint_User_Status_Flag] DEFAULT (1),
	[Create_Date] [datetimeoffset](7) NULL,
	[Modify_Date] [datetimeoffset](7) NULL,
	[Create_User] [nvarchar](100) NULL,
CONSTRAINT [PK__Universal__User] PRIMARY KEY CLUSTERED
(
	[User_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
CONSTRAINT [UQ__Universal__User__Name] UNIQUE NONCLUSTERED
(
	[First_Name] ASC,
	[Last_Name] ASC,
	[User_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

END
GO

/****** Object:  Table [Universal].[User] ******/
IF NOT EXISTS
(
	SELECT TOP(1) 1
	FROM [Universal].[User]
	WHERE [User_Id] = 100000
)
BEGIN
	SET IDENTITY_INSERT [Universal].[User] ON
	
	INSERT INTO [Universal].[User]
	(
		[User_Id]
		, [First_Name]
		, [Last_Name]
		, [User_Name]
		, [Create_Date]
		, [Create_User]
		
	)
	VALUES
	(
		100000
		, N'Rachel'
		, N'Zhang'
		, N'admin'
		, SYSDATETIMEOFFSET()
		, SUSER_SNAME()
	)
	
	SET IDENTITY_INSERT [Universal].[User] OFF
END
GO
