package main

import (
	"fmt"
	"time"
)

type TakeMessage struct {
	GiveChannel *chan int
}

type Philosopher struct {
	Id          int
	LeftFork    *Fork
	RightFork   *Fork
	GiveChannel chan int
}

func (p *Philosopher) RunPhilosopher() {
	for {
		p.LeftFork.TakeChannel <- TakeMessage{&p.GiveChannel}
		<-p.GiveChannel
		p.RightFork.TakeChannel <- TakeMessage{&p.GiveChannel}
		<-p.GiveChannel
    fmt.Println("Philosopher", p.Id, "is eating")
		p.LeftFork.ReturnChannel <- 0
		p.RightFork.ReturnChannel <- 0
    fmt.Println("Philosopher", p.Id, "is thinking")
	}
}

type Fork struct {
	TakeChannel   chan TakeMessage
	ReturnChannel chan int
}

func (f *Fork) RunFork() {
	for {
		takeMessage := <-f.TakeChannel
		*takeMessage.GiveChannel <- 0
		<-f.ReturnChannel
	}
}

func main() {
	const numPhilosophers = 3
	philosophers := make([]Philosopher, numPhilosophers)
	forks := make([]Fork, numPhilosophers)

	for i := 0; i < numPhilosophers; i++ {
		takeChannel := make(chan TakeMessage)
		returnChannel := make(chan int)

		forks[i] = Fork{takeChannel, returnChannel}
	}

	for i := 0; i < numPhilosophers-1; i++ {
		giveChannel := make(chan int)

		philosophers[i] = Philosopher{i, &forks[i], &forks[i+1], giveChannel}
	}

	giveChannel := make(chan int)
	philosophers[numPhilosophers-1] = Philosopher{numPhilosophers-1, &forks[numPhilosophers-1], &forks[0], giveChannel}

	for i := 0; i < numPhilosophers; i++ {
		go forks[i].RunFork()
	}

	for i := 0; i < numPhilosophers; i++ {
		go philosophers[i].RunPhilosopher()
	}

	time.Sleep(1000 * time.Millisecond)
}
