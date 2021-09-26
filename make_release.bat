SETLOCAL ENABLEDELAYEDEXPANSION
set /p version=<VERSION.txt
mkdir tmp
cd tmp
mkdir TestMod
copy ..\Info.json TestMod
copy ..\TestMod\bin\Release\TestMod.dll TestMod

cd TestMod
for /f "delims=" %%a in (Info.json) do (
    SET s=%%a
    SET s=!s:$VERSION=%version%!
    echo !s!
)>>"InfoChanged.json"
del Info.json
move InfoChanged.json Info.json
cd ..

tar -a -c -f TestMod-%version%.zip TestMod
move TestMod-%version%.zip ..
cd ..
rd /s /q tmp
pause