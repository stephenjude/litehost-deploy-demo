package main

import (
	"fmt"
	"net/http"
	"os"
	"runtime"
)

func main() {
	build, _ := os.ReadFile("BUILD")
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		host, _ := os.Hostname()
		fmt.Fprintf(w, "hello from Go %s on %s/%s, build %s, host %s, path %s\n",
			runtime.Version(), runtime.GOOS, runtime.GOARCH, string(build), host, r.URL.Path)
	})
	// Demo diagnostics: the Rust worker's own log and whether its binary exists.
	http.HandleFunc("/rustlog", func(w http.ResponseWriter, r *http.Request) {
		st, err := os.Stat(os.Getenv("HOME") + "/miniserve")
		fmt.Fprintf(w, "miniserve stat: %v %v\n---\n", st, err)
		log, err := os.ReadFile("public/rust-serve.log")
		fmt.Fprintf(w, "%s\n(read err: %v)\n", log, err)
	})
	fmt.Println("go-hello listening on :3001")
	http.ListenAndServe(":3001", nil)
}
