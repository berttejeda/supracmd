@echo off
set python_path="C:\Python27\python.exe"
dir %python_path% > nul 2>&1 && %python_path% || call :install_python %python_path%
goto:eof

:install_python
dir %python_path% > nul 2>&1 && goto:eof
echo Could not find python 2.7 executable at %~1
echo Either you need to install python 2.7
echo or the path defined for the python exucutable is wrong.
echo If the latter is the case, 
echo simply modify this script accordingly (%~fn0)
echo Otherwise, proceed below:
echo Here's what you can do to install:
echo 1. Go here: https://www.python.org/downloads/windows/
echo 2. Choose python 2.7.x and download
echo 3. Install, you dingbat
pause
goto:eof
