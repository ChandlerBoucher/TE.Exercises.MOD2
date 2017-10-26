
/*********TABLE CREATOR & POPULATOR*****************/

USE [ProjectOrganizer]
GO

/****** Object:  Table [dbo].[departments]    Script Date: 6/13/2017 3:57:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[departments](
	[department_number] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_departments] PRIMARY KEY CLUSTERED 
(
	[department_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[employee_department]    Script Date: 6/13/2017 3:59:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[employee_department](
	[employee_num] [int] NOT NULL,
	[department_num] [int] NOT NULL,
	[job_title] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_employee_department] PRIMARY KEY CLUSTERED 
(
	[employee_num] ASC,
	[department_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[employee_department]  WITH CHECK ADD  CONSTRAINT [FK_employee_department_departments] FOREIGN KEY([department_num])
REFERENCES [dbo].[departments] ([department_number])
GO

ALTER TABLE [dbo].[employee_department] CHECK CONSTRAINT [FK_employee_department_departments]
GO

ALTER TABLE [dbo].[employee_department]  WITH CHECK ADD  CONSTRAINT [FK_employee_department_employees] FOREIGN KEY([employee_num])
REFERENCES [dbo].[employees] ([employee_number])
GO

ALTER TABLE [dbo].[employee_department] CHECK CONSTRAINT [FK_employee_department_employees]
GO

/****** Object:  Table [dbo].[employees]    Script Date: 6/13/2017 4:01:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[employees](
	[employee_number] [int] IDENTITY(1,1) NOT NULL,
	[last_name] [nvarchar](30) NOT NULL,
	[first_name] [nvarchar](30) NOT NULL,
	[gender] [nvarchar](10) NULL,
	[birthday] [date] NOT NULL,
	[hire_date] [date] NOT NULL,
 CONSTRAINT [PK_employees] PRIMARY KEY CLUSTERED 
(
	[employee_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[employee_project]    Script Date: 6/13/2017 4:02:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[employee_project](
	[employee_num] [int] NOT NULL,
	[project_num] [int] NOT NULL,
 CONSTRAINT [PK_employee_project] PRIMARY KEY CLUSTERED 
(
	[employee_num] ASC,
	[project_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[employee_project]  WITH CHECK ADD  CONSTRAINT [FK_employee_project_employees] FOREIGN KEY([employee_num])
REFERENCES [dbo].[employees] ([employee_number])
GO

ALTER TABLE [dbo].[employee_project] CHECK CONSTRAINT [FK_employee_project_employees]
GO

ALTER TABLE [dbo].[employee_project]  WITH CHECK ADD  CONSTRAINT [FK_employee_project_project] FOREIGN KEY([project_num])
REFERENCES [dbo].[project] ([project_num])
GO

ALTER TABLE [dbo].[employee_project] CHECK CONSTRAINT [FK_employee_project_project]
GO

/****** Object:  Table [dbo].[project]    Script Date: 6/13/2017 4:32:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[project](
	[project_num] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](30) NOT NULL,
	[start_date] [date] NOT NULL,
 CONSTRAINT [PK_project] PRIMARY KEY CLUSTERED 
(
	[project_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

