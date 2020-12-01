package main

import (
    "fmt"
)

func main() {
    //example 1
    if true {
        fmt.Println("The test is true")
    }

    //example 2
    statePopulations := map[string]int{
        "California":   3952,
        "Texas":        2758,
    }

    if pop, ok := statePopulations["California"]; ok {
        fmt.Println(pop)
    }

    //example 3
    number := 50
    guess := 30

    if guess < number {
        fmt.Println("Too low")
    }

    if guess > number {
        fmt.Println("Too high")
    }

    if guess == number {
        fmt.Println("Perfect")
    }

    //example 4
    if guess < 1 {
        fmt.Println("Too low")
    } else if guess > 100 {
        fmt.Println("Too high")
    } else {
        fmt.Println("Perfect")
    }

    //example 4
    switch 2 {
    case 1, 2 :
        fmt.Println("Case1")
    case 3:
        fmt.Println("Case2")
    default:
        fmt.Println("Default")
    }

    //example 5
    switch i := 2 + 3; i {
    case 1, 2 :
        fmt.Println("Case1")
    case 3:
        fmt.Println("Case2")
    default:
        fmt.Println("Default")
    }

    //example 6
    i := 10
    switch {
    case i <= 10:
        fmt.Println("Case1")
    case i <= 20:
        fmt.Println("Case2")
    default:
        fmt.Println("Default")
    }

    //example 7
    i = 10
    switch {
    case i <= 10:
        fmt.Println("Case1")
        fallthrough // you can go to next case for checking statement
    case i <= 20:
        fmt.Println("Case2")
    default:
        fmt.Println("Default")
    }

    //example 8
    var v interface{} = 1
    switch v.(type) {
    case int:
        fmt.Println("v is int")
    case float64:
        fmt.Println("v is float64")
    default:
        fmt.Println("v is another type")
    }
}