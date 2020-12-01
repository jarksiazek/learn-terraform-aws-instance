package main

import (
    "fmt"
    "math"
)


//package var
var (
    actorName = "John Smith"
)

//package var with lower letter
var k int = 123

//global var with upper letter
var K int = 123

func main() {
    //using package level variable
    fmt.Println(k)

    var i int = 12
    fmt.Println(i)

    b := 14
    fmt.Println(b)

    //print value and time
    fmt.Printf("%v, %T\n", b, b)

    fmt.Println("Hello, World!")

    //complex number
    var n complex64 = 1 + 2i
    fmt.Printf("%v, %T\n", n, n)

    //const
    var myConst float64 = math.Sin(1.57)
    fmt.Printf("%v, %T\n", myConst, myConst)

    //array
    grades := [3]int{97, 85, 81}
    //grades := [...]int{97, 85, 81}
    fmt.Printf("%v, %T\n", grades, grades)

    var students [3]string
    students[0] = "John"
    fmt.Printf("%v, %T\n", students, students)
    fmt.Printf("Number of students: %v\n", len(students))

    //slices
    slice1 := []int{1, 2, 3}
    fmt.Printf("%v, %T\n", slice1, slice1)
    fmt.Printf("Length %v\n", len(slice1))
    fmt.Printf("Capacity %v\n", cap(slice1))

    // a := []int{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
    // b := a[:] //slice of all elements
    // c := a[3:] //slice from 4th element
    // d := a[:6] //slice first 6 elements
    // e := a[3:6] //slice the 4th, 5th, 6th

    arrayMakeFunc := make([]int, 3)
    fmt.Printf("%v, %T\n", arrayMakeFunc, arrayMakeFunc)
    fmt.Printf("Length %v\n", len(arrayMakeFunc))
    fmt.Printf("Capacity %v\n", cap(arrayMakeFunc))

    arrayWithCapacityMakeFunc := make([]int, 3, 100)
    fmt.Printf("%v, %T\n", arrayWithCapacityMakeFunc, arrayWithCapacityMakeFunc)
    fmt.Printf("Length %v\n", len(arrayWithCapacityMakeFunc))
    fmt.Printf("Capacity %v\n", cap(arrayWithCapacityMakeFunc))

    //slice concat 2 slices
    concatSlides := make([]int, 1)
    sliceA := []int{1, 2, 3}
    sliceB := []int{4, 5, 6, 7, 8, 9, 10}
    concatSlides = append(sliceA, sliceB...)
    fmt.Printf("Concatenated %v\n", concatSlides)

    //slice pop remove 1st element
    slicePop := []int{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
    slicePopRemove1st := slicePop[1:]
    fmt.Println(slicePopRemove1st)

    //slice pop remove last element
    slicePopRemoveLast := slicePop[:len(slicePop)-1]
    fmt.Println(slicePopRemoveLast)

    //slice remove element in the middle
    slicePopRemoveMid := append(slicePop[:2], slicePop[3:]...)
    fmt.Println(slicePopRemoveMid)

    //map
    statePopulations := map[string]int{
        "California":   3952,
        "Texas":        2758,
    }
    statePopulations["New York"] = 1234
    fmt.Println(statePopulations)
    fmt.Println(statePopulations["Texas"])

    delete(statePopulations, "New York")
    fmt.Println(statePopulations)

    pop, ok := statePopulations["Oho"]
    fmt.Println(pop, ok)

    // checking if "Oho" value exists, if not print false
    _, ok = statePopulations["Oho"]
    fmt.Println(ok)

    // map length
    fmt.Println(len(statePopulations))
}