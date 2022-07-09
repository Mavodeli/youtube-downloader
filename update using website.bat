FOR %%I IN (.) DO SET currentFolderName=%%~nI%%~xI
echo %currentFolderName%
cd ../
powershell -command "Start-BitsTransfer -Source https://mavodeli.de/youtube-downloader/youtube-downloader.zip -Destination ytdlupdate.zip"
powershell -command "Expand-Archive ytdlupdate.zip '%currentFolderName%' -Force"
del ytdlupdate.zip
exit