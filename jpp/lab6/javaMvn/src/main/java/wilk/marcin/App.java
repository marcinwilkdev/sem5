package wilk.marcin;

public class App {
  public static void main(String[] args) {
    int numPhilosophers = 10;

    Philosopher[] philosophers = new Philosopher[numPhilosophers];
    Fork[] forks = new Fork[numPhilosophers];

    for (int i = 0; i < numPhilosophers; i++) {
      forks[i] = new Fork();
    }

    for (int i = 0; i < numPhilosophers; i++) {
      philosophers[i] =
          new Philosopher(
              forks[i], forks[(i + 1) % numPhilosophers], i, i, (i + 1) % numPhilosophers);
    }

    for (int i = 0; i < numPhilosophers; i++) {
      final int index = i;
      new Thread(() -> philosophers[index].mainLoop()).start();
    }
  }
}
