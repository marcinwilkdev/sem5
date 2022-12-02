package wilk.marcin.polynomial;

public class DoubleWrapper implements PolynomialType<DoubleWrapper> {
  private double value;

  public DoubleWrapper(double value) {
    this.value = value;
  }

  @Override
  public DoubleWrapper neutral() {
    return new DoubleWrapper(0.0);
  }

  @Override
  public DoubleWrapper add(DoubleWrapper p) {
    return new DoubleWrapper(this.value + p.value);
  }

  @Override
  public DoubleWrapper sub(DoubleWrapper p) {
    return new DoubleWrapper(this.value - p.value);
  }

  @Override
  public DoubleWrapper prod(DoubleWrapper p) {
    return new DoubleWrapper(this.value * p.value);
  }

  @Override
  public DoubleWrapper div(DoubleWrapper p) {
    return new DoubleWrapper(this.value / p.value);
  }

  @Override
  public DoubleWrapper pow(long p) {
    return new DoubleWrapper(Math.pow(this.value, p));
  }

  @Override
  public boolean gt(DoubleWrapper other) {
    return this.value > other.value;
  }

  @Override
  public boolean lt(DoubleWrapper other) {
    return this.value < other.value;
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

    DoubleWrapper other = (DoubleWrapper) obj;

    return this.value == other.value;
  }

  @Override
  public String toString() {
    return String.valueOf(this.value);
  }
}
