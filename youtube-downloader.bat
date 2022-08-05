@echo off
:start
set /p url="URL (playlist or single video): "

echo:
set /p folder="Name the folder you would like the playlist (or video) to be saved in: "

if exist "%CD%"\"%folder%" call:confirmfolder

echo:
set /p extract="Extract mp3 (audio) files from video? (Y/N): "

if "%extract%" == "y" goto :xtract
if "%extract%" == "Y" goto :xtract

echo:
echo Try to remux all .webm files to .mp4?
echo (If the best format is not .webm that video will not be remuxed)
echo (This will affect ALL .webm files, careful with old folders!)
set /p remux="(Y/N): "

if "%remux%" == "y" goto :remux
if "%remux%" == "Y" goto :remux

call:prep
yt-dlp.exe %url%
goto :end

:remux
call:prep
yt-dlp.exe %url%
for /r %%v in (*.webm) do ffmpeg -i "%%v" -vcodec copy -acodec aac -movflags +faststart "%%~nv.mp4"
for /r %%v in (*.webm) do del "%%v"
goto :end

:xtract
call:prep
yt-dlp.exe -i -f bestaudio -x --audio-format mp3 %url%
goto :end

:end
del "ffmpeg.exe"
del "yt-dlp.exe"
del "libcrypto-1_1.dll"
del "libssl-1_1.dll"

pause
exit

:prep
if not exist "%CD%"\"%folder%" mkdir "%CD%"\"%folder%" & echo Created Folder "%folder%"

xcopy "%CD%\src\ffmpeg.exe" "%CD%\%folder%"
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