#!/bin/bash
if ! command -v python3 &> /dev/null
then
    echo "Python3 could not be found. Please install Python3."
    exit
fi

if ! command -v pip3 &> /dev/null
then
    echo "pip3 could not be found. Installing pip3..."
    sudo apt-get update
    sudo apt-get install python3-pip -y
fi

if ! python3 -c "import pytube" &> /dev/null
then
    echo "pytube not found. Installing pytube..."
    pip3 install pytube
fi

read -p "Enter the YouTube video URL: " video_url
read -p "Enter the download path (default is current directory): " download_path

download_path=${download_path:-.}

python3 - << EOF
from pytube import YouTube
import os

video_url = "$video_url"
download_path = "$download_path"

try:
    yt = YouTube(video_url)
    ys = yt.streams.get_highest_resolution()
    print(f"Downloading '{yt.title}' to '{download_path}'...")
    ys.download(download_path)
    print("Download completed!")
except Exception as e:
    print(f"An error occurred: {e}")
EOF
