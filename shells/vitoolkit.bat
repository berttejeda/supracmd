@echo off
set vitoolkit_path="C:\Program Files\VMware\Infrastructure\VIToolkitForWindows\vim.psc1"

dir "%vitoolkit_path%" > nul 2>&1 && C:\WINDOWS\system32\windowspowershell\v1.0\powershell.exe -PSConsoleFile "C:\Program Files\VMware\Infrastructure\VIToolkitForWindows\vim.psc1" -NoExit -Command ". \"C:\Program Files\VMware\Infrastructure\VIToolkitForWindows\Scripts\Initialize-VIToolkitEnvironment.ps1\" " || call :install_vitoolkit %vitoolkit_path%
goto:eof

:install_vitoolkit
dir %vitoolkit_path% > nul 2>&1 && goto:eof
echo Could not find vitoolkit console at %~1
echo Either you need to install vitoolkit
echo or the path defined for vitoolkit is wrong.
echo If the latter is the case, 
echo simply modify this script accordingly (%~fn0)
echo Otherwise, proceed below:
echo Here's what you can do to install:
echo 1. Go here: https://www.vmware.com/support/developer/PowerCLI/index.html
echo 2. Download
echo 3. Install, you dingbat
pause
goto:eof
