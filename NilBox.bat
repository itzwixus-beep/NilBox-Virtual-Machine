chcp 65001 >nul
mode 76,23
setlocal EnableDelayedExpansion
:reset2
call sys.bat
:reset
@echo off
title BIOS
color 0F
set /p currentdevice=<cfg\currentdevice.txt
mode 76,23
echo **** BIOS ****
echo.
echo Current Device: [%currentdevice%]
echo NilBox Inf: 26.11.3
:main
set /p "v=> "
if "!v!"=="repeat" goto repeat
if "!v!"=="deviceset" goto ds
if "!v!"=="help" goto help
if "!v!"=="errorlog" goto errorlog
goto main
:repeat
goto reset2
:ds
set /p "device=device> "
<nul set /p "=!device!" > cfg\currentdevice.txt
goto main
:help
echo repeat  deviceset  help  errorlog  gfx
goto main
:errorlog
type sav\errorlog.txt
goto main
:gfx
set /p gfx="gfx> "
>cfg\gfx-enabled.txt echo(%gfx%
goto main