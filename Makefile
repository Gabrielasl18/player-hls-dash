SHELL=/bin/bash
BASH_CMD=bash

run:
	go run cmd/main.go

init-streaming-hls:
	echo "Iniciando streaming hls"
	@$(BASH_CMD) scripts/ffmpeg-hls.sh

init-streaming-dash:
	echo "Iniciando streaming dash"
	@$(BASH_CMD) scripts/ffmpeg-dash.sh