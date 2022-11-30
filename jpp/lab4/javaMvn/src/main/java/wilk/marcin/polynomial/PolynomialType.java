package wilk.marcin.polynomial;

public interface PolynomialType<P> {
  P neutral();

  P add(P p);

  P sub(P p);

  P prod(P p);

  P div(P p);

  P pow(long pow);

  boolean gt(P other);

  boolean lt(P other);
}
