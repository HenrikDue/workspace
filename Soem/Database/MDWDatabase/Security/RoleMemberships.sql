﻿ALTER ROLE [db_owner] ADD MEMBER [DSB\HEBR2802];




GO
ALTER ROLE [db_owner] ADD MEMBER [DSB\SQL_BI_BRUGER];


GO
ALTER ROLE [db_accessadmin] ADD MEMBER [DSB\HEBR2802];




GO
ALTER ROLE [db_ddladmin] ADD MEMBER [DSB\HEBR2802];




GO
ALTER ROLE [db_datareader] ADD MEMBER [DSB\SQL_BI_BRUGER];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [DSB\SQL_BI_BRUGER];

