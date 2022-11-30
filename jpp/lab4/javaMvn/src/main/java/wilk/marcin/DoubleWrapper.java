package wilk.marcin;

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
  public DoubleWrapper value() {
    return this;
  }

  @Override
  public DoubleWrapper add(DoubleWrapper p) {
    return new DoubleWrapper(this.value + p.value);
  }

  @Override
  public boolean gt(DoubleWrapper other) {
    return this.value > other.value;
  }

  @Override
  public boolean equals(Object obj) {
    if (obj == null || !(obj instanceof DoubleWrapper)) {
      return false;
    }

    return this.value == ((DoubleWrapper) obj).value;
  }

  @Override
  public String toString() {
    return Double.toString(value);
  }
}
