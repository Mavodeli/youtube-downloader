@echo off
set /p confirm="Remove ffmpeg, convert script and ALL .mkv files? (Y/N): "
if "%confirm%" == "y" goto :yes
if "%confirm%" == "Y" goto :yes
goto no
:yes
del "ffmpeg.exe"
del "mkv-to-mp4.bat"
for /r %%v in (*.mkv) do del "%%v"
del "delete-convert-script.bat"
:no
exit