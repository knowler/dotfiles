#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Theses are for audio conversion # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

flacdown () {
  mkdir -p converted
  for input in "$@"
    do sox -S $input -r 44100 -b 16 "converted/$(basename $input)"
  done
}

mp3these () {
  MP3DIR=`echo ${PWD##*/} | sed "s/FLAC/MP3-320/g" | cat`
  mkdir -p "../$MP3DIR"
  for input in "$@"
    do sox -S "$input" -C 320 "../$MP3DIR/${input%.*}.mp3"
  done
}

makethesefaster () {
  mkdir -p faster
  for input in "$@"
    do sox $input "faster/$input" tempo -s 2
  done
}

wmatomp3 () {
  mkdir -p mp3-64
  for input in "$@"
    do ffmpeg -i $input ${input%.*}.mp3 && sox -S ${input%.*}.mp3 -C 64 -c 1 "mp3-64/${input%.*}.mp3"
   done
}

mp3these64 () {
  mkdir -p mp3-64
  for input in "$@"
    do sox -S $input -C 64 -c 1 "mp3-64/${input%.*}.mp3"
   done
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Video tasks # # # # # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# Convert video to mp4 
mp4dis() {
  ffmpeg -i "$1" -vcodec libx264 ${1%.*}.mp4
}

# Remove sound from video
nosound() {
  ffmpeg -i "$1" -c copy -an ${1%.*}.nosound.mp4
}

# Prepare video for Instagram
igvid() {
  ffmpeg -i "$1" -vcodec libx264 -vf scale=w=1080:h=1080:force_original_aspect_ratio=decrease ${1%.*}-ig.mp4
}

# Scale video by 1/2
halfvid() {
  ffmpeg -i "$1" -vf "scale=iw/2:-2" ${1%.*}.halfsize.mp4
}
