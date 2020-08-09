#!/usr/bin/env bash

###
## Last modified: Aug 9, 2020
## Author: @egg-bread (GitHub)
###

separatesubs=
file=
totalvideos=0
downloadedvideos=0

invalid() {
    echo "Invalid command line option: $1"
}

help() {
    echo "hls-to-mp4 uses youtube-dl to download .m3u8 playlists as .mp4 and the videos' captions (has to be ffmpeg-supported type like .vtt) to .srt"
    echo "Usage: hls-to-mp4: [[[-f | --file file] [-s | --subs]] | [[-h | --help]]"
}

download-video() {
    youtube-dl -f mp4 -o "$1.mp4" "$2"
}

download-subtitles() {
    ffmpeg -i "$1" "$2.srt"
}

downloadMp4NoSubs() {
    echo "Downloading videos..."
    while IFS='|' read -r savename url
    do
        savename=`echo $savename | xargs`
        url=`echo $url | xargs`
        download-video "$savename" "$url"
        downloadedvideos=$((downloadedvideos+1)) # increment dl count
    done < $file
}

downloadMp4Subs() {
    echo "Downloading videos with corresponding subtitles..."
    while IFS='|' read -r savename url subs
    do 
        savename=`echo $savename | xargs`
        url=`echo $url | xargs`
        subs=`echo $subs | xargs`
        download-video "$savename" "$url"
        download-subtitles "$url" "$savename"
        downloadedvideos=$((downloadedvideos+1)) # increment dl count
    done < $file
}

# Read in cmd line args
while [[ "$1" != "" ]]; do
    case $1 in
        -s | --subs)   separatesubs=1
                        ;;
        -f | --file)    shift
                        file=$1
                        ;;
        -h | --help)    help
                        exit
                        ;;
        *)              invalid $1
                        exit 1
    esac
    shift
done

### MAIN ###
if [[ -f "$file" ]]; then
    totalvideos=`< "$file" wc -l | xargs`
    if [[ $separatesubs -eq 1 ]]; then
        downloadMp4Subs
    else 
        downloadMp4NoSubs
    fi
    echo "hls-to-mp4: Complete. Downloaded $downloadedvideos/$totalvideos video(s)."
else 
    echo "$file does not exist!"
fi

