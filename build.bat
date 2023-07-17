@echo off

SET VERSION=1.0.0

if "%1" == "clean" call :clean

mkdir dest
cd commons

if "%1" == "common" call :common
if "%1" == "1.12.2" call :1122
if "%1" == "1.16.5" call :1165
if "%1" == "1.19.4" call :1194
if "%1" == "" call :rebuild

goto end

:rebuild

call :clean
cd ..
mkdir dest
cd dest
call :common
call :1122
call :1165
call :1194

exit /b

:clean

echo Cleaning...

cd ..

rmdir /s /q dest > nul
cd commons
call mvn clean
cd ..\v1_12_2
call gradlew.bat clean
cd ..\v1_16_5
call gradlew.bat clean
cd ..\v1_19_4
call gradlew.bat clean

exit /b

:common

echo Installing dependencies...

echo Building commons...

cd ../commons
call mvn clean install

exit /b

echo Building 1.12.2...


:1122
cd ../v1_12_2
call gradlew.bat build
copy build\libs\Example.jar ..\dest\Example-[1.12.2]-%VERSION%.jar

exit /b

:1165
echo Building 1.16.5...

cd ../v1_16_5
call gradlew.bat build
copy build\libs\Example.jar ..\dest\Example-[1.16.5]-%VERSION%.jar

exit /b

:1194
echo Building 1.19.4...

cd ../v1_19_4
call gradlew.bat build
copy build\libs\Example.jar ..\dest\Example-[1.19.4]-%VERSION%.jar

exit /b

:end
echo Done!
