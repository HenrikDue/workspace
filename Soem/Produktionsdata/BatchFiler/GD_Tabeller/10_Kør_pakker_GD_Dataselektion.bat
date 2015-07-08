ECHO OFF
SET DB_SERVER=Oesmsqlt01\soem
SET DB_NAVN=MDW_UDV4
SET SSISDB_FOLDER=%DB_NAVN%
SET KOERSEL=test

:STARTEN
CLS
ECHO Script startet klokken: %time% 

P:
SET LOG_PATH=\70_BI\Data_load_kontrol\Prod\Load_step_11_Overf›else_til_GD\
md %LOG_PATH%\Log

setlocal enabledelayedexpansion

ECHO ******************************************************************************
ECHO *
SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @periode varchar(50); select @periode = Value from ods.CTL_Dataload where kilde_system = 'Alle' and Variable = 'Model_Periode'; print '*  GD load periode: '+@periode"
ECHO *
ECHO ******************************************************************************
ECHO.

CHOICE /C SF /N /M "Tast S (Start) eller F (Fortryd)"
IF %errorlevel%==2 GOTO ExitChosen

ECHO.

SET LOGFILE=LOG\Log_FPC_L›nsum_%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%_%KOERSEL%.txt
SET LOGFILE=%LOGFILE: =0%

cd %LOG_PATH%
ECHO Folder:  %cd%  >> %LOGFILE%

SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "exec etl.run_etl_Load_GD_tabeller %SSISDB_FOLDER%, ''" >> %LOGFILE%
ECHO ******************************************************************************
ECHO.
%LOGFILE%
pause

:ExitChosen

