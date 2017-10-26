USE [ProjectOrganizer]
GO

INSERT INTO [dbo].[departments]
([name])
VALUES
('human_resources'), ('operations'), ('administration');
GO

INSERT INTO [dbo].[employees]
([employee_number], [last_name], [first_name], [gender], [birthday], [hire_date])
VALUES
(1, 'ASCALA', 'ALAN', 'M', '1992-02-29', '2010-01-10'),
(2,'ARRONS', 'AVA', 'F', '1988-02-29', '2010-01-10'),
(3, 'BEN', 'BENJAMIN', 'M', '1988-03-15', '2010-01-10'),
(4, 'BRIANNA', 'BIGGS', 'F', '1993-04-20', '2011-05-10'),
(5, 'CARL', 'CANTRO',	'', '1981-05-07', '2009-06-13'),
(6, 'CARLA', 'CARROZ',	NULL, '1972-03-12', '2008-01-10'),
(7, 'DRONN', 'DAN', 'M', '1990-08-10', '2010-01-10'),
(8, 'DEENA', 'DAVIS', 'F', '1985-08-10', '2010-01-10');
GO

INSERT INTO [dbo].[employee_department]
([employee_num], [department_num], [job_title])
VALUES
(1, 1, 'department manager'),
(2, 1, 'associate'),
(3, 2, 'department manager'),
(4, 3, 'big boss'),
(5, 2, 'associate'),
(6, 2, 'graphic designer'),
(7, 2, 'coffee runner'),
(8, 1, 'corkboard populator');
GO

INSERT INTO [dbo].[employee_project]
([employee_num], [project_num])
VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3),
(6, 4),
(7, 5),
(8, 5);
GO

INSERT INTO [dbo].[project]
([project_num],[name],[start_date])
VALUES
(1, 'Alpha', '2009-01-10'),
(2, 'Beta', '2010-02-20'),
(3, 'Charlie', '2011-03-30'),
(4, 'Delta', '2011-04-15'),
(5, 'Epsilon', '2013-05-25');
