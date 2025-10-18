#!/bin/bash

INPUT_FILE="sea_clip.mp4"
OUTPUT_DIR="./hls"
PLAYLIST_NAME="playlist.m3u8"

if [ ! -f "$INPUT_FILE" ]; then
    echo "ERRO: O arquivo de entrada fixo não foi encontrado: ${INPUT_FILE}"
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

OUTPUT_PLAYLIST="${OUTPUT_DIR}/${PLAYLIST_NAME}"
SEGMENT_FILENAME="${OUTPUT_DIR}/seg_%03d.m4s"

GOP_SIZE=30
HLS_TIME=1
HLS_LIST_SIZE=4

echo -e "\n\n-------------------------------------------------------------------"
echo "Streaming (Live Loop) de ${INPUT_FILE} para HLS em ${OUTPUT_DIR}/"
echo "Playlist principal: ${OUTPUT_PLAYLIST}"
echo -e "-------------------------------------------------------------------\n\n"

TZ=UTC ffmpeg -stream_loop -1 -re \
    -i "$INPUT_FILE" \
    -c:v libx264 -g $GOP_SIZE -keyint_min $GOP_SIZE -force_key_frames "expr:gte(n, n_forced * $GOP_SIZE)" \
    -c:a aac \
    -f hls \
    -hls_time $HLS_TIME \
    -hls_list_size $HLS_LIST_SIZE \
    -hls_flags append_list+independent_segments+program_date_time \
    -hls_segment_type fmp4 \
    -hls_segment_filename "${SEGMENT_FILENAME}" \
    -fflags +nobuffer \
    "${OUTPUT_PLAYLIST}"

echo -e "\n\n-------------------------------------------------------------------"
echo "Streaming (Live) encerrado."
echo "Os arquivos estão localizados em: ${OUTPUT_DIR}"
echo -e "-------------------------------------------------------------------\n\n"