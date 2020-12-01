package main

import (
    "fmt"
)

func main() {
    //Defer 1
    fmt.Println("start")
    defer fmt.Println("middle")
    fmt.Println("end")
    // start -> end -> middle

    //Panic 1
    err := http.ListenAndServe(":8080", nil)
    if err != nil {
        panic(err.Error())
    }

    //Panic 2
    fmt.Println("start")
    defer fmt.Println("defer")
    panic("panic")
    fmt.Println("end")
    // start -> defer -> panic
}