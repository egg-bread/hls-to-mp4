# hls-to-mp4

**hls-to-mp4** is a bash script that downloads HLS .m3u8 format videos from a formatted input file. If the videos have non-embedded captions (such as in WebVTT format), you can include them in the input file to be downloaded with their corresponding video as .srt files.

## Format of Input File

Each line in the input file is a video to download and optionally, its corresponding captions. Each line is split by '|' and parsed. 

Video and caption:
<pre>file name to save as with no extensions | full url for .m3u8 video | full url to captions</pre>

Video only:
<pre>file name to save as with no extensions | full url for .m3u8 video</pre>

## Important Note(s)

You cannot have an input file that has both lines of videos with and without caption urls. The input file must either all be videos without captions to download or videos with captions to download.

Videos (and captions) are saved to the directory where the script is executing.

The input file should have a new line at the end of the file as in the samples.