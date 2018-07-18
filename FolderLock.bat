cls
@ECHO OFF
title Folder <<Folder name>>
if EXIST "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" goto UNLOCK
if NOT EXIST <<Folder_name>> goto MKHIDDEN

:CONFIRM
echo Are you sure u want to Lock the folder(Y/N)
set/p "cho=>"
if %cho%==Y goto LOCK
if %cho%==y goto LOCK
if %cho%==n goto END
if %cho%==N goto END
echo Invalid choice.
goto CONFIRM

:LOCK
ren <<Folder_name>> "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
attrib +h +s "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
echo Folder locked
goto End

:UNLOCK
set "psCommand=powershell -Command "$pword = read-host 'Enter Password to unlock folder' -AsSecureString ; ^
      $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
            [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
 for /f "usebackq delims=" %%p in (`%psCommand%`) do set pass=%%p
if NOT %pass%==<<Enter_Your_Password_Here>> goto FAIL
attrib -h -s "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
ren "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" <<Folder_name>>
echo Folder Unlocked successfully
goto End

:FAIL
echo Invalid password
goto end

:MKHIDDEN
md <<Folder_name>>
echo Locker created successfully
goto End

:End
PAUSE