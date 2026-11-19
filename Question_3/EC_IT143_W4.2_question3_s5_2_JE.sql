DROP TABLE IF EXISTS dbo.t_purchase_count;
GO

CREATE TABLE dbo.t_purchase_count
(my_message		varchar(25) NOT NULL,
 purchase_count INT NOT NULL,

 CONSTRAINT PK_t_purchase_count PRIMARY KEY CLUSTERED(my_message)
 );
 GO