@echo off & setlocal EnableDelayedExpansion

title List generator

if not exist "%~dp0\aces.vromfs.bin_u" (
	echo Please make sure the program is placed in the folder that also contains the folder aces.vromfs.bin_u,
	echo which should contain .blk or .blkx files. Then restart the program
	pause
	exit
)

if not exist "%~dp0\vehicle_list" mkdir %~dp0\vehicle_list

:plane
if not exist "%~dp0\aces.vromfs.bin_u\gamedata\flightmodels" (
	echo Error retrieving plane files
	goto:heli
)

echo Creating plane list...
move /y %~dp0\list_plane.bat %~dp0\aces.vromfs.bin_u\gamedata\flightmodels >nul
start /wait %~dp0\aces.vromfs.bin_u\gamedata\flightmodels\list_plane.bat
move /y %~dp0\aces.vromfs.bin_u\gamedata\flightmodels\list_plane.txt %~dp0\vehicle_list >nul
move /y %~dp0\aces.vromfs.bin_u\gamedata\flightmodels\list_plane.bat %~dp0\ >nul
echo Plane list successfully created

if not exist "%~dp0\aces.vromfs.bin_u\gamedata\flightmodels" (
	echo Error retrieving helicopter files
	goto:tank
)

:heli
echo Creating helicopter list...
move /y %~dp0\list_heli.bat %~dp0\aces.vromfs.bin_u\gamedata\flightmodels >nul
start /wait %~dp0\aces.vromfs.bin_u\gamedata\flightmodels\list_heli.bat
move /y %~dp0\aces.vromfs.bin_u\gamedata\flightmodels\list_heli.txt %~dp0\vehicle_list >nul
move /y %~dp0\aces.vromfs.bin_u\gamedata\flightmodels\list_heli.bat %~dp0\ >nul
echo Helicopter list successfully created


for /f %%i in ("%~dp0\vehicle_list\list_heli.txt") do set size=%%~zi
	if %size% equ 0 (
		echo No helicopters have been found
		del "%~dp0\vehicle_list\list_heli.txt"
		goto:tank
	)

findstr /V /g:"%~dp0\vehicle_list\list_heli.txt" "%~dp0\vehicle_list\list_plane.txt" > %~dp0\vehicle_list\list_plane.txt.tmp
move /y "%~dp0\vehicle_list\list_plane.txt.tmp" "%~dp0\vehicle_list\list_plane.txt" >nul


:tank
if not exist "%~dp0\aces.vromfs.bin_u\gamedata\units\tankmodels" (
	echo Error retrieving tank files
	goto:ship
)

echo Creating tank list...
move /y %~dp0\list_tank.bat %~dp0\aces.vromfs.bin_u\gamedata\units\tankmodels >nul
start /wait %~dp0\aces.vromfs.bin_u\gamedata\units\tankmodels\list_tank.bat
move /y %~dp0\aces.vromfs.bin_u\gamedata\units\tankmodels\list_tank.txt %~dp0\vehicle_list >nul
move /y %~dp0\aces.vromfs.bin_u\gamedata\units\tankmodels\list_tank.bat %~dp0\ >nul
echo Tank list successfully created

:ship
if not exist "%~dp0\aces.vromfs.bin_u\gamedata\units\ships" (
	echo Error retrieving ship files
	goto:level
)

echo Creating ship list...
move /y %~dp0\list_ship.bat %~dp0\aces.vromfs.bin_u\gamedata\units\ships >nul
start /wait %~dp0\aces.vromfs.bin_u\gamedata\units\ships\list_ship.bat
move /y %~dp0\aces.vromfs.bin_u\gamedata\units\ships\list_ship.txt %~dp0\vehicle_list >nul
move /y %~dp0\aces.vromfs.bin_u\gamedata\units\ships\list_ship.bat %~dp0\ >nul
echo Ship list successfully created

:level
if not exist "%~dp0\aces.vromfs.bin_u\levels" (
	echo Error retrieving location files
	goto:end
)

echo Creating location list...
move /y %~dp0\list_levels.bat %~dp0\aces.vromfs.bin_u\levels >nul
start /wait %~dp0\aces.vromfs.bin_u\levels\list_levels.bat
move /y %~dp0\aces.vromfs.bin_u\levels\list_levels.txt %~dp0\vehicle_list >nul
move /y %~dp0\aces.vromfs.bin_u\levels\list_levels.bat %~dp0\ >nul
echo Location list successfully created

:end
echo All done!

pause