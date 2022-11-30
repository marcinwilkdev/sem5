package wilk.marcin;

import java.util.*;
import wilk.marcin.GF.*;
import wilk.marcin.polynomial.*;

public class App {
  public static void main(String[] args) throws NoCoeffException {
    Polynomial<DoubleWrapper> firstPolynomial =
        new Polynomial<>(
            new ArrayList<DoubleWrapper>(
                Arrays.asList(
                    new DoubleWrapper(-1.0),
                    new DoubleWrapper(2.0),
                    new DoubleWrapper(0.0),
                    new DoubleWrapper(1.0))));

    Polynomial<DoubleWrapper> secondPolynomial =
        new Polynomial<>(
            new ArrayList<DoubleWrapper>(
                Arrays.asList(new DoubleWrapper(-1.0), new DoubleWrapper(1.0))));

    System.out.println(firstPolynomial.add(secondPolynomial).sub(secondPolynomial));
    System.out.println(firstPolynomial.prod(secondPolynomial).div(secondPolynomial));
    System.out.println(firstPolynomial.coeff(0));
    System.out.println(firstPolynomial.eval(new DoubleWrapper(2.0)));

    try {
      Polynomial<GF> firstPolynomialGF =
          new Polynomial<>(
              new ArrayList<GF>(
                  Arrays.asList(new GF(1), new GF(0), new GF(1), new GF(0), new GF(1))));

      Polynomial<GF> secondPolynomialGF =
          new Polynomial<>(new ArrayList<GF>(Arrays.asList(new GF(1), new GF(0), new GF(1))));

      System.out.println(firstPolynomialGF.add(secondPolynomialGF).sub(secondPolynomialGF));
      System.out.println(firstPolynomialGF.prod(secondPolynomialGF).div(secondPolynomialGF));
      System.out.println(firstPolynomialGF.coeff(0));
      System.out.println(firstPolynomialGF.eval(new GF(1)));

    } catch (GFException e) {
      System.out.println(e.getMessage());
    }
  }
}
