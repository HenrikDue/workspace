ECHO OFF
SET ValgIndtastNyPeriode=0
SET ValgMasterPeriode=0
:STARTEN
CLS
ECHO Script startet klokken: %time% 

P:

REM ************************************************************************
REM konfiguration check start
REM Aflæs server og database i configfilen ServerOgDatabase.dtsConfig
REM ************************************************************************
SET SSIS_PATH=\70_BI\Deployed_packages\Prod\Flow_SAP_Costobjekt_og_Stamdata

 
setlocal enabledelayedexpansion
set COUNTER=1

for /f "tokens=3 delims=><" %%a in ('type %SSIS_PATH%\ServerOgDatabase.dtsConfig ^| find "<ConfiguredValue>"') do (
  IF !COUNTER!==1 (SET DB_NAVN=%%a)
  IF !COUNTER!==2 (SET DB_SERVER=%%a)
  REM /* hvis der er flere variabel indsættes det her */
  SET /a COUNTER=!COUNTER!+1
  )

ECHO.
ECHO ******************************************************************************
ECHO * 
ECHO *  Server og databasenavn hentes i SSIS config-fil i denne sti: 
ECHO *	%SSIS_PATH%
ECHO *
ECHO *  Server: %DB_SERVER%
ECHO *  Database: %DB_NAVN%
ECHO *
SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @periode varchar(50); select @periode = Value from ods.CTL_Dataload where kilde_system = 'Alle' and Variable = 'Master_periode'; print '*  Master LoadPeriode:  ---> '+@periode + ' <--- Tjek periode her.'" 
SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @periode varchar(50); select @periode = Value from ods.CTL_Dataload where kilde_system = 'SAP' and Variable = 'PeriodtoFile'; print '*  SAP LoadPeriode: '+@periode"
ECHO *
ECHO ******************************************************************************
ECHO.

CHOICE /C 123 /N /M "Tast 1: Start med master loadperiode, 2: Indtast Ny dato eller 3: Afslut"

