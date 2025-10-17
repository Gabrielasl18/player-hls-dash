ffmpeg -i sea_clip.mp4 \
  -codec: copy \
  -start_number 0 \
  -hls_time 5 \
  -hls_list_size 0 \
  -f hls sea_clip.m3u8
