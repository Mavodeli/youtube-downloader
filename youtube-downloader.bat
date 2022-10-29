@echo off
:start
set /p url="URL (playlist or single video): "

echo:
set /p folder="Name the folder you would like the playlist (or video) to be saved in: "

@REM We check if the folder already exists
if exist "%CD%"\"%folder%" call:confirmfolder

@REM We check if the input is a local file
setlocal EnableDelayedExpansion
if exist "%CD%\%url%" (
    echo:
    echo "You input a local file. Try downloading each line in the file?"
    set /p listfile="This will move the file into the target folder! (Y/N): "

    if "!listfile!" == "y" endlocal & call :downloadtextfile & goto :end
    if "!listfile!" == "Y" endlocal & call :downloadtextfile & goto :end

    echo:
    goto :start
)
endlocal

echo:
set /p extract="Extract mp3 (audio) files from video? (Y/N): "

if "%extract%" == "y" goto :xtract
if "%extract%" == "Y" goto :xtract

call:prep
yt-dlp.exe %url%
goto :end

:xtract
call:prep
yt-dlp.exe -i -f bestaudio -x --audio-format mp3 %url%
goto :end

:end
del "ffmpeg.exe"
del "ffprobe.exe"
del "yt-dlp.exe"
del "libcrypto-1_1.dll"
del "libssl-1_1.dll"

pause
exit

:prep
if not exist "%CD%"\"%folder%" mkdir "%CD%"\"%folder%" & echo Created Folder "%folder%"

xcopy "%CD%\src\ffmpeg.exe" "%CD%\%folder%"
xcopy "%CD%\src\ffprobe.exe" "%CD%\%folder%"
xcopy "%CD%\src\yt-dlp.exe" "%CD%\%folder%"
xcopy "%CD%\src\libcrypto-1_1.dll" "%CD%\%folder%"
xcopy "%CD%\src\libssl-1_1.dll" "%CD%\%folder%"

cd "%CD%"\"%folder%"

exit /b

:confirmfolder
echo:
echo "This folder already exists. Use continue to update a playlist for example."
set /p confirmed=" Continue in the specified folder? (Y/N): "

if "%confirmed%" == "y" exit /b
if "%confirmed%" == "Y" exit /b

goto :start

:downloadtextfile
if not exist "%CD%"\"%folder%" mkdir "%CD%"\"%folder%" & echo Created Folder "%folder%"
xcopy "%CD%\%url%" "%CD%\%folder%"
del "%url%"
call:prep
yt-dlp -a %url%
exit /b