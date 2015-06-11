ECHO OFF
SET ValgIndtastNyPeriode=0
SET ValgMasterPeriode=0
SET DB_SERVER=Oesmsqlt01\soem
SET DB_NAVN=MDW_UDV4
SET SSISDB_FOLDER=%DB_NAVN%
SET DEST_PATH=\\%DB_SERVER%\files\%DB_NAVN%\Togpersonale_FR_PDS\
SET KOERSEL=test

:STARTEN
CLS
ECHO Script startet klokken: %time% 

P:
SET LOG_PATH=\70_BI\Data_load_kontrol\Prod\Load_step_02_Togpersonale_FR_PDS
setlocal enabledelayedexpansion

ECHO ******************************************************************************
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
REM if Valgindtastnyperiode == 0 så sæt masterperioden som load periode for protal (gøres ved at kalde exec [etl].[loadperiod_protal] uden værdi for perioden

IF %ValgMasterPeriode%==1 SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "exec [etl].[loadperiod_PDS]" 
IF %ValgMasterPeriode%==1 GOTO Valgslut

:GenvalgPeriode
IF  %ValgIndtastNyPeriode%==1 SET /p NYPERIODE="Indtast ny loadperiode yyyymm for Protal :"
IF  %ValgIndtastNyPeriode%==1 SET QUERYTEXT=exec[etl].[loadperiod_PDS]'%NYPERIODE%01'
IF  %ValgIndtastNyPeriode%==1 (ECHO. & SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q %QUERYTEXT%)
IF  %ValgIndtastNyPeriode%==1 CHOICE /C 123 /N /M "Tast 1: Start med valgt periode, 2: Indtast Ny dato eller 3: Fortryd og afslut"

IF %errorlevel%==3 GOTO ExitChosen
IF %errorlevel%==2 SET ValgIndtastNyPeriode=1 & GOTO GenvalgPeriode

:Valgslut

SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @periode varchar(50); select @periode = Value from ods.CTL_Dataload where kilde_system = 'PDS' and Variable = 'Last_Period_Load'; print 'Starter job med PDS LoadPeriode: '+@periode"
ECHO.

SET LOGFILE=LOG\Log_%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%_%KOERSEL%.txt
SET LOGFILE=%LOGFILE: =0%

cd %LOG_PATH%
ECHO Folder:  %cd%  >> %LOGFILE%

pause

SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "exec etl.run_etl_Togpersonale_FR_PDS %SSISDB_FOLDER%, ''" >> %LOGFILE%
ECHO ******************************************************************************
ECHO.
%LOGFILE%
pause

%DEST_PATH%Log\logDiff.txt
%DEST_PATH%Log\logDiffDet.txt
%DEST_PATH%Log\CheckTabeller.txt

:ExitChosen

