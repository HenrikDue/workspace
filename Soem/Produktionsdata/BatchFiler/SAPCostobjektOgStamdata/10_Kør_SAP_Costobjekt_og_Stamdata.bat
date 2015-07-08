ECHO OFF
SET ValgIndtastNyPeriode=0
SET ValgMasterPeriode=0
SET DB_SERVER=Oesmsqlt01\soem
SET DB_NAVN=MDW_UDV4
SET SSISDB_FOLDER=%DB_NAVN%
SET SOURCE_DRIVE=P:
SET SOURCE_PATH1="\99_Arkiv\2013 01_Modeldrift\Alle\01_Manuelle_data\"
SET SOURCE_PATH2=\70_BI\Projects\Files\StamData\
SET SOURCE_FILE1=Alle_StamData_BI.xls
SET SOURCE_FILE2="Stamdata Omkostningssted "
SET SOURCE_FILE3="Stamdata Profitcenter "
SET DEST_PATH1=\\%DB_SERVER%\files\%DB_NAVN%\StamData\01_Manuelle_data\
SET DEST_PATH2=\\%DB_SERVER%\files\%DB_NAVN%\StamData\SAP\Excel\
SET DEST_PATH3=\\%DB_SERVER%\files\%DB_NAVN%\SAP_Costobjekt_og_Stamdata\
SET FILE_EXT=.xlsx
SET KOERSEL=test

:STARTEN
CLS
ECHO Script startet klokken: %time% 

P:
SET LOG_PATH=\70_BI\Deployed_packages\Prod\Load_step_03_SAP_Costobjekt_og_Stamdata
md %LOG_PATH%\Log

setlocal enabledelayedexpansion

ECHO ******************************************************************************
ECHO *
SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @periode varchar(50); select @periode = Value from ods.CTL_Dataload where kilde_system = 'Alle' and Variable = 'Master_periode'; print '*  Master LoadPeriode:  ---> '+@periode + ' <--- Tjek periode her.'" 
SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @periode varchar(50); select @periode = Value from ods.CTL_Dataload where kilde_system = 'SAP' and Variable = 'PeriodtoFile'; print '*  SAP LoadPeriode: '+@periode"
ECHO *
ECHO ******************************************************************************
ECHO.

CHOICE /C 123 /N /M "Tast 1: Start med master loadperiode, 2: Indtast Ny dato eller 3: Fortryd og afslut"

IF %errorlevel%==3 GOTO ExitChosen
IF %errorlevel%==2 SET ValgIndtastNyPeriode=1
IF %errorlevel%==1 SET ValgMasterPeriode=1
ECHO.
REM if Valgindtastnyperiode == 0 så sæt masterperioden som load periode for protal (gøres ved at kalde exec [etl].[loadperiod_SAP] uden værdi for perioden

IF %ValgMasterPeriode%==1 SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "SET NOCOUNT ON;exec [etl].[loadperiod_SAP]" 
IF %ValgMasterPeriode%==1 GOTO Valgslut

:GenvalgPeriode
IF  %ValgIndtastNyPeriode%==1 SET /p NYPERIODE="Indtast ny loadperiode yyyymm for Protal :"
IF  %ValgIndtastNyPeriode%==1 SET QUERYTEXT=exec[etl].[loadperiod_SAP]'%NYPERIODE%01'
IF  %ValgIndtastNyPeriode%==1 (ECHO. & SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q %QUERYTEXT%)
IF  %ValgIndtastNyPeriode%==1 CHOICE /C 123 /N /M "Tast 1: Start med valgt periode, 2: Indtast Ny dato eller 3: Fortryd og afslut"

IF %errorlevel%==3 GOTO ExitChosen
IF %errorlevel%==2 SET ValgIndtastNyPeriode=1 & GOTO GenvalgPeriode

:Valgslut
ECHO.
SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @periode varchar(50); select @periode = Value from ods.CTL_Dataload where kilde_system = 'SAP' and Variable = 'PeriodtoFile'; print 'Starter job med SAP LoadPeriode: '+@periode"
ECHO.
for /f %%a in ('SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "SET NOCOUNT ON;select substring(Value,1,6) from ods.CTL_Dataload where kilde_system = 'SAP' and Variable = 'PeriodtoFile'" -h -1') do set PERIODE=%%a

SET LOGFILE=LOG\Log_%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%_%KOERSEL%.txt
SET LOGFILE=%LOGFILE: =0%

cd %LOG_PATH%
ECHO Folder:  %cd%  >> %LOGFILE%

pause

ECHO f | xcopy /y %SOURCE_DRIVE%%SOURCE_PATH1%%SOURCE_FILE1% %DEST_PATH1%%SOURCE_FILE1%
ECHO f | xcopy /y %SOURCE_DRIVE%%SOURCE_PATH2%%SOURCE_FILE2%%PERIODE%%FILE_EXT% %DEST_PATH2%%SOURCE_FILE2%%PERIODE%%FILE_EXT%
ECHO f | xcopy /y %SOURCE_DRIVE%%SOURCE_PATH2%%SOURCE_FILE3%%PERIODE%%FILE_EXT% %DEST_PATH2%%SOURCE_FILE3%%PERIODE%%FILE_EXT%

SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "exec etl.run_etl_SAP_Costobjekt_og_Stamdata %SSISDB_FOLDER%, ''" >> %LOGFILE%
ECHO ******************************************************************************
ECHO.
%LOGFILE%
pause

%DEST_PATH3%\Log\ErrorOutput.txt
%DEST_PATH3%\Log\Error_ProfitcenterConvert.txt

:ExitChosen

