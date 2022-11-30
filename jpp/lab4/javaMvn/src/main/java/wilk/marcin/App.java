package wilk.marcin;

import java.util.*;

public class App {
  public static void main(String[] args) {
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

    System.out.println(firstPolynomial.add(secondPolynomial));
  }
}
