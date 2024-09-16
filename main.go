package main

import (
    "html/template"
    "log"
    "net/http"
)

func helloHandler(w http.ResponseWriter, r *http.Request) {
    tmpl := template.Must(template.ParseFiles("templates/index.html"))
    tmpl.Execute(w, nil)
}

func main() {
    // Serve static files (CSS, JS, etc.)
    http.Handle("/static/", http.StripPrefix("/static/", http.FileServer(http.Dir("static"))))

    // Serve the HTML page
    http.HandleFunc("/", helloHandler)

    log.Println("Server starting on :8080...")
    log.Fatal(http.ListenAndServe(":8080", nil))
}