IF %errorlevel%==3 GOTO ExitChosen
IF %errorlevel%==2 SET ValgIndtastNyPeriode=1
IF %errorlevel%==1 SET ValgMasterPeriode=1
ECHO.
REM if Valgindtastnyperiode == 0 så sæt masterperioden som load periode for SAP (gøres ved at kalde exec [etl].[loadperiod_SAP] uden værdi for perioden

IF %ValgMasterPeriode%==1 SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "exec [etl].[loadperiod_SAP]" 
IF %ValgMasterPeriode%==1 GOTO Valgslut

:GenvalgPeriode
IF  %ValgIndtastNyPeriode%==1 SET /p NYPERIODE="Indtast ny loadperiode yyyymm for SAP :"
IF  %ValgIndtastNyPeriode%==1 SET QUERYTEXT=exec[etl].[loadperiod_SAP]'%NYPERIODE%01'
IF  %ValgIndtastNyPeriode%==1 (ECHO. & SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q %QUERYTEXT%)
IF  %ValgIndtastNyPeriode%==1 CHOICE /C 123 /N /M "Tast 1: Start med valgt periode, 2: Indtast Ny dato eller 3: Afslut"

IF %errorlevel%==3 GOTO ExitChosen
IF %errorlevel%==2 SET ValgIndtastNyPeriode=1 & GOTO GenvalgPeriode

:Valgslut

SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @periode varchar(50); select @periode = Value from ods.CTL_Dataload where kilde_system = 'SAP' and Variable = 'PeriodtoFile'; print 'Starter job med SAP LoadPeriode: '+@periode"

SET FejlSum=0
SET LOGFILE=LOG\Log_%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%.txt
SET LOGFILE=%LOGFILE: =0%


cd %SSIS_PATH%
REM ECHO. & ECHO Folder:  %cd% 
ECHO Folder:  %cd%  >> %LOGFILE%

pause

REM GOTO checkpoint

SET Pakkefil="110_ODS_DL_Costobject.dtsx"
ECHO. & ECHO %Pakkefil% Startet %time% & ECHO. >>%LOGFILE% & ECHO %Pakkefil% Startet >> %LOGFILE%
"C:\Program Files\Microsoft SQL Server\100\DTS\Binn\DTExec.exe" /REPORTING E  /FILE %Pakkefil% >> %LOGFILE%
IF NOT %ERRORLEVEL%==0 (ECHO %Pakkefil% Stoppet - Der var FEJL & SET /a FejlSum=Fejlsum+1 & GOTO TheEnd) ELSE (ECHO %Pakkefil% Afsluttet - Ok)

SET Pakkefil="120_EDW_TR1_GD_Dim_Costobject.dtsx"
ECHO. & ECHO %Pakkefil% Startet %time% & ECHO. >>%LOGFILE% & ECHO %Pakkefil% Startet >> %LOGFILE%
"C:\Program Files\Microsoft SQL Server\100\DTS\Binn\DTExec.exe" /REPORTING E  /FILE %Pakkefil% >> %LOGFILE%
IF NOT %ERRORLEVEL%==0 (ECHO %Pakkefil% Stoppet - Der var FEJL & SET /a FejlSum=Fejlsum+1 & GOTO TheEnd) ELSE (ECHO %Pakkefil% Afsluttet - Ok)

SET Pakkefil="130_EDW_TR2_POEM_costobject.dtsx"
ECHO. & ECHO %Pakkefil% Startet %time% & ECHO. >>%LOGFILE% & ECHO %Pakkefil% Startet >> %LOGFILE%
"C:\Program Files\Microsoft SQL Server\100\DTS\Binn\DTExec.exe" /REPORTING E  /FILE %Pakkefil% >> %LOGFILE%
IF NOT %ERRORLEVEL%==0 (ECHO %Pakkefil% Stoppet - Der var FEJL & SET /a FejlSum=Fejlsum+1 & GOTO TheEnd) ELSE (ECHO %Pakkefil% Afsluttet - Ok)

SET Pakkefil="140_EDW_DI_Costobject.dtsx"
ECHO. & ECHO %Pakkefil% Startet %time% & ECHO. >>%LOGFILE% & ECHO %Pakkefil% Startet >> %LOGFILE%
"C:\Program Files\Microsoft SQL Server\100\DTS\Binn\DTExec.exe" /REPORTING E  /FILE %Pakkefil% >> %LOGFILE%
IF NOT %ERRORLEVEL%==0 (ECHO %Pakkefil% Stoppet - Der var FEJL & SET /a FejlSum=Fejlsum+1 & GOTO TheEnd) ELSE (ECHO %Pakkefil% Afsluttet - Ok)

SET Pakkefil="205_ods_Konverter_omksted_EXCEL_TIL_CSV.dtsx"
ECHO. & ECHO %Pakkefil% Startet %time% & ECHO. >>%LOGFILE% & ECHO %Pakkefil% Startet >> %LOGFILE%
"C:\Program Files\Microsoft SQL Server\100\DTS\Binn\DTExec.exe" /REPORTING E  /FILE %Pakkefil% >> %LOGFILE%
IF NOT %ERRORLEVEL%==0 (ECHO %Pakkefil% Stoppet - Der var FEJL & SET /a FejlSum=Fejlsum+1 & GOTO TheEnd) ELSE (ECHO %Pakkefil% Afsluttet - Ok)

SET Pakkefil="210_ods_dl_SAP_Omksted.dtsx"
ECHO. & ECHO %Pakkefil% Startet %time% & ECHO. >>%LOGFILE% & ECHO %Pakkefil% Startet >> %LOGFILE%
"C:\Program Files\Microsoft SQL Server\100\DTS\Binn\DTExec.exe" /REPORTING E  /FILE %Pakkefil% >> %LOGFILE%
IF NOT %ERRORLEVEL%==0 (ECHO %Pakkefil% Stoppet - Der var FEJL & SET /a FejlSum=Fejlsum+1 & GOTO TheEnd) ELSE (ECHO %Pakkefil% Afsluttet - Ok)

SET Pakkefil="215_ods_Konverter_Profitcenter_EXCEL_TIL_CSV.dtsx"
ECHO. & ECHO %Pakkefil% Startet %time% & ECHO. >>%LOGFILE% & ECHO %Pakkefil% Startet >> %LOGFILE%
"C:\Program Files\Microsoft SQL Server\100\DTS\Binn\DTExec.exe" /REPORTING E  /FILE %Pakkefil% >> %LOGFILE%
IF NOT %ERRORLEVEL%==0 (ECHO %Pakkefil% Stoppet - Der var FEJL & SET /a FejlSum=Fejlsum+1 & GOTO TheEnd) ELSE (ECHO %Pakkefil% Afsluttet - Ok)

SET Pakkefil="220_ods_dl_SAP_Profitcenter.dtsx"
ECHO. & ECHO %Pakkefil% Startet %time% & ECHO. >>%LOGFILE% & ECHO %Pakkefil% Startet >> %LOGFILE%
"C:\Program Files\Microsoft SQL Server\100\DTS\Binn\DTExec.exe" /REPORTING E  /FILE %Pakkefil% >> %LOGFILE%
IF NOT %ERRORLEVEL%==0 (ECHO %Pakkefil% Stoppet - Der var FEJL & SET /a FejlSum=Fejlsum+1 & GOTO TheEnd) ELSE (ECHO %Pakkefil% Afsluttet - Ok)

SET Pakkefil="230_edw_tr1_dim_Omksted.dtsx"
ECHO. & ECHO %Pakkefil% Startet %time% & ECHO. >>%LOGFILE% & ECHO %Pakkefil% Startet >> %LOGFILE%
"C:\Program Files\Microsoft SQL Server\100\DTS\Binn\DTExec.exe" /REPORTING E  /FILE %Pakkefil% >> %LOGFILE%
IF NOT %ERRORLEVEL%==0 (ECHO %Pakkefil% Stoppet - Der var FEJL & SET /a FejlSum=Fejlsum+1 & GOTO TheEnd) ELSE (ECHO %Pakkefil% Afsluttet - Ok)

SET Pakkefil="240_edw_tr1_dim_Profitcenter.dtsx"
ECHO. & ECHO %Pakkefil% Startet %time% & ECHO. >>%LOGFILE% & ECHO %Pakkefil% Startet >> %LOGFILE%
"C:\Program Files\Microsoft SQL Server\100\DTS\Binn\DTExec.exe" /REPORTING E  /FILE %Pakkefil% >> %LOGFILE%
IF NOT %ERRORLEVEL%==0 (ECHO %Pakkefil% Stoppet - Der var FEJL & SET /a FejlSum=Fejlsum+1 & GOTO TheEnd) ELSE (ECHO %Pakkefil% Afsluttet - Ok)

SET Pakkefil="300_edw_load_Dim_Profitcenter_og_omkostningssted_ny.dtsx"
ECHO. & ECHO %Pakkefil% Startet %time% & ECHO. >>%LOGFILE% & ECHO %Pakkefil% Startet >> %LOGFILE%
"C:\Program Files\Microsoft SQL Server\100\DTS\Binn\DTExec.exe" /REPORTING E  /FILE %Pakkefil% >> %LOGFILE%
IF NOT %ERRORLEVEL%==0 (ECHO %Pakkefil% Stoppet - Der var FEJL & SET /a FejlSum=Fejlsum+1 & GOTO TheEnd) ELSE (ECHO %Pakkefil% Afsluttet - Ok)



:checkpoint


ECHO ANTAL FEJL: %Fejlsum% >> %LOGFILE%


:TheEnd
ECHO. & ECHO Batch Afsluttet %TIME%
ECHO ANTAL FEJL: %Fejlsum% & ECHO ANTAL FEJL: %Fejlsum% >> %LOGFILE%

IF NOT %Fejlsum%==0 (%LOGFILE% & GOTO TheEndUdenSucces) 

REM ELSE:
ECHO 10_Kør_SAP_Costobjekt_og_Stamdata er afsluttet uden fejl - %Time%  > Slut.txt
ECHO.  >> slut.txt
Slut.txt

:TheEndUdenSucces


pause

:ExitChosen

