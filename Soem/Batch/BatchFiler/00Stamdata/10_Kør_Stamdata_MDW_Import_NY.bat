ECHO OFF
COLOR 9F
CLS
SET FejlSum=0
SET returvaerdi=1
SET config_file_path=..\Konfiguration\
setlocal enabledelayedexpansion
SET COUNTER=1
FOR /f "tokens=3 delims=><" %%a in ('type %config_file_path%\ServerOgDatabase.dtsConfig ^| find "<ConfiguredValue>"') DO (
  IF !COUNTER!==1 (SET DB_NAVN=%%a)
  IF !COUNTER!==2 (SET DB_SERVER=%%a)
  REM /* hvis der er flere variabel indsættes de her */
  SET /a COUNTER=!COUNTER!+1
  )

SET SOURCE_DRIVE=P:
SET SOURCE_PATH=\70_BI\Projects\Files\StamData\
SET SOURCE_FILE1=EX_MD_G_STAM_Depoter.xlsx
SET SOURCE_FILE2=EX_MD_G_STAM_Ejendomme_Kategori.xlsx
SET SOURCE_FILE3=EX_MD_G_STAM_Ejendomme.xlsx
SET SOURCE_FILE4=EX_MD_G_STAM_Litra.xlsx
SET SOURCE_FILE5=EX_MD_G_STAM_Stationer.xlsx
SET SOURCE_FILE6=EX_MD_G_STAM_Timer_.xlsx
SET SOURCE_FILE7=EX_MD_G_STAM_Togsystem.xls
SET DEST_PATH=\\%DB_SERVER%\files\%DB_NAVN%\StamData\

REM /* konfigurerer log */
IF NOT EXIST .\Log MD .\Log
IF NOT EXIST %DEST_PATH% MD %DEST_PATH%
SET LOGFILE=.\LOG\Log_%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%.txt
SET LOGFILE=%LOGFILE: =0%
ECHO Folder:  %cd%  >> %LOGFILE%
ECHO. >> %LOGFILE%

ECHO Script startet klokken: %time% 

ECHO ******************************************************************************
ECHO *  Server: %DB_SERVER%
ECHO *  Database: %DB_NAVN% 
ECHO *  Følgende filer kopieres til %DB_SERVER%: 
ECHO *  %SOURCE_FILE1% 
ECHO *  %SOURCE_FILE2%
ECHO *  %SOURCE_FILE3%
ECHO *  %SOURCE_FILE4%
ECHO *  %SOURCE_FILE5%
ECHO *  %SOURCE_FILE6%
ECHO *  %SOURCE_FILE7%
ECHO *
ECHO ******************************************************************************
ECHO f | xcopy /y %SOURCE_DRIVE%%SOURCE_PATH%%SOURCE_FILE1% %DEST_PATH%%SOURCE_FILE1% >> %LOGFILE% 
SET /a FejlSum=Fejlsum+%ERRORLEVEL%
ECHO f | xcopy /y %SOURCE_DRIVE%%SOURCE_PATH%%SOURCE_FILE2% %DEST_PATH%%SOURCE_FILE2% >> %LOGFILE%
SET /a FejlSum=Fejlsum+%ERRORLEVEL%
ECHO f | xcopy /y %SOURCE_DRIVE%%SOURCE_PATH%%SOURCE_FILE3% %DEST_PATH%%SOURCE_FILE3% >> %LOGFILE%
SET /a FejlSum=Fejlsum+%ERRORLEVEL%
ECHO f | xcopy /y %SOURCE_DRIVE%%SOURCE_PATH%%SOURCE_FILE4% %DEST_PATH%%SOURCE_FILE4% >> %LOGFILE%
SET /a FejlSum=Fejlsum+%ERRORLEVEL%
ECHO f | xcopy /y %SOURCE_DRIVE%%SOURCE_PATH%%SOURCE_FILE5% %DEST_PATH%%SOURCE_FILE5% >> %LOGFILE%
SET /a FejlSum=Fejlsum+%ERRORLEVEL%
ECHO f | xcopy /y %SOURCE_DRIVE%%SOURCE_PATH%%SOURCE_FILE6% %DEST_PATH%%SOURCE_FILE6% >> %LOGFILE%
SET /a FejlSum=Fejlsum+%ERRORLEVEL%
ECHO f | xcopy /y %SOURCE_DRIVE%%SOURCE_PATH%%SOURCE_FILE7% %DEST_PATH%%SOURCE_FILE7% >> %LOGFILE%
SET /a FejlSum=Fejlsum+%ERRORLEVEL%
ECHO til %DEST_PATH% >> %LOGFILE%
IF NOT %FejlSum%==0 (ECHO *  Kopier stamdata filer fejlet & SET /a FejlSum=Fejlsum+1 & GOTO Fejlet) ELSE (ECHO *  Kopier stamdata filer afsluttet - ok)
ECHO. >> %LOGFILE%
COLOR E0
ECHO.
ECHO *  Afvikler pakker
FOR /f %%a in ('SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @return_value int; EXEC	@return_value = etl.run_etl_stamdata_mdw; print @return_value;" -h -1') DO SET returvaerdi=%%a
SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "SET NOCOUNT ON;declare @pakkenavn varchar(50),@resultat varchar(50),@startet varchar(50),@afsluttet varchar(50),@varighed varchar(20); select @pakkenavn=pakkenavn,@resultat=resultat,@startet=startet,@afsluttet=afsluttet,@varighed=varighed from etl.ssisdb_messages;print 'Pakkenavn: '+@pakkenavn+' Resultat: '+@resultat+ ' Startet: '+@startet+' Afsluttet: '+@afsluttet+' Varighed sek: '+@varighed" >> %LOGFILE%
SET /a FejlSum=Fejlsum+%returvaerdi%
IF NOT %FejlSum%==0 (ECHO *  Afvikling af pakker fejlet & GOTO Fejlet) ELSE (ECHO *  Afvikling af pakker afsluttet - ok)
ECHO.
ECHO. >> %LOGFILE%
%LOGFILE%
COLOR A0
PAUSE

GOTO Afslut

:Fejlet

COLOR 4F
%LOGFILE%
PAUSE

:Afslut