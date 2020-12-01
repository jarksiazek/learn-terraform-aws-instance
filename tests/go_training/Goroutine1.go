package main

import (
	"fmt"
	"time"
)

func main() {
	go sayHello()
	time.Sleep(100 * time.Microsecond)
}

func sayHello() {
	fmt.Println("Hello")
}
