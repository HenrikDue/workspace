ECHO OFF
COLOR 9F
SET ValgIndtastNyPeriode=0
SET ValgMasterPeriode=0
rem /* henter server og database konfiguration fra ekstern fil */ 
set config_file_path=..\Konfiguration\
setlocal enabledelayedexpansion
SET FejlSum=0
SET returvaerdi=1
set COUNTER=1
for /f "tokens=3 delims=><" %%a in ('type %config_file_path%\ServerOgDatabase.dtsConfig ^| find "<ConfiguredValue>"') do (
  IF !COUNTER!==1 (SET DB_NAVN=%%a)
  IF !COUNTER!==2 (SET DB_SERVER=%%a)
  REM /* hvis der er flere variabel indsµttes de her */
  SET /a COUNTER=!COUNTER!+1
  )
  
SET SOURCE_DRIVE=P:
SET SOURCE_PATH=P:\70_BI\Projects\Files\FPC_L›nsum\
SET SOURCE_FILE1="RD_R_L›nsumAns‘ttelsetype "

SET DEST_PATH=\\%DB_SERVER%\files\%DB_NAVN%\FPC_L›nsum\
if not exist %DEST_PATH%\CSV md %DEST_PATH%\CSV
SET FILE_EXT=.xlsx

:: /* konfigurerer log */
if not exist .\Log md .\Log
SET LOGFILE=.\LOG\Log_FPC_L›nsum_%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%.txt
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
SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @periode varchar(50); select @periode = Value from ods.CTL_Dataload where kilde_system = 'Alle' and Variable = 'Master_periode'; print '*  Master LoadPeriode:  ---> '+@periode + ' <--- Tjek periode her.'" 
SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @periode varchar(50); select @periode = substring(value,1,6) from ods.CTL_Dataload where kilde_system = 'Alle' and Variable = 'Model_Periode'; print 'Starter med LoadPeriode: '+@periode"
ECHO *
ECHO ******************************************************************************
ECHO.

CHOICE /C 123 /N /M "Tast 1: Start med master loadperiode, 2: Indtast Ny dato eller 3: Fortryd og afslut"

IF %errorlevel%==3 GOTO ExitChosen
IF %errorlevel%==2 SET ValgIndtastNyPeriode=1
IF %errorlevel%==1 SET ValgMasterPeriode=1
ECHO.

IF %ValgMasterPeriode%==1 SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "exec [etl].[loadperiod_GD]" 
IF %ValgMasterPeriode%==1 GOTO Valgslut

:GenvalgPeriode
IF  %ValgIndtastNyPeriode%==1 SET /p NYPERIODE="Indtast ny loadperiode yyyymm for GD:"
IF  %ValgIndtastNyPeriode%==1 SET QUERYTEXT=exec[etl].[loadperiod_GD]'%NYPERIODE%01'
IF  %ValgIndtastNyPeriode%==1 (ECHO. & SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q %QUERYTEXT%)
IF  %ValgIndtastNyPeriode%==1 CHOICE /C 123 /N /M "Tast 1: Start med valgt periode, 2: Indtast Ny dato eller 3: Afslut"

IF %errorlevel%==3 GOTO ExitChosen
IF %errorlevel%==2 SET ValgIndtastNyPeriode=1 & GOTO GenvalgPeriode

:Valgslut

SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @periode varchar(50); select @periode = substring(value,1,6) from ods.CTL_Dataload where kilde_system = 'Alle' and Variable = 'Model_Periode'; print 'Starter med GD LoadPeriode: '+@periode"
ECHO.
for /f %%a in ('SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "SET NOCOUNT ON;select Value from ods.CTL_Dataload where kilde_system = 'Alle' and Variable = 'Model_Periode'" -h -1') do set PERIODE=%%a

pause
COLOR E0
echo *  Overf›rer filer til sqlserver
ECHO. >> %LOGFILE%
ECHO f | xcopy /y %SOURCE_PATH%%SOURCE_FILE1%%PERIODE%%FILE_EXT% %DEST_PATH%%SOURCE_FILE1%%PERIODE%%FILE_EXT% >> %LOGFILE%
SET /a FejlSum=Fejlsum+%ERRORLEVEL%
echo til %DEST_PATH% >> %LOGFILE%
ECHO. >> %LOGFILE%
IF NOT %FejlSum%==0 (ECHO *  Kopiering af filer fejlet & SET /a FejlSum=Fejlsum+1 & GOTO Fejlet) ELSE (ECHO *  Kopiering af filer afsluttet - ok)
REM SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "exec etl.run_etl_FPC_Loensum ''" >> %LOGFILE%
ECHO *  Afvikler pakker
FOR /f %%a in ('SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @return_value int; EXEC @return_value = etl.run_etl_FPC_Loensum; print @return_value;" -h -1') DO SET returvaerdi=%%a
SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "SET NOCOUNT ON;declare @pakkenavn varchar(50),@resultat varchar(50),@startet varchar(50),@afsluttet varchar(50),@varighed varchar(20); select @pakkenavn=pakkenavn,@resultat=resultat,@startet=startet,@afsluttet=afsluttet,@varighed=varighed from etl.ssisdb_messages;print 'Pakkenavn: '+@pakkenavn+' Resultat: '+@resultat+ ' Startet: '+@startet+' Afsluttet: '+@afsluttet+' Varighed sek: '+@varighed" >> %LOGFILE%
IF NOT %returvaerdi%==0 (ECHO *  Afvikling af pakker fejlet & GOTO Fejlet) ELSE (ECHO *  Afvikling af pakker afsluttet - ok)
ECHO.
ECHO. >> %LOGFILE%
%LOGFILE%
COLOR A0
pause

GOTO ExitChosen

:Fejlet

COLOR 4F
%LOGFILE%
PAUSE

:ExitChosen

