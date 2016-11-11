@echo off
copy /Y NUL "c:\%USERPROFILE%\.supracmd.writable" > NUL 2>&1 && set WRITEOK=TRUE
IF NOT DEFINED  WRITEOK call :make_local_home
set gitpath="C:\Program Files\Git\usr\bin\bash.exe"
::set path=%path%;%~dp0..\bin;"C:\Program Files\Git\bin";
dir %USERPROFILE%\.bash_profile > nul 2>&1 || call :set_bash_profile
findstr PATH %USERPROFILE%\.bash_profile > nul 2>&1 || call :set_paths
dir %gitpath% > nul 2>&1 && %gitpath% --login -i || call :install_git
goto:eof


:make_local_home
set USERPROFILE="%~dp0\..\.Users\%USERNAME%"
IF NOT EXIST "%USERPROFILE%" mkdir %USERPROFILE% > nul 2>&1
goto:eof

:set_bash_profile
echo Initializing bash profile ...
echo blue="\033[34m" >> %USERPROFILE%\.bash_profile
echo On_White='\e[47m'  >> %USERPROFILE%\.bash_profile
echo close_escape="^\033[0m" >> %USERPROFILE%\.bash_profile
echo echo -e " " >> %USERPROFILE%\.bash_profile
echo echo -e New to Git?  >> %USERPROFILE%\.bash_profile
echo echo -e Be sure to check out git - the simple guide at  >> %USERPROFILE%\.bash_profile
echo echo -e "${blue}${On_White}http://rogerdudler.github.io/git-guide/" >> %USERPROFILE%\.bash_profile
echo echo -e "\e[0m" >> %USERPROFILE%\.bash_profile
goto:eof

:set_paths
echo Adding git paths to bash profile
echo. >> %USERPROFILE%\.bash_profile
echo export PATH=$PATH:/c/Program\ Files/Git/bin >> %USERPROFILE%\.bash_profile
echo export PATH=$PATH:/c/Program\ Files\ \(x86\)/Git/bin >> %USERPROFILE%\.bash_profile
echo export PATH=$PATH:/c/Python27  >> %USERPROFILE%\.bash_profile
echo export PATH=$PATH:/c/Python27/Scripts   >> %USERPROFILE%\.bash_profile
goto:eof

:install_git
dir %gitpath% > nul 2>&1 && goto:eof
echo Could not find git executable at %gitpath%
echo Either you need to install git or the path defined for the git exucutable is wrong.
echo If the latter is the case, simply modify this script accordingly (%~fn0), otherwise proceed below:
echo Here's what you can do to install:
echo 1. Go here: https://git-for-windows.github.io/
echo 2. Install, and when prompted for options, choose these below:
echo 'Use Git from Bash only'
echo 'Use OpenSSH'
echo 'Checkout Windows-style, commit Unix-style line endings'
echo You can accept default options thereafter ...
pause
goto:eof
