#!/bin/bash

# ANSI escape sequences for colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
RESET='\033[0m'  

color_echo() {
    local color="$1"
    local message="$2"
    echo -e "${color}${message}${RESET}"
}

clear

color_echo "${CYAN}" "╔═══════════════════════════════════════════╗"
color_echo "${CYAN}" "║                                           ║"
color_echo "${CYAN}" "║        YouTube Video Downloader           ║"
color_echo "${CYAN}" "║              by ${GREEN}MrTusarRX${CYAN}                 ║"
color_echo "${CYAN}" "║                                           ║"
color_echo "${CYAN}" "╚═══════════════════════════════════════════╝"
echo ""

if ! command -v python3 &> /dev/null
then
    color_echo "${RED}" "Python3 could not be found. Please install Python3."
    exit
fi

if ! command -v pip3 &> /dev/null
then
    color_echo "${YELLOW}" "pip3 could not be found. Installing pip3..."
    sudo apt-get update
    sudo apt-get install python3-pip -y
fi

if ! python3 -c "import pytube" &> /dev/null
then
    color_echo "${YELLOW}" "pytube not found. Installing pytube..."
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
