ffmpeg -i ../sea_clip.mp4 \
  -map 0 \
  -b:v 3000k -b:a 128k \
  -use_template 1 -use_timeline 1 \
  -seg_duration 5 \
  -f dash ../dash/playlist.mpd
