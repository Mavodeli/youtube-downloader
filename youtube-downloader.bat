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
xcopy "%CD%\src\youtube-dl.exe" "%CD%\%folder%"
xcopy "%CD%\src\libcrypto-1_1.dll" "%CD%\%folder%"
xcopy "%CD%\src\libssl-1_1.dll" "%CD%\%folder%"


echo .
set /p extract="Generate mp3 files from video? (Y/N): "

if "%extract%" == "y" goto :xtract
if "%extract%" == "Y" goto :xtract

set /p copyconvertscript="Copy .mkv to .mp4 converter script to target folder? (Y/N): "

if "%copyconvertscript%" == "y" goto :copyvscript
if "%copyconvertscript%" == "Y" goto :copyvscript

goto :nocopyvscript

:copyvscript

xcopy "%CD%\src\mkv-to-mp4.bat" "%CD%\%folder%"

:nocopyvscript

cd "%CD%"\"%folder%"

youtube-dl.exe -i %url%
goto :end

:xtract
youtube-dl.exe -i -x --audio-format mp3 %url%

:end
del "ffmpeg.exe"
del "youtube-dl.exe"
del "libcrypto-1_1.dll"
del "libssl-1_1.dll"

pause