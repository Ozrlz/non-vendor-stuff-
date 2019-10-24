package main

import (
    "fmt"
    "strings"
    "net/http"
)

func main() {
    http.HandleFunc("/", HelloServer)
    http.ListenAndServe(":8000", nil)
}

func HelloServer(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, formatRequest(r))
    fmt.Print(formatRequest(r))
}

func formatRequest(r *http.Request) string {
    var request []string
    request = append(request, "{")
    for name, headers := range r.Header {
      name = strings.ToLower(name)
      for _, h := range headers {
        request = append(request, fmt.Sprintf("%v: %v,", name, h))
      }
    }
    request = append(request, "}")
     return strings.Join(request, "\n")
   }