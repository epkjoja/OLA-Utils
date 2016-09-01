@echo off

set database=sprinthelg2016
set backupPath=D:\backup\
set username=ola
set password=ola
set sleeptime=300

:: Program paths
set mysqldump="C:\Program Files\MySQL\MySQL Server 5.7\bin\mysqldump.exe"
set zip="C:\Program Files\7-Zip\7z.exe"
set timeout="C:\Windows\System32\timeout.exe"
set find="C:\Windows\System32\find.exe"


echo Check the following settings from the script:
echo.
echo *** Database to backup:      %database%
echo *** Path for saving backups: %backupPath%
echo *** Backup interval (sec):   %sleeptime%
echo.
set /p ask=Are these values correct? (y/n) 
echo.
if %ask%==n (
	echo Please change the values in the script and restart it. Exiting!
	%timeout% /T 5
	goto end
)

:igen

:: Get date and time
for /f %%a in ('wmic os get LocalDateTime ^| findstr ^[0-9]') do (set dt=%%a)
set year=%dt:~0,4%
set mon=%dt:~4,2%
set day=%dt:~6,2%
set hour=%dt:~8,2%
set min=%dt:~10,2%
set sec=%dt:~12,2%

set backupName=%database%-%year%%mon%%day%-%hour%%min%%sec%
 
echo Creating a backup of database "%database%" to:
echo "%backupPath%%backupName%.zip"
echo.

:: Do the actual MySQL backup
%mysqldump% --host=localhost --user=%username% --password=%password% --default-character-set=utf8 --tz-utc=TRUE --replace --extended-insert=TRUE --quote-names=TRUE --complete-insert=FALSE --disable-keys=TRUE --delete-master-logs=FALSE --comments --max_allowed_packet=1G --dump-date=TRUE --allow-keywords=FALSE --create-options=TRUE --routines --single-transaction --set-gtid-purged=OFF --databases %database% --result-file="%backupPath%%backupName%.sql"

:: Check for errors returned by backup command
if %ERRORLEVEL% NEQ 0 (
	echo.
	echo ************************************************************
	echo ************************************************************
	echo *******      MYSQLDUMP RETURNED AN ERROR!! - %ERRORLEVEL%      ********
	echo ************************************************************
	echo ************************************************************
)

:: Compress the file
%zip% a -bso0 -sdel "%backupPath%%backupName%.zip" "%backupPath%%backupName%.sql"

:: Show that the backup exists and its size
echo.
dir "%backupPath%%backupName%.*" | %find% "%backupName%"

echo.
echo Done! Sleep until next backup.

%timeout% /T %sleeptime% /NOBREAK
Goto igen

:end
