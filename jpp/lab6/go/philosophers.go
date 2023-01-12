package main

import (
	"fmt"
	"sync"
)

type TakeMessage struct {
	GiveChannel *chan int
}

type Philosopher struct {
	Id          int
	LeftFork    *Fork
	RightFork   *Fork
	LeftForkId  int
	RightForkId int
	GiveChannel chan int
	ToEat       int
	Wg          *sync.WaitGroup
}

func (p *Philosopher) RunPhilosopher() {
	for p.ToEat > 0 {
		fmt.Println("Philosopher ", p.Id, " is taking fork ", p.LeftForkId)
		p.LeftFork.TakeChannel <- TakeMessage{&p.GiveChannel}
		<-p.GiveChannel
		fmt.Println("Philosopher ", p.Id, " took for ", p.LeftForkId)
		fmt.Println("Philosopher ", p.Id, " is taking fork ", p.RightForkId)
		p.RightFork.TakeChannel <- TakeMessage{&p.GiveChannel}
		<-p.GiveChannel
		fmt.Println("Philosopher ", p.Id, " took fork ", p.RightForkId)
		fmt.Println("Philosopher", p.Id, "is eating")
		p.LeftFork.ReturnChannel <- 0
		p.RightFork.ReturnChannel <- 0
		p.ToEat--
		fmt.Println("Philosopher", p.Id, "is thinking")
	}

	p.Wg.Done()
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
	var wg sync.WaitGroup

	const numPhilosophers = 3
	const toEat = 5

	philosophers := make([]Philosopher, numPhilosophers)
	forks := make([]Fork, numPhilosophers)

	for i := 0; i < numPhilosophers; i++ {
		takeChannel := make(chan TakeMessage)
		returnChannel := make(chan int)

		forks[i] = Fork{takeChannel, returnChannel}
	}

	for i := 0; i < numPhilosophers-1; i++ {
		giveChannel := make(chan int)
		wg.Add(1)
		philosophers[i] = Philosopher{i, &forks[i], &forks[i+1], i, i + 1, giveChannel, toEat, &wg}
	}

	giveChannel := make(chan int)
	wg.Add(1)
	philosophers[numPhilosophers-1] = Philosopher{numPhilosophers - 1, &forks[numPhilosophers-1], &forks[0], numPhilosophers - 1, 0, giveChannel, toEat, &wg}

	for i := 0; i < numPhilosophers; i++ {
		go forks[i].RunFork()
	}

	for i := 0; i < numPhilosophers; i++ {
		go philosophers[i].RunPhilosopher()
	}

	wg.Wait()
}
