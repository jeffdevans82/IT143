DROP TABLE IF EXISTS dbo.t_juan_count;
GO

CREATE TABLE dbo.t_juan_count
(my_message		varchar(25) NOT NULL,
 juan_count INT NOT NULL,

 CONSTRAINT PK_t_juan_count PRIMARY KEY CLUSTERED(my_message)
 );
 GO