
# Rodando local: 

Rodar servidor:

`make run`

Gerar segmentos hls:

`make init-streaming-hls`

Gerar segmentos hls:

`make init-streaming-dash`

Testar:

* Abra o navegador
* Abra http://localhost:8080/index.html
* Abra o inspecionar do navegador -> geralmente f12 ou cmd + option + I
* Abra a aba network do inspecionar
* Clique em hls e veja a playlist.m3u8
* Clique em dash e veja mudar para playlist.mpd
