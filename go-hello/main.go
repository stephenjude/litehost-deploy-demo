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
	fmt.Println("go-hello listening on :3001")
	http.ListenAndServe(":3001", nil)
}
