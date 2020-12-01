package main

import (
    "fmt"
)

func main() {
    //example 1
    var w Writer = ConsoleWriter{}
    w.Write([]byte("Hello Go"))
}

type Writer interface {
    Write([]byte) (int, error) //get byte and return int and error
}

type ConsoleWriter struct {}

func (cw ConsoleWriter) Write(data []byte) (int, error) {
    n, error := fmt.Println(string(data))
    return n, error
}