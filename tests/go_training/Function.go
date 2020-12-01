package main

import (
	"fmt"
)

func main() {
	//example 1
	sayMessage1("Hello")

	//example 2
	for i := 0; i < 5; i++ {
		sayMessage2("Hello", i)
	}

	//example 3
	sayGreeting("Hello", "John")

	//example 4
	sum := sum1(1, 2, 3)
	fmt.Println(sum)

	//example 5
	sum = sum2(1, 2, 3)
	fmt.Println(sum)

	//example 6
	d, err := divide (5.0, 0.0)
	if err != nil {
		fmt.Println(err)
		return
	}
	fmt.Println(d)

	//example 7 anonymous function
	func() {
		fmt.Println("Hello")
	}()

	//example 8 anonymous function
	f := func() {
		fmt.Println("Hello")
	}
	f()

	//example 9 method
	g := greeter {
		greeting: "Hello",
		name: "Go",
	}
	g.greet()

}

func sayMessage1(msg string) {
	fmt.Println(msg)
}

func sayMessage2(msg string, idx int) {
	fmt.Println(msg)
	fmt.Println(idx)
}

func sayGreeting(greeting, name string) {
	fmt.Println(greeting, name)
}

func sum1(values ...int) int {
	result := 0
	for _, v := range values {
		result += v
	}
	return result
}

func sum2(values ...int) (result int) {
	for _, v := range values {
		result += v
	}
	return
}

func divide (a, b float64) (float64, error)  {
	if b == 0.0 {
		return 0.0, fmt.Errorf("Cannot divide by zero")
	}
	return a / b, nil
}

type greeter struct {
	greeting string
	name string
}

func (g greeter) greet() {
	fmt.Println (g.greeting, g.name)
}