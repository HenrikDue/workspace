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
SET SSIS_PATH=\70_BI\Deployed_packages\Prod\Flow_PDS_S-tog


 
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
SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @periode varchar(50); select @periode = substring(value,1,6) from ods.CTL_Dataload where kilde_system = 'S-tog PDS' and Variable = 'Load_Period'; print '*  S-tog PDS LoadPeriode: '+@periode"
ECHO *
ECHO ******************************************************************************
ECHO.

CHOICE /C 123 /N /M "Tast 1: Start med master loadperiode, 2: Indtast Ny dato eller 3: Afslut"

IF %errorlevel%==3 GOTO ExitChosen
IF %errorlevel%==2 SET ValgIndtastNyPeriode=1
IF %errorlevel%==1 SET ValgMasterPeriode=1
ECHO.

IF %ValgMasterPeriode%==1 SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "exec [etl].[loadperiod_s_tog_PDS]" 
IF %ValgMasterPeriode%==1 GOTO Valgslut

:GenvalgPeriode
IF  %ValgIndtastNyPeriode%==1 SET /p NYPERIODE="Indtast ny loadperiode yyyymm for S-tog PDS:"
IF  %ValgIndtastNyPeriode%==1 SET QUERYTEXT=exec[etl].[loadperiod_s_tog_PDS]'%NYPERIODE%01'
IF  %ValgIndtastNyPeriode%==1 (ECHO. & SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q %QUERYTEXT%)
IF  %ValgIndtastNyPeriode%==1 CHOICE /C 123 /N /M "Tast 1: Start med valgt periode, 2: Indtast Ny dato eller 3: Afslut"

IF %errorlevel%==3 GOTO ExitChosen
IF %errorlevel%==2 SET ValgIndtastNyPeriode=1 & GOTO GenvalgPeriode

:Valgslut

SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @periode varchar(50); select @periode = substring(value,1,6) from ods.CTL_Dataload where kilde_system = 'S-tog PDS' and Variable = 'Load_Period'; print 'Starter med LoadPeriode: '+@periode"

SET FejlSum=0
SET LOGFILE=LOG\Log_%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%.txt
SET LOGFILE=%LOGFILE: =0%


cd %SSIS_PATH%
REM ECHO. & ECHO Folder:  %cd% 
ECHO Folder:  %cd%  >> %LOGFILE%
PAUSE

SET Pakkefil="10_ODS_Hent_PDS_Data.dtsx"
ECHO. & ECHO %Pakkefil% Startet %time% (00:02:30) & ECHO. >>%LOGFILE% & ECHO %Pakkefil% Startet >> %LOGFILE%
"C:\Program Files\Microsoft SQL Server\100\DTS\Binn\DTExec.exe" /REPORTING E  /FILE %Pakkefil% >> %LOGFILE%
IF NOT %ERRORLEVEL%==0 (ECHO %Pakkefil% Stoppet - Der var FEJL & SET /a FejlSum=Fejlsum+1 & GOTO TheEnd) ELSE (ECHO %Pakkefil% Afsluttet - Ok)

SET Pakkefil="15_ODS_Straekning_Mapping.dtsx"
ECHO. & ECHO %Pakkefil% Startet %time% (00:01:30) & ECHO. >>%LOGFILE% & ECHO %Pakkefil% Startet >> %LOGFILE%
"C:\Program Files\Microsoft SQL Server\100\DTS\Binn\DTExec.exe" /REPORTING E  /FILE %Pakkefil% >> %LOGFILE%
IF NOT %ERRORLEVEL%==0 (ECHO %Pakkefil% Stoppet - Der var FEJL & SET /a FejlSum=Fejlsum+1 & GOTO TheEnd) ELSE (ECHO %Pakkefil% Afsluttet - Ok)

