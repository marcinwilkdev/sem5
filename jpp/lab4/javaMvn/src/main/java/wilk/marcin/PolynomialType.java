package wilk.marcin;

public interface PolynomialType<P> {
  P neutral();

  P value();

  P add(P p);

  P sub(P p);

  P prod(P p);

  P div(P p);

  P pow(int pow);

  boolean gt(P other);

  boolean lt(P other);
}
