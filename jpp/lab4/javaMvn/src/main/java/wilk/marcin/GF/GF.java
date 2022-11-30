package wilk.marcin.GF;

import wilk.marcin.polynomial.PolynomialType;

public class GF implements PolynomialType<GF> {
  private static final long MAX_VALUE = 2;

  private long number;

  public GF(long number) throws GFException {
    if (number < 0) {
      throw new GFNegativeException("Value can't be negative!");
    }

    if (number >= MAX_VALUE) {
      throw new GFTooBigException("Value has to be less than: " + MAX_VALUE);
    }

    this.number = number;
  }

  public GF() {
    this.number = 0;
  }

  public GF neutral() {
    return new GF();
  }

  public GF add(GF other) {
    this.number = (this.number + other.number) % MAX_VALUE;

    return this;
  }

  public GF sub(GF other) {
    this.number = (this.number - other.number) % MAX_VALUE;

    if (this.number < 0) {
      this.number += MAX_VALUE;
    }

    return this;
  }

  public GF prod(GF other) {
    this.number = (this.number * other.number) % MAX_VALUE;

    return this;
  }

  public GF div(GF other) {
    if (other.number == 0) {
      throw new ArithmeticException("Division by zero!");
    }

    this.number = this.number / other.number;

    return this;
  }

  public GF pow(long pow) {
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

    try {
      return new GF(result);
    } catch (GFException e) {
      throw new RuntimeException(e);
    }
  }

  public long toLong() {
    return this.number;
  }

  public boolean gt(GF other) {
    return this.number > other.number;
  }

  public boolean lt(GF other) {
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
    StringBuilder sb = new StringBuilder("GF(");
    sb.append(this.number);
    sb.append(")");

    return sb.toString();
  }
}
