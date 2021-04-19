@echo off
for /r %%v in (*.mkv) do ffmpeg -i "%%v" -vcodec copy -acodec aac -movflags +faststart "%%~nv.mp4"
pause