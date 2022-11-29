package wilk.marcin;

public interface PolynomialType<P> {
  PolynomialType<P> neutral();
  PolynomialType<P> value();
  boolean gt(PolynomialType<P> other);
}
