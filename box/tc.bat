@echo off
setlocal EnableDelayedExpansion
title 
color 0f
cls
set /p currentdevice=<box\currentdevice.txt
:rep
set "v="
set /p "v=repare> "
if "%v%"=="repeat.nil" goto loop
if "%v%"=="help" goto hlp
if "%v%"=="hlp" goto hlp
if "%v%"=="sct.dsk" goto dsks
if "%v%"=="ch.dsk" goto select
goto err

:hlp
echo repeat.nil  hlp  sct.dsk  ch.dsk
goto rep

:err
echo Unexpected error.
goto rep

:dsks
set "dsks="
set /p "dsks=select> "
if not exist "%dsks%" goto err
type "%dsks%"
goto rep

:goto loop
exit

:select
set "select="
set /p "select=select> "
if not defined select goto rep
<nul set /p "=!select!" > box\currentdevice.txt
goto rep