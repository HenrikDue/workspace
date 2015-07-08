ECHO OFF
SET ValgIndtastNyPeriode=0
SET ValgMasterPeriode=0
SET DB_SERVER=Oesmsqlt01\soem
SET DB_NAVN=MDW_UDV4
SET SSISDB_FOLDER=%DB_NAVN%
SET SOURCE_DRIVE=P:
SET SOURCE_PATH=P:\70_BI\Projects\Files\RejseData_RIM\
SET SOURCE_FILE1=GD_R_REJSERINDT’GTER
SET SOURCE_FILE2=GD_R_RejseIndt‘gter_Togsystem_FR

SET DEST_PATH=\\%DB_SERVER%\files\%DB_NAVN%\RejseData_RIM\
SET FILE_EXT=.xlsx
SET KOERSEL=test

:STARTEN
CLS
ECHO Script startet klokken: %time% 

P:
SET LOG_PATH=\70_BI\Data_load_kontrol\Prod\Load_step_10_Resterende_RD_Data\
md %LOG_PATH%\Log

setlocal enabledelayedexpansion

ECHO ******************************************************************************
ECHO *
SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @periode varchar(50); select @periode = Value from ods.CTL_Dataload where kilde_system = 'Alle' and Variable = 'Master_periode'; print '*  Master LoadPeriode:  ---> '+@periode + ' <--- Tjek periode her.'" 
SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @periode varchar(50); select @periode = substring(value,1,6) from ods.CTL_Dataload where kilde_system = 'Alle' and Variable = 'Model_Periode'; print '*  GD LoadPeriode: '+@periode"
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

SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @periode varchar(50); select @periode = substring(value,1,6) from ods.CTL_Dataload where kilde_system = 'Alle' and Variable = 'Model_Periode'; print '*  GD LoadPeriode: '+@periode"
ECHO.
for /f %%a in ('SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "SET NOCOUNT ON;select Value from ods.CTL_Dataload where kilde_system = 'Alle' and Variable = 'Model_Periode'" -h -1') do set PERIODE=%%a

SET LOGFILE=LOG\Log_RejseData_RIM_%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%_%KOERSEL%.txt
SET LOGFILE=%LOGFILE: =0%

cd %LOG_PATH%
ECHO Folder:  %cd%  >> %LOGFILE%
pause

ECHO f | xcopy /y %SOURCE_PATH%%SOURCE_FILE1%%FILE_EXT% %DEST_PATH%%SOURCE_FILE1%%FILE_EXT% >> %LOGFILE%
ECHO f | xcopy /y %SOURCE_PATH%%SOURCE_FILE2%%FILE_EXT% %DEST_PATH%%SOURCE_FILE2%%FILE_EXT% >> %LOGFILE%

SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "exec etl.run_etl_RIM_RejseData %SSISDB_FOLDER%, ''" >> %LOGFILE%
ECHO ******************************************************************************
ECHO.
%LOGFILE%
pause

:ExitChosen

