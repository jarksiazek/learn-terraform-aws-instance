package main

import (
	"fmt"
	"sync"
)

var wg5 = sync.WaitGroup{}

func main() {
	ch := make(chan int)
	wg5.Add(2)
	go func() {
		i := <- ch
		fmt.Println(i)
		wg5.Done()
	}()
	go func() {
		ch <- 42
		wg5.Done()
	}()
	wg5.Wait()
}
