@echo off
@setlocal enableextensions & C:\WINDOWS\system32\windowspowershell\v1.0\powershell.exe -noexit -command $env:PATH+=';';$env:PATH+=$(cat %~dp0\cfg\default.ini).split('=')[1]