# Youtube-Downloader
Windows script version

## Download

Get the [latest release](https://github.com/Mavodeli/youtube-downloader/releases/latest) or download it from [my website](https://mavode.li/media/other/youtube-downloader.zip)

Alternatively you can clone the repository using `git clone https://github.com/Mavodeli/Youtube-Downloader`

## Updating
The script uses yt-dlps update feature to ensure the latest stable release of yt-dlp is in use.

Updating the script itself will not be necessary often, but the `update.bat` script automates updating the script from my website. 

## Setup:
Extract the files and `src` directory (folder) into a directory of your choice. The structure should look like this:
```
.
└── name_of_your_choice/
    ├── src/
    │   ├── ffmpeg.exe
    │   ├── ffprobe.exe
    │   ├── libcrypto-1_1.dll
    │   ├── libssl-1_1.dll
    │   └── yt-dlp.exe
    ├── README.md
    ├── update.bat
    └── youtube-downloader.bat
```

## How to use:
1. open youtube-downloader(.bat)
2. paste target url (or the name of a file in the directory you named, that contains urls in separate lines)
3. Enter a folder name, this folder will be created and contain the downloaded videos after completion
4. choose whether you want to extract mp3 audio files from the video(s).  
    Type `y` or `Y` for "yes" / `n` or `N` for "no" and press `Enter` to confirm.   
5. Upon completion press any button to exit

## About

This is basically just an ease of use script for [yt-dlp](https://github.com/yt-dlp/yt-dlp)
