echo off

SET DB_SERVER=Oesmsqlt01\soem
SET DB_NAVN=MDW_UDV4
SET SOURCE_DRIVE=P:
SET SOURCE_PATH=\70_BI\Projects\Files\StamData\
SET SOURCE_FILE1=EX_MD_G_STAM_Depoter.xlsx
SET SOURCE_FILE2=EX_MD_G_STAM_Ejendomme_Kategori.xlsx
SET SOURCE_FILE3=EX_MD_G_STAM_Ejendomme.xlsx
SET SOURCE_FILE4=EX_MD_G_STAM_Litra.xlsx
SET SOURCE_FILE5=EX_MD_G_STAM_Stationer.xlsx
SET SOURCE_FILE6=EX_MD_G_STAM_Timer_.xlsx
SET SOURCE_FILE7=EX_MD_G_STAM_Togsystem.xls
SET DEST_PATH=\\oesmsqlt01\soem\files\%DB_NAVN%\StamData\


ECHO ******************************************************************************
ECHO *  Server: %DB_SERVER%
ECHO *  Database: %DB_NAVN% 
ECHO *  F�lgende filer kopieres til %DB_SERVER%: 
ECHO *  %SOURCE_FILE1% 
ECHO *  %SOURCE_FILE2%
ECHO *  %SOURCE_FILE3%
ECHO *  %SOURCE_FILE4%
ECHO *  %SOURCE_FILE5%
ECHO *  %SOURCE_FILE6%
ECHO *  %SOURCE_FILE7%
ECHO *
ECHO f | xcopy /y %SOURCE_DRIVE%%SOURCE_PATH%%SOURCE_FILE1% %DEST_PATH%%SOURCE_FILE1%
ECHO f | xcopy /y %SOURCE_DRIVE%%SOURCE_PATH%%SOURCE_FILE2% %DEST_PATH%%SOURCE_FILE2%
ECHO f | xcopy /y %SOURCE_DRIVE%%SOURCE_PATH%%SOURCE_FILE3% %DEST_PATH%%SOURCE_FILE3%
ECHO f | xcopy /y %SOURCE_DRIVE%%SOURCE_PATH%%SOURCE_FILE4% %DEST_PATH%%SOURCE_FILE4%
ECHO f | xcopy /y %SOURCE_DRIVE%%SOURCE_PATH%%SOURCE_FILE5% %DEST_PATH%%SOURCE_FILE5%
ECHO f | xcopy /y %SOURCE_DRIVE%%SOURCE_PATH%%SOURCE_FILE6% %DEST_PATH%%SOURCE_FILE6%
ECHO f | xcopy /y %SOURCE_DRIVE%%SOURCE_PATH%%SOURCE_FILE7% %DEST_PATH%%SOURCE_FILE7%
SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "exec etl.run_etl_stamdata_mdw ''" > Log\Log.txt
ECHO *
ECHO ******************************************************************************
Log\Log.txt
pause