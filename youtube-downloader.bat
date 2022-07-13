@echo off
set /p url="URL (playlist or single video): "

echo:
echo Make sure that the folder does not exist before running the script! 

set /p folder="Name of the folder you would like the playlist to be saved as: "

if exist "%CD%"\"%folder%" echo "This folder already exists!" & Pause & exit

echo:
set /p extract="Extract mp3 (audio) files from video? (Y/N): "

if "%extract%" == "y" goto :xtract
if "%extract%" == "Y" goto :xtract

echo:
echo Try to remux all .webm files to .mp4?
echo (If the best format for a video is not webm it will not be remuxed!)
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
mkdir "%CD%"\"%folder%"
echo Created Folder "%folder%"

xcopy "%CD%\src\ffmpeg.exe" "%CD%\%folder%"
xcopy "%CD%\src\yt-dlp.exe" "%CD%\%folder%"
xcopy "%CD%\src\libcrypto-1_1.dll" "%CD%\%folder%"
xcopy "%CD%\src\libssl-1_1.dll" "%CD%\%folder%"

cd "%CD%"\"%folder%"

exit /b