ECHO OFF
COLOR 9F
REM /* henter server og database konfiguration fra ekstern fil */ 
SET config_file_path=..\Konfiguration\
setlocal enabledelayedexpansion
SET returvaerdi=1
SET COUNTER=1
FOR /f "tokens=3 delims=><" %%a in ('type %config_file_path%\ServerOgDatabase.dtsConfig ^| find "<ConfiguredValue>"') do (
  IF !COUNTER!==1 (SET DB_NAVN=%%a)
  IF !COUNTER!==2 (SET DB_SERVER=%%a)
  REM /* hvis der er flere variabel inds‘ttes de her */
  SET /a COUNTER=!COUNTER!+1
  )

:: /* konfigurerer log */
IF NOT EXIST .\Log MD .\Log
SET LOGFILE=.\LOG\Log_%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%.txt
SET LOGFILE=%LOGFILE: =0%
ECHO Folder:  %cd%  >> %LOGFILE%
ECHO. >> %LOGFILE%

:STARTEN
CLS
ECHO Script startet klokken: %time% 

ECHO ******************************************************************************
ECHO *
ECHO *  Server: %DB_SERVER%
ECHO *  Database: %DB_NAVN%
ECHO *
SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @periode varchar(50); select @periode = Value from ods.CTL_Dataload where kilde_system = 'Alle' and Variable = 'Model_Periode'; print '*  GD load periode: '+@periode"
ECHO *
ECHO ******************************************************************************
ECHO.

CHOICE /C SF /N /M "Tast S (Start) eller F (Fortryd)"
IF %errorlevel%==2 GOTO ExitChosen
COLOR E0
ECHO *  Afvikler pakker
FOR /f %%a in ('SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @return_value int; EXEC @return_value = etl.run_etl_Load_GD_tabeller; print @return_value;" -h -1') DO SET returvaerdi=%%a
SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "SET NOCOUNT ON;declare @pakkenavn varchar(50),@resultat varchar(50),@startet varchar(50),@afsluttet varchar(50),@varighed varchar(20); select @pakkenavn=pakkenavn,@resultat=resultat,@startet=startet,@afsluttet=afsluttet,@varighed=varighed from etl.ssisdb_messages;print 'Pakkenavn: '+@pakkenavn+' Resultat: '+@resultat+ ' Startet: '+@startet+' Afsluttet: '+@afsluttet+' Varighed sek: '+@varighed" >> %LOGFILE%
IF NOT %returvaerdi%==0 (ECHO *  Afvikling af pakker fejlet & GOTO Fejlet) ELSE (ECHO *  Afvikling af pakker afsluttet - ok)
ECHO.
ECHO. >> %LOGFILE%
%LOGFILE%
COLOR A0
PAUSE

GOTO ExitChosen

:Fejlet

COLOR 4F
%LOGFILE%
PAUSE

:ExitChosen

