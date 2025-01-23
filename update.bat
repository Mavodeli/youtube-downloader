FOR %%I IN (.) DO SET currentFolderName=%%~nI%%~xI
cd ../
powershell -command "Start-BitsTransfer -Source https://mavodeli.de/media/other/youtube-downloader.zip -Destination ytdlupdate.zip"
powershell -command "Expand-Archive ytdlupdate.zip '%currentFolderName%' -Force"
del ytdlupdate.zip
exit
