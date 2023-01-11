with Ada.Text_IO; use Ada.Text_IO;

procedure Main is
  protected type Semaphore is
    entry Wait;
    procedure Unlock;
  private
    Locked : Boolean := True;
  end Semaphore;

  protected body Semaphore is
    entry Wait when not Locked is
    begin
      null;
    end Wait;

    procedure Unlock is
    begin
      Locked := False;
    end Unlock;
  end Semaphore;

  protected type Mutex is
    entry Lock;
    procedure Unlock;
  private
    Locked : Boolean := False;
  end Mutex;

  protected body Mutex is
    entry Lock when not Locked is
    begin
      Locked := True;
    end Lock;

    procedure Unlock is
    begin
      Locked := False;
    end Unlock;
  end Mutex;

  type Ptr_Semaphore is access Semaphore;
  type Ptr_Mutex is access Mutex;

  task type Philosopher
   (Start_Semaphore : Ptr_Semaphore; Left_Fork : Ptr_Mutex;
    Right_Fork      : Ptr_Mutex; Id : Integer; To_Eat : Integer)
  ;
  type Ptr_Philosoper is access Philosopher;

  task body Philosopher is
    Left_To_Eat : Integer := To_Eat;
  begin
    Start_Semaphore.Wait;
    while Left_To_Eat > 0 loop
      Put_Line ("Philosopher " & Id'Img & " is thinking");
      Left_Fork.Lock;
      Right_Fork.Lock;
      Put_Line ("Philosopher " & Id'Img & " is eating");
      Right_Fork.Unlock;
      Left_Fork.Unlock;

      Left_To_Eat := Left_To_Eat - 1;
    end loop;
  end Philosopher;

  procedure Main_Loop (N : Integer) is
    Start_Semaphore : Ptr_Semaphore;
    Forks           : array (0 .. N - 1) of Ptr_Mutex;
    Philosophers    : array (0 .. N - 1) of Ptr_Philosoper;
  begin
    Start_Semaphore := new Semaphore;

    for I in 0 .. N - 1 loop
      Forks (I) := new Mutex;
    end loop;

    for I in 0 .. N - 2 loop
      Philosophers (I) :=
       new Philosopher (Start_Semaphore, Forks (I), Forks (I + 1), I, 10);
    end loop;

    Philosophers (N - 1) :=
     new Philosopher (Start_Semaphore, Forks (N - 1), Forks (0), N - 1, 10);

    Start_Semaphore.Unlock;
  end Main_Loop;
begin
  Main_Loop (3);
end Main;
