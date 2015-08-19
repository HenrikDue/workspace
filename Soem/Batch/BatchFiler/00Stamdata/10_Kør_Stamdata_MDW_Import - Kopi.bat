ECHO OFF
CLS
ECHO Script startet klokken: %time% 

P:

REM ************************************************************************
REM konfiguration check start
REM ************************************************************************
SET SSIS_PATH=\70_BI\Deployed_packages\Prod\Flow_Stamdata_MDW

setlocal enabledelayedexpansion
set COUNTER=1

for /f "tokens=3 delims=><" %%a in ('type %SSIS_PATH%\ServerOgDatabase.dtsConfig ^| find "<ConfiguredValue>"') do (
  IF !COUNTER!==1 (SET DB_NAVN=%%a)
  IF !COUNTER!==2 (SET DB_SERVER=%%a)
  REM /* hvis der er flere variabel indsættes det her */
  SET /a COUNTER=!COUNTER!+1
  )

ECHO ***********************************************************************
ECHO * 
ECHO *  Server: %DB_SERVER%
ECHO *  Database: %DB_NAVN%
ECHO *  SSIS pakke sti: %SSIS_PATH%
ECHO *
ECHO ***********************************************************************

CHOICE /C SF /N /M "Tast S (Start) eller F (Fortryd)"
IF %errorlevel%==2 GOTO ExitChosen

SET FejlSum=0
SET LOGFILE=LOG\Log_%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%.txt
SET LOGFILE=%LOGFILE: =0%

ECHO Forventet batch varighed: 00:00:18

cd %SSIS_PATH%
REM ECHO. & ECHO Folder:  %cd% 
ECHO Folder:  %cd%  >> %LOGFILE%



SET Pakkefil="020_EX_MD_G_STAM_Ejendomme.dtsx"
ECHO. & ECHO %Pakkefil% Startet %time% & ECHO. >>%LOGFILE% & ECHO %Pakkefil% Startet >> %LOGFILE%
"C:\Program Files\Microsoft SQL Server\100\DTS\Binn\DTExec.exe" /REPORTING E  /FILE %Pakkefil% >> %LOGFILE%
IF NOT %ERRORLEVEL%==0 (ECHO %Pakkefil% Stoppet - Der var FEJL & SET /a FejlSum=Fejlsum+1 & GOTO TheEnd) ELSE (ECHO %Pakkefil% Afsluttet - Ok)


SET Pakkefil="040_EX_MD_G_STAM_Stationer.dtsx"
ECHO. & ECHO %Pakkefil% Startet %time% & ECHO. >>%LOGFILE% & ECHO %Pakkefil% Startet >> %LOGFILE%
"C:\Program Files\Microsoft SQL Server\100\DTS\Binn\DTExec.exe" /REPORTING E  /FILE %Pakkefil% >> %LOGFILE%
IF NOT %ERRORLEVEL%==0 (ECHO %Pakkefil% Stoppet - Der var FEJL & SET /a FejlSum=Fejlsum+1 & GOTO TheEnd) ELSE (ECHO %Pakkefil% Afsluttet - Ok)

SET Pakkefil="045_EX_MD_G_STAM_Ejendomme_Process.dtsx"
ECHO. & ECHO %Pakkefil% Startet %time% & ECHO. >>%LOGFILE% & ECHO %Pakkefil% Startet >> %LOGFILE%
"C:\Program Files\Microsoft SQL Server\100\DTS\Binn\DTExec.exe" /REPORTING E  /FILE %Pakkefil% >> %LOGFILE%
IF NOT %ERRORLEVEL%==0 (ECHO %Pakkefil% Stoppet - Der var FEJL & SET /a FejlSum=Fejlsum+1 & GOTO TheEnd) ELSE (ECHO %Pakkefil% Afsluttet - Ok)


ECHO ANTAL FEJL: %Fejlsum% >> %LOGFILE%


:TheEnd
ECHO. & ECHO Batch Afsluttet %TIME%
ECHO ANTAL FEJL: %Fejlsum% & ECHO ANTAL FEJL: %Fejlsum% >> %LOGFILE%

IF NOT %Fejlsum%==0 (%LOGFILE% & GOTO TheEndUdenSucces) 

REM ELSE:
ECHO 10_Kør_S_Tog_Import er afsluttet uden fejl - %Time%  > Slut.txt
ECHO.  >> slut.txt
Slut.txt

:TheEndUdenSucces

pause

:ExitChosen
