package main

import (
	"log"
	"os"
	"os/signal"
	"path/filepath"
)

func main() {
	// Find binary path
	dir, err := filepath.Abs(filepath.Dir(os.Args[0]))
	if err != nil {
		log.Fatal(err)
	}
	log.Println(dir)

	// Cd to binary path
	err = os.Chdir(dir)
	if err != nil {
		log.Fatal(err)
    }

    log.Print("hello go")
    log.Print("Press Ctrl-C to quit!")

	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt, os.Kill)

	// Block until a signal is received.
	sig := <-c
	log.Printf("Trapped Signal; %v", sig)
	os.Exit(0)
}
