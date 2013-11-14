rem This will execute all .g files in the folder PROGRAMDIRECTORY in parallel.  These programs should all be designed to produce output files, as output to the GAP terminal will be supressed.
@echo off
cls
set TERMINFO=/cygdrive/C/GAP/terminfo
set CYGWIN=nodosfilewarning
set LANG=en_US.UTF-8
set HOME=%HOMEDRIVE%%HOMEPATH%
cd %HOME%
set PROGRAMDIRECTORY="C:/Users/Gavin/Documents/GitHub/Davis-Research/GAP Code/Parallel"
cd %PROGRAMDIRECTORY%
for %%f in ( *.g ) do (
	start "GAP" C:\GAP\bin\mintty.exe -s 64,18 /cygdrive/C/GAP/bin/gapw95.exe -m 1G -o 8G -l /cygdrive/C/GAP %* %PROGRAMDIRECTORY%/%%f
)
exit