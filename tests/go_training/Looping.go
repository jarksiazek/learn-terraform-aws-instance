package main

import (
    "fmt"
)

func main() {
    //example 1
    for i := 0; i < 5; i++ {
        fmt.Println(i)
    }

    //example 2
    for i, j := 0, 0; i < 5; i,j = i+1, j+1 {
        fmt.Println(i, j)
    }

    //example 3
    s := []int{1, 2, 3}
    for k, v := range s {
        fmt.Println(k, v)
    }

    //example 4
    statePopulations := map[string]int{
        "California":   3952,
        "Texas":        2758,
    }
    for k, v := range statePopulations {
        fmt.Println(k, v)
    }

}