ECHO OFF
COLOR 9F
SET ValgIndtastNyPeriode=0
SET ValgMasterPeriode=0
REM /* henter server og database konfiguration fra ekstern fil */ 
SET config_file_path=..\Konfiguration\
setlocal enabledelayedexpansion
SET returvaerdi=1
SET COUNTER=1
FOR /f "tokens=3 delims=><" %%a in ('type %config_file_path%\ServerOgDatabase.dtsConfig ^| find "<ConfiguredValue>"') DO (
  IF !COUNTER!==1 (SET DB_NAVN=%%a)
  IF !COUNTER!==2 (SET DB_SERVER=%%a)
  REM /* hvis der er flere variabel inds�ttes de her */
  SET /a COUNTER=!COUNTER!+1
  )
  
SET DEST_LOG_PATH=\\%DB_SERVER%\files\%DB_NAVN%\Togpersonale_FR_PDS\

:: /* konfigurerer log */
IF NOT EXIST %DEST_LOG_PATH%Log MD %DEST_LOG_PATH%Log
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
SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @periode varchar(50); select @periode = Value from ods.CTL_Dataload where kilde_system = 'Alle' and Variable = 'Master_periode'; print '*  Master LoadPeriode:  ---> '+@periode + ' <--- Tjek periode her.'" 
SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @periode varchar(50); select @periode = Value from ods.CTL_Dataload where kilde_system = 'PDS' and Variable = 'Last_Period_Load'; print '*  PDS FR LoadPeriode: '+@periode"
ECHO *
ECHO ******************************************************************************
ECHO.

CHOICE /C 123 /N /M "Tast 1: Start med master loadperiode, 2: Indtast Ny dato eller 3: Fortryd og afslut"

IF %errorlevel%==3 GOTO ExitChosen
IF %errorlevel%==2 SET ValgIndtastNyPeriode=1
IF %errorlevel%==1 SET ValgMasterPeriode=1
ECHO.
REM if Valgindtastnyperiode == 0 s� s�t masterperioden som load periode FOR protal (g�res ved at kalde exec [etl].[loadperiod_protal] uden v�rdi FOR perioden

IF %ValgMasterPeriode%==1 SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "exec [etl].[loadperiod_PDS]" 
IF %ValgMasterPeriode%==1 GOTO Valgslut

:GenvalgPeriode
IF  %ValgIndtastNyPeriode%==1 SET /p NYPERIODE="Indtast ny loadperiode yyyymm FOR Protal :"
IF  %ValgIndtastNyPeriode%==1 SET QUERYTEXT=exec[etl].[loadperiod_PDS]'%NYPERIODE%01'
IF  %ValgIndtastNyPeriode%==1 (ECHO. & SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q %QUERYTEXT%)
IF  %ValgIndtastNyPeriode%==1 CHOICE /C 123 /N /M "Tast 1: Start med valgt periode, 2: Indtast Ny dato eller 3: Fortryd og afslut"

IF %errorlevel%==3 GOTO ExitChosen
IF %errorlevel%==2 SET ValgIndtastNyPeriode=1 & GOTO GenvalgPeriode

:Valgslut

SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @periode varchar(50); select @periode = Value from ods.CTL_Dataload where kilde_system = 'PDS' and Variable = 'Last_Period_Load'; print 'Starter job med PDS LoadPeriode: '+@periode"
ECHO.

PAUSE
COLOR E0
ECHO *  Afvikler pakker
ECHO.
FOR /f %%a in ('SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @return_value int; EXEC @return_value = etl.run_etl_Togpersonale_FR_PDS; print @return_value;" -h -1') DO SET returvaerdi=%%a
SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "SET NOCOUNT ON;declare @pakkenavn varchar(50),@resultat varchar(50),@startet varchar(50),@afsluttet varchar(50),@varighed varchar(20); select @pakkenavn=pakkenavn,@resultat=resultat,@startet=startet,@afsluttet=afsluttet,@varighed=varighed from etl.ssisdb_messages;print 'Pakkenavn: '+@pakkenavn+' Resultat: '+@resultat+ ' Startet: '+@startet+' Afsluttet: '+@afsluttet+' Varighed sek: '+@varighed" >> %LOGFILE%
IF NOT %returvaerdi%==0 (ECHO *  Afvikling af pakker fejlet & GOTO Fejlet) ELSE (ECHO *  Afvikling af pakker afsluttet - ok)
ECHO.
ECHO. >> %LOGFILE%
%LOGFILE%
COLOR A0
PAUSE

%DEST_LOG_PATH%Log\logDiff.txt
%DEST_LOG_PATH%Log\logDiffDet.txt
%DEST_LOG_PATH%Log\CheckTabeller.txt

GOTO ExitChosen

:Fejlet

COLOR 4F
%LOGFILE%
PAUSE

:ExitChosen

