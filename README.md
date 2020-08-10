# hls-to-mp4

**hls-to-mp4** is a bash script that downloads HLS .m3u8 format videos from a formatted input file. If the videos have non-embedded captions (such as in WebVTT format), you can include them in the input file to be downloaded with their corresponding video as .srt files. 

**Why?** I made this for my own personal use.

## Usage
Required:
- ffmpeg
- youtube-dl

Download the script. Add permissions:

`chmod +x ./hls-to-mp4.bashrc`

Create the input file with videos (and captions) to download. 

Input file only has videos to download:

`./hls-to-mp4.bashrc -f <input file path>`

Input file has videos and captions to download:

`./hls-to-mp4.bashrc -s -f <input file path>`

## Format of Input File

Each line in the input file is a video to download and optionally, its corresponding captions. Each line is split by '|' and parsed. 

Video and caption:

`file name to save as with no extensions | full url for .m3u8 video | full url to captions`

Video only:

`file name to save as with no extensions | full url for .m3u8 video`

The file name is applied to the name of the saved video and captions. If you open the video in VLC, the captions should automatically appear since the .srt file is the same name as the video.

## Important Note(s)

You cannot have an input file that has both lines of videos with and without caption urls. The input file must either all be videos without captions to download or videos with captions to download.

Videos (and captions) are saved to the directory where the script is executing in the sample input files. You can include the path of where you want it to be saved:
` /Users/jenny/Videos/Season 1/Episode 1 | ...` which will save the video to **/Users/jenny/Videos/Season 1** as **Episode 1.mp4**

The input file should have a new line at the end of the file as in the samples.
