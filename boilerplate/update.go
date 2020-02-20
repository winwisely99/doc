package main

import (
	"fmt"
	"go/build"
	"io/ioutil"
	"log"
	"os"
	"strings"

	"gopkg.in/src-d/go-git.v4"
)

var (
	repo = "github.com/getcouragenow/bootstrap"
)

func main() {
	Info("Running update of boilerplate files from: https://" + repo)

	GetRepFilePath()
	os.Exit(1)

	tempDir, err := MakeTempDir()
	CheckIfError(err)
	Info("tempDir:" + tempDir)

	_, err = git.PlainClone(tempDir, false, &git.CloneOptions{
		URL:      "https://" + repo,
		Progress: os.Stdout,
	})

	// Parse the config to see which one we want
	PrintFiles(tempDir + "/boilerplate")

	CheckIfError(err)
}

// GetRepFilePath ..
func GetRepFilePath(repo string) {
	gopath := os.Getenv("GOPATH")
	if gopath == "" {
		gopath = build.Default.GOPATH
	}
	fmt.Println(gopath)
}

// PrintFiles in a Dir.
func PrintFiles(dir string) {
	files, err := ioutil.ReadDir(dir)
	if err != nil {
		log.Fatal(err)
	}
	for _, f := range files {
		fmt.Println(f.Name())
	}
}

// MakeTempDir creaets a temp dir.
func MakeTempDir() (dir string, err error) {
	dir, err = ioutil.TempDir("", "")
	if err != nil {
		log.Fatal(err)
	}

	return dir, err
}

// CheckArgs should be used to ensure the right command line arguments are
// passed before executing an example.
func CheckArgs(arg ...string) {
	if len(os.Args) < len(arg)+1 {
		Warning("Usage: %s %s", os.Args[0], strings.Join(arg, " "))
		os.Exit(1)
	}
}

// CheckIfError should be used to naively panics if an error is not nil.
func CheckIfError(err error) {
	if err == nil {
		return
	}

	fmt.Printf("\x1b[31;1m%s\x1b[0m\n", fmt.Sprintf("error: %s", err))
	os.Exit(1)
}

// Info should be used to describe the example commands that are about to run.
func Info(format string, args ...interface{}) {
	fmt.Printf("\x1b[34;1m%s\x1b[0m\n", fmt.Sprintf(format, args...))
}

// Warning should be used to display a warning
func Warning(format string, args ...interface{}) {
	fmt.Printf("\x1b[36;1m%s\x1b[0m\n", fmt.Sprintf(format, args...))
}
