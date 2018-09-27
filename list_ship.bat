@echo off & setlocal EnableDelayedExpansion
Pushd "%~dp0"
title Ship list generator

dir /A:-D /B > list_ship.txt
echo Generating list...

set _file="list_ship.txt"
set _word1=.blkx
set _word3=.blk
set _word2=

echo Removing extensions...
type nul > "%_file%.tmp"
for /F "delims=" %%i in ('type "%_file%"') do (
 set row=%%i
 set row=!row:%_word1%=%_word2%!
 set row=!row:%_word3%=%_word2%!
  echo.!row!
) >> "%_file%.tmp"

echo Removing duplicates...
type nul> "%_file%.tmpp"
for /f "tokens=* delims=" %%a in ('type "%_file%.tmp"') do (
  findstr /ixc:"%%a" "%_file%.tmpp" >nul || >>"%_file%.tmpp" echo.%%a
)

echo Removing uncounted entries...
type nul> "%_file%.tmppp"
findstr /V "list grass" %_file%.tmpp > %_file%.tmppp

move "%_file%.tmppp" "%_file%"
del "%_file%.tmpp
del "%_file%.tmp

exit