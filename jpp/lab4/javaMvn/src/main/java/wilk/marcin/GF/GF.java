package wilk.marcin.GF;

import wilk.marcin.polynomial.PolynomialType;

public class GF implements PolynomialType<GF> {
  private static final long MAX_VALUE = 2;

  private long number;

  public GF(long number) {
    while (number < 0) {
      number += MAX_VALUE;
    }

    this.number = number % MAX_VALUE;
    ;
  }

  public GF neutral() {
    return new GF(0);
  }

  private GF inverse() {
    if (this.number == 0) {
      throw new ArithmeticException("No inverse for 0");
    }

    final long result = gcd(this.number, MAX_VALUE);

    return new GF(result);
  }

  public GF add(final GF other) {
    return new GF(this.number + other.number);
  }

  public GF sub(final GF other) {
    return new GF(this.number - other.number);
  }

  public GF prod(final GF other) {
    return new GF(this.number * other.number);
  }

  public GF div(final GF other) {
    return this.prod(other.inverse());
  }

  public GF pow(final long pow) {
    long number = this.number;
    long result = 1;

    long power = pow;

    while (power > 0) {
      if (power % 2 == 1) {
        result = (result * number) % GF.MAX_VALUE;
      }

      number = (number * number) % GF.MAX_VALUE;
      power /= 2;
    }

    return new GF(result);
  }

  public long toLong() {
    return this.number;
  }

  public boolean gt(final GF other) {
    return this.number > other.number;
  }

  public boolean lt(final GF other) {
    return this.number < other.number;
  }

  @Override
  public boolean equals(Object obj) {
    if (this == obj) {
      return true;
    }

    if (obj == null) {
      return false;
    }

    if (getClass() != obj.getClass()) {
      return false;
    }

    GF other = (GF) obj;

    return this.number == other.number;
  }

  @Override
  public String toString() {
    return String.valueOf(this.number);
  }

  private static long gcd(final long a, final long b) {
    long x = 1;
    long y = 0;

    long x1 = 0;
    long y1 = 1;
    long a1 = a;
    long b1 = b;

    while (b1 != 0) {
      long q = a1 / b1;

      final long x1Tmp = x1;
      x1 = x - q * x1;
      x = x1Tmp;

      final long y1Tmp = y1;
      y1 = y - q * y1;
      y = y1Tmp;

      final long b1Tmp = b1;
      b1 = a1 - q * b1;
      a1 = b1Tmp;
    }

    return x;
  }
}
