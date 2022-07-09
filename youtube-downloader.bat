@echo off
set /p url="URL (playlist or single video): "
echo Set Playlist URL to: %url%

echo .
:a
echo Make sure that the folder does not exist before running the script! 

set /p folder="Name of the folder you would like the playlist to be saved as: "

if exist "%CD%"\"%folder%" echo "This folder already exists!" & Pause & exit
mkdir "%CD%"\"%folder%"
echo Created Folder "%folder%"


xcopy "%CD%\src\ffmpeg.exe" "%CD%\%folder%"
xcopy "%CD%\src\yt-dlp.exe" "%CD%\%folder%"
xcopy "%CD%\src\libcrypto-1_1.dll" "%CD%\%folder%"
xcopy "%CD%\src\libssl-1_1.dll" "%CD%\%folder%"

echo .
set /p extract="Generate mp3 files from video? (Y/N): "

cd "%CD%"\"%folder%"

if "%extract%" == "y" goto :xtract
if "%extract%" == "Y" goto :xtract

yt-dlp.exe -i --recode-video "mp4" --merge-output-format "mp4" %url%
goto :end

:xtract

yt-dlp.exe -i -f bestaudio -x --audio-format mp3 %url%

:end
del "ffmpeg.exe"
del "yt-dlp.exe"
del "libcrypto-1_1.dll"
del "libssl-1_1.dll"

pause