package wilk.marcin;

public interface PolynomialType<P> {
  P neutral();

  P value();

  P add(P p);

  boolean gt(P other);
}
