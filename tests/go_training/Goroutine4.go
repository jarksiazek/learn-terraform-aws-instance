package main

import (
	"fmt"
	"runtime"
	"sync"
)

var wg4 = sync.WaitGroup{}
var counter = 0
var m = sync.RWMutex{}

func main() {
	runtime.GOMAXPROCS(100)
	for i := 0; i < 10; i++ {
		wg4.Add(2)
		m.RLock()
		go sayHello4()
		m.Lock()
		go increment()
	}
	wg4.Wait()
}

func sayHello4() {
	fmt.Printf("Hello #%v\n", counter)
	m.RUnlock()
	wg4.Done()
}

func increment() {
	counter++
	m.Unlock()
	wg4.Done()
}
