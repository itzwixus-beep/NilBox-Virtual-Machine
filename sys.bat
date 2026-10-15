chcp 65001 >nul
@echo off
setlocal EnableDelayedExpansion
title NilBox
color 1F
set /p currentdevice=<cfg\currentdevice.txt
set /p gfxenabled=<cfg\gfx-enabled.txt
if "!gfxenabled!"=="1" goto gfxtrue
if "!gfxenabled!" neq "1" goto gfxfalse
:gosubgfx
if "!currentdevice!"=="hd0" goto okdevice
if "!currentdevice!"=="hd1" goto okdevice
if "!currentdevice!"=="hd2" goto okdevice
goto baddevice
:okdevice
mode 76,23
echo **** Cotara 16x ****
echo.
type box\%currentdevice%
:loop
echo.
set "v="
set /p "v=█"

if "!v!"==".LOAD" goto load
if "!v!"==".SAVE" goto save
if "!v!"==".RES" goto cls
if "!v!"==".RUN" goto run
if "!v!"==".CLS" goto clearc
if "!v!"==".DIR" goto current
if "!v!"==".DIV" goto nil
if "!v!"==".BIOS" goto EXITDEF
if "!v!"==".LOADOS" goto os
if "!v!"==".GFX" goto gfx

:unk
>>box\!currentdevice! echo(
>>box\!currentdevice! echo(!v!
goto loop

:load
type sav\save.dat > box\!currentdevice!
goto loop

:save
type box\!currentdevice! > sav\save.dat
goto loop

:cls
>box\!currentdevice! echo(
goto loop

:run
>run.bas echo( 
echo 2 LET CDATA$ = ^"!date!^" >> run.bas
echo 3 LET CURRENTVM$ = ^"NILBOX^" >> run.bas
echo 4 LET CURRENTDEVICE$ = ^"!currentdevice!^" >> run.bas
echo 5 LET GFXENABLED = !gfxenabled! >> run.bas
type box\!currentdevice! >> run.bas
echo.
call "emu\!int!" "run.bas"
goto loop

:clearc
cls
goto loop

:current
type box\!currentdevice!
goto loop

:nil
call box\tc.bat
color 1F
title NilBox
set /p "currentdevice="<cfg\currentdevice.txt
if "!currentdevice!"=="hd0" goto okdevice
if "!currentdevice!"=="hd1" goto okdevice
if "!currentdevice!"=="hd2" goto okdevice
goto baddevice

:baddevice
color 4F
title  
cls
echo [!time!]: bad device or unknown device, unable to read >> sav\errorlog.txt
echo :(  :BAD DEVICE
echo.
echo UNKNOWN/BAD DEVICE WRITED
echo THIS DEVICE UNABLE TO READ
echo.
echo PRESS ANY KEY TO EXIT...
pause >nul
goto EXITDEF

:os
type sav\DuckOS.dat > box\!currentdevice!
goto loop

:gfx
set int=basic-gfx.exe
set gfxenabled=1
goto gosubfgx

:gfxfalse
set int=basic.exe
set gfxenabled=0
goto gosubgfx

:EXITDEF