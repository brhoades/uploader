@echo off
REM 0 whole screen
REM 4 rectangle
REM http://www.etcwiki.org/wiki/IrfanView_Command_Line_Options
Setlocal EnableDelayedExpansion
REM we tack our URL onto this
set basename=http://i.brod.es/
REM How many chars
set _RNDLength=5 

call :newname
set filename=%_RndAlphaNum%.png
%~dps0\IrfanView\i_view64.exe /capture=%1 /convert="C:\temp\%filename%"
%~dps0\pscp.exe -scp -i "%~dps0..\.ssh\id_rsa.ppk" "C:\temp\%filename%" aaron@brod.es:/var/www/images/
echo %basename%!filename! | clip

exit /b 0
REM														HALLO FROM WINDOWS
REM             								NATIVE SCREENSHOT WITH PORTED TOOLS	
:newname
Set _Alphanumeric=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
Set _Str=%_Alphanumeric%987654321
:_LenLoop
IF NOT "%_Str:~18%"=="" SET _Str=%_Str:~9%& SET /A _Len+=9& GOTO :_LenLoop
SET _tmp=%_Str:~9,1%
SET /A _Len=_Len+_tmp
Set _count=0
SET _RndAlphaNum=
:_loop
Set /a _count+=1
SET _RND=%Random%
Set /A _RND=_RND%%%_Len%
SET _RndAlphaNum=!_RndAlphaNum!!_Alphanumeric:~%_RND%,1!
If !_count! lss %_RNDLength% goto _loop
Echo Random string is !_RndAlphaNum!
exit /b 0