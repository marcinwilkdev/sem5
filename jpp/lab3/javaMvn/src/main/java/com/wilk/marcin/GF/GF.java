package com.wilk.marcin.GF;

public class GF {
  private static final long MAX_VALUE = 1234567891;

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

  public GF(int number) throws GFException {
    this((long) number);
  }

  public GF(short number) throws GFException {
    this((long) number);
  }

  public GF(byte number) throws GFException {
    this((long) number);
  }

  public GF add(GF other) {
    this.number = (this.number + other.number) % MAX_VALUE;

    return this;
  }

  public GF subtract(GF other) {
    this.number = (this.number - other.number) % MAX_VALUE;

    if (this.number < 0) {
      this.number += MAX_VALUE;
    }

    return this;
  }

  public GF multiply(GF other) {
    this.number = (this.number * other.number) % MAX_VALUE;

    return this;
  }

  public GF divide(GF other) throws GFException {
    if (other.number == 0) {
      throw new GFDivisionByZeroException("Division by zero!");
    }

    this.number = this.number / other.number;

    return this;
  }

  public long toLong() {
    return this.number;
  }
  
  public boolean greaterThan(GF other) {
    return this.number > other.number;
  }

  public boolean lessThan(GF other) {
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

    GF other = (GF)obj;

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