SET Pakkefil="20_ODS_Straekning_varighedsfordeling.dtsx"
ECHO. & ECHO %Pakkefil% Startet %time% & ECHO. >>%LOGFILE% & ECHO %Pakkefil% Startet >> %LOGFILE%
"C:\Program Files\Microsoft SQL Server\100\DTS\Binn\DTExec.exe" /REPORTING E  /FILE %Pakkefil% >> %LOGFILE%
IF NOT %ERRORLEVEL%==0 (ECHO %Pakkefil% Stoppet - Der var FEJL & SET /a FejlSum=Fejlsum+1 & GOTO TheEnd) ELSE (ECHO %Pakkefil% Afsluttet - Ok)

SET Pakkefil="30_EDW_DI_S_Opgave_Straekninger.dtsx"
ECHO. & ECHO %Pakkefil% Startet %time% & ECHO. >>%LOGFILE% & ECHO %Pakkefil% Startet >> %LOGFILE%
"C:\Program Files\Microsoft SQL Server\100\DTS\Binn\DTExec.exe" /REPORTING E  /FILE %Pakkefil% >> %LOGFILE%
IF NOT %ERRORLEVEL%==0 (ECHO %Pakkefil% Stoppet - Der var FEJL & SET /a FejlSum=Fejlsum+1 & GOTO TheEnd) ELSE (ECHO %Pakkefil% Afsluttet - Ok)

SET Pakkefil="35_EDW_DI_S_Opgave_Lokofoerer.dtsx"
ECHO. & ECHO %Pakkefil% Startet %time% & ECHO. >>%LOGFILE% & ECHO %Pakkefil% Startet >> %LOGFILE%
"C:\Program Files\Microsoft SQL Server\100\DTS\Binn\DTExec.exe" /REPORTING E  /FILE %Pakkefil% >> %LOGFILE%
IF NOT %ERRORLEVEL%==0 (ECHO %Pakkefil% Stoppet - Der var FEJL & SET /a FejlSum=Fejlsum+1 & GOTO TheEnd) ELSE (ECHO %Pakkefil% Afsluttet - Ok)

SET Pakkefil="40_EDW_FT_Lokopersonale_S_tog.dtsx"
ECHO. & ECHO %Pakkefil% Startet %time% & ECHO. >>%LOGFILE% & ECHO %Pakkefil% Startet >> %LOGFILE%
"C:\Program Files\Microsoft SQL Server\100\DTS\Binn\DTExec.exe" /REPORTING E  /FILE %Pakkefil% >> %LOGFILE%
IF NOT %ERRORLEVEL%==0 (ECHO %Pakkefil% Stoppet - Der var FEJL & SET /a FejlSum=Fejlsum+1 & GOTO TheEnd) ELSE (ECHO %Pakkefil% Afsluttet - Ok)

SET Pakkefil="60_log_differencer_til_fil.dtsx"
ECHO. & ECHO %Pakkefil% Startet %time% & ECHO. >>%LOGFILE% & ECHO %Pakkefil% Startet >> %LOGFILE%
"C:\Program Files\Microsoft SQL Server\100\DTS\Binn\DTExec.exe" /REPORTING E  /FILE %Pakkefil% >> %LOGFILE%
IF NOT %ERRORLEVEL%==0 (ECHO %Pakkefil% Stoppet - Der var FEJL & SET /a FejlSum=Fejlsum+1 & GOTO TheEnd) ELSE (ECHO %Pakkefil% Afsluttet - Ok)


logDiff.txt
logDiffDet.txt
CheckTabellerTogproduktion.txt


:checkpoint


ECHO ANTAL FEJL: %Fejlsum% >> %LOGFILE%


:TheEnd
ECHO. & ECHO Batch Afsluttet %TIME%
ECHO ANTAL FEJL: %Fejlsum% & ECHO ANTAL FEJL: %Fejlsum% >> %LOGFILE%

IF NOT %Fejlsum%==0 (%LOGFILE% & GOTO TheEndUdenSucces) 

REM ELSE:
ECHO 10_S_Tog_Import er afsluttet uden fejl - %Time%  > Slut.txt
ECHO.  >> slut.txt
Slut.txt

:TheEndUdenSucces


pause

:ExitChosen

