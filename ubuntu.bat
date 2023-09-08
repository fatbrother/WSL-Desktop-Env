setlocal

set DISPLAY=:0

@REM get file path
cd /d "%~dp0"

@REM open ./config.xlaunch
start /B /WAIT "" "./config.xlaunch"

@REM run ~/gnome.sh in wsl
start /B /WAIT "" "C:\Windows\System32\wsl.exe" -e bash -lic "~/gnome.sh"

@REM close ./config.xlaunch
taskkill /IM "VcXsrv.exe" /F

endlocal