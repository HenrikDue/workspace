EXECUTE sp_addrolemember @rolename = N'db_owner', @membername = N'KONC-POEM-MT';


GO
EXECUTE sp_addrolemember @rolename = N'db_datareader', @membername = N'DSB\KONC-UKURANS';

