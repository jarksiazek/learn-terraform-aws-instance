package main

import (
    "fmt"
)

type Doctor struct {
    number int
    actorName string
    companions []string
}

type Animal struct {
    Name string
    Origin string
}

type Bird struct {
    Animal
    Speed float32
    CanFly bool
}

func main2() {
    //struct
    aDoctor := Doctor {
        number: 3,
        actorName: "John",
        companions: []string {"Liz", "Jo",},
    }
    fmt.Println(aDoctor)
    fmt.Println(aDoctor.actorName)

    //anonymous struct
    aDoctorAnonymous:= struct {name string}{name: "John"}
    anotherDoctor := aDoctorAnonymous //passing copy not reference
    anotherDoctor.name = "Tom"
    fmt.Println(aDoctorAnonymous)
    fmt.Println(anotherDoctor)

    //embedding
    bird1 := Bird{}
    bird1.Name = "Emu"
    bird1.Origin = "Australia"
    bird1.Speed = 48
    bird1.CanFly = false
    fmt.Println(bird1)
    fmt.Println(bird1.Name)


    bird2 := Bird{
        Animal: Animal{Name: "Emu", Origin: "Australia"},
        Speed: 34,
        CanFly: false,
    }
    fmt.Println(bird2)
    fmt.Println(bird2.Name)
}