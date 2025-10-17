#!/bin/bash

# Define as variáveis de entrada e saída fixas
# Arquivo de vídeo de entrada fixo
INPUT_FILE="../sea_clip.mp4" 
# Diretório de saída fixo (um nível acima)
OUTPUT_DIR="../hls" 
# Nome da playlist principal fixo
PLAYLIST_NAME="playlist.m3u8"

# Verifica se o arquivo de entrada existe antes de prosseguir
if [ ! -f "$INPUT_FILE" ]; then
    echo "ERRO: O arquivo de entrada fixo não foi encontrado: ${INPUT_FILE}"
    echo "Certifique-se de que ele está no caminho correto em relação a este script."
    exit 1
fi

# Cria o diretório de saída se ele não existir
mkdir -p "$OUTPUT_DIR"

# Define os caminhos de saída completos
OUTPUT_PLAYLIST="${OUTPUT_DIR}/${PLAYLIST_NAME}"
# Define o nome dos segmentos (usando fMP4 (.m4s))
SEGMENT_FILENAME="${OUTPUT_DIR}/seg_%03d.m4s"

# Define as configurações de chave
GOP_SIZE=30 # Keyframe a cada 30 frames
HLS_TIME=1  # Segmentos de 1 segundo
HLS_LIST_SIZE=2 # Mantém apenas os 2 últimos segmentos na playlist

echo -e "\n\n-------------------------------------------------------------------"
echo "Streaming (Live) de ${INPUT_FILE} para HLS em ${OUTPUT_DIR}/"
echo "Playlist principal: ${OUTPUT_PLAYLIST}"
echo -e "-------------------------------------------------------------------\n\n"

# Comando FFmpeg para Streaming (Live) com segmentos fMP4
ffmpeg -re \
    -i "$INPUT_FILE" \
    -c:v libx264 -g $GOP_SIZE -keyint_min $GOP_SIZE -force_key_frames "expr:gte(n, n_forced * $GOP_SIZE)" \
    -c:a aac \
    -f hls \
    -hls_time $HLS_TIME \
    -hls_list_size $HLS_LIST_SIZE \
    -hls_flags append_list+omit_endlist \
    -hls_segment_type fmp4 \
    -hls_segment_filename "${SEGMENT_FILENAME}" \
    -fflags +nobuffer \
    "${OUTPUT_PLAYLIST}"

echo -e "\n\n-------------------------------------------------------------------"
echo "Streaming (Live) encerrado."
echo "Os arquivos estão localizados em: ${OUTPUT_DIR}"
echo -e "-------------------------------------------------------------------\n\n"