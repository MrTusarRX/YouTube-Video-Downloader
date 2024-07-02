from pytube import YouTube

def download_youtube_video(url, download_path='.'):
    try:
        # Create a YouTube object with the URL
        yt = YouTube(url)

        # Get the highest resolution stream available
        stream = yt.streams.get_highest_resolution()

        # Download the video to the specified path
        stream.download(output_path=download_path)

        print(f"Downloaded '{yt.title}' successfully!")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    # YouTube video URL
    video_url = input("Enter the YouTube video URL: ")

    # Download path (default is current directory)
    download_path = input("Enter the download path (leave blank for current directory): ") or '.'

    # Call the download function
    download_youtube_video(video_url, download_path)
