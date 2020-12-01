package main

import (
    "fmt"
)

func main() {
    //example 1
    var a int = 42
    var b *int = &a //refer to the same location in memory
    fmt.Println(a, b) //42 0x1040a124 - a and location in memory
    fmt.Println(a, *b) //42 42

    a = 27
    fmt.Println(a, *b) //27 27

    *b = 12
    fmt.Println(a, *b) //14 14

    //example 2
    a1 := [3]int{1, 2, 3}
    b1 := &a1[0]
    c1 := &a1[0]
    fmt.Printf("%v %p %p\n", a1, b1, c1)
}