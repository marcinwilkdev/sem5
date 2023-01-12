package wilk.marcin;

public class Fork {
  public synchronized void useFork(Philosopher p, int forkId) {
    System.out.println("Philosopher " + p.id() + " took fork " + forkId);

    p.incrementForkCount();

    while (p.forkCount() > 0) {}
  }
}
