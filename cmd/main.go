package main

import (
	"log"
	"net/http"
)

func main() {
	// Serve todos os arquivos a partir da raiz do projeto
	handler := http.FileServer(http.Dir("./"))

	corsHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Access-Control-Allow-Origin", "*")
		handler.ServeHTTP(w, r)
	})

	port := ":8080"
	log.Printf("Servidor rodando em http://localhost%s\n", port)
	err := http.ListenAndServe(port, corsHandler)
	if err != nil {
		log.Fatal(err)
	}
}
