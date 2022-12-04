factorial(0, 1) :- !.
factorial(N, X) :-
  N > 0,
  N1 is N - 1,
  factorial(N1, X1),
  X is N * X1.

gcd(X, 0, X) :- !.
gcd(X, Y, G) :-
  Y > 0,
  Y1 is X mod Y,
  gcd(Y, Y1, G).

diof(A, B, C, M, N) :-
  gcd(A, B, D),
  gcd(C, D, D),
  diof1(A, B, X, Y),
  M is X * (C // D),
  N is Y * (C // D).

diof1(_, 0, 1, 0) :- !.
diof1(A, B, X, Y) :-
  C is A mod B,
  diof1(B, C, X1, Y1),
  X is Y1,
  Y is X1 - (A // B) * Y1.
