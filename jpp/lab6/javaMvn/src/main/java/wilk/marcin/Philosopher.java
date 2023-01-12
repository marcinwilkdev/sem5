package wilk.marcin;

public class Philosopher {
  private int id;
  private Integer forkCount;
  private Fork firstFork;
  private Fork secondFork;
  private int firstForkId;
  private int secondForkId;

  public Philosopher(Fork firstFork, Fork secondFork, int id, int firstForkId, int secondForkId) {
    this.forkCount = 0;
    this.firstFork = firstFork;
    this.secondFork = secondFork;
    this.id = id;
    this.firstForkId = firstForkId;
    this.secondForkId = secondForkId;
  }

  public int forkCount() {
    synchronized (this.forkCount) {
      return this.forkCount;
    }
  }

  public void incrementForkCount() {
    synchronized (this.forkCount) {
      this.forkCount++;
    }
  }

  public void clearForks() {
    synchronized (this.forkCount) {
      this.forkCount = 0;
    }
  }

  public int id() {
    return this.id;
  }

  public void mainLoop() {
    while (true) {
      System.out.println("Philosopher " + this.id + " is taking forks.");

      new Thread(() -> this.firstFork.useFork(this, this.firstForkId)).start();
      new Thread(() -> this.secondFork.useFork(this, this.secondForkId)).start();

      while (this.forkCount() < 2) {}

      System.out.println("Philosopher " + this.id + " is eating");

      clearForks();

      System.out.println("Philosopher " + this.id + " is thinking");
    }
  }
}
