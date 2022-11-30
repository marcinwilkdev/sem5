package wilk.marcin;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class Polynomial<P extends PolynomialType<P>> {
  private List<P> coefficients;

  public Polynomial(final List<P> coefficients) {
    this.coefficients = coefficients;
    this.normalize();
  }

  public Polynomial(final P[] coefficients) {
    this.coefficients = new ArrayList<>(Arrays.asList(coefficients));
    this.normalize();
  }

  public Polynomial<P> add(Polynomial<P> other) {
    final int maxDegree =
        this.coefficients.size() > other.coefficients.size()
            ? this.coefficients.size()
            : other.coefficients.size();

    if (maxDegree == 0) {
      return new Polynomial<P>(new ArrayList<>());
    }

    P neutralElement =
        this.coefficients.stream()
            .findFirst()
            .orElse(other.coefficients.stream().findFirst().get())
            .neutral();

    var thisIter =
        Stream.concat(this.coefficients.stream(), Stream.generate(() -> neutralElement)).iterator();

    var otherIter =
        Stream.concat(other.coefficients.stream(), Stream.generate(() -> neutralElement))
            .iterator();

    Polynomial<P> result =
        new Polynomial<>(
            Stream.generate(() -> neutralElement)
                .map((n) -> n.add(thisIter.next()).add(otherIter.next()))
                .limit(maxDegree)
                .collect(Collectors.toList()));

    result.normalize();

    return result;
  }

  public Polynomial<P> sub(Polynomial<P> other) {
    final int maxDegree =
        this.coefficients.size() > other.coefficients.size()
            ? this.coefficients.size()
            : other.coefficients.size();

    if (maxDegree == 0) {
      return new Polynomial<P>(new ArrayList<>());
    }

    P neutralElement =
        this.coefficients.stream()
            .findFirst()
            .orElse(other.coefficients.stream().findFirst().get())
            .neutral();

    var thisIter =
        Stream.concat(this.coefficients.stream(), Stream.generate(() -> neutralElement)).iterator();

    var otherIter =
        Stream.concat(other.coefficients.stream(), Stream.generate(() -> neutralElement))
            .iterator();

    Polynomial<P> result =
        new Polynomial<>(
            Stream.generate(() -> neutralElement)
                .map((n) -> n.add(thisIter.next()).sub(otherIter.next()))
                .limit(maxDegree)
                .collect(Collectors.toList()));

    result.normalize();

    return result;
  }

  public Polynomial<P> prod(Polynomial<P> other) {
    int resultDegree = this.coefficients.size() + other.coefficients.size() - 1;

    if (resultDegree <= 0) {
      return new Polynomial<P>(new ArrayList<>());
    }

    P neutralElement =
        this.coefficients.stream()
            .findFirst()
            .orElse(other.coefficients.stream().findFirst().get())
            .neutral();

    ArrayList<P> resultCoefficients =
        new ArrayList<>(Collections.nCopies(resultDegree, neutralElement));

    for (int thisIdx = 0; thisIdx < this.coefficients.size(); thisIdx++) {
      for (int otherIdx = 0; otherIdx < other.coefficients.size(); otherIdx++) {
        resultCoefficients.set(
            thisIdx + otherIdx,
            resultCoefficients
                .get(thisIdx + otherIdx)
                .add(this.coefficients.get(thisIdx).prod(other.coefficients.get(otherIdx))));
      }
    }

    Polynomial<P> result = new Polynomial<>(resultCoefficients);

    result.normalize();

    return result;
  }

  public Polynomial<P> div(Polynomial<P> other) {
    if (this.coefficients.size() == 0 && other.coefficients.size() == 0) {
      return new Polynomial<P>(new ArrayList<>());
    }

    Polynomial<P> remainder = new Polynomial<>(this.coefficients);

    P neutralElement =
        this.coefficients.stream()
            .findFirst()
            .orElse(other.coefficients.stream().findFirst().get())
            .neutral();

    final int quotientSize =
        this.coefficients.size() > other.coefficients.size()
            ? this.coefficients.size() - other.coefficients.size()
            : 0;

    Polynomial<P> quotient =
        new Polynomial<>(new ArrayList<>(Collections.nCopies(quotientSize, neutralElement)));

    while (remainder.coefficients.size() >= other.coefficients.size()) {
      P leadingCoefficient =
          remainder
              .coefficients
              .get(remainder.coefficients.size() - 1)
              .div(other.coefficients.get(other.coefficients.size() - 1));

      ArrayList<P> newQuotientCoefficients =
          new ArrayList<>(
              Collections.nCopies(
                  remainder.coefficients.size() - other.coefficients.size() + 1, neutralElement));

      newQuotientCoefficients.set(newQuotientCoefficients.size() - 1, leadingCoefficient);

      Polynomial<P> newQuotient = new Polynomial<>(newQuotientCoefficients);

      quotient = quotient.add(newQuotient);
      remainder = remainder.sub(other.prod(newQuotient));

      remainder.normalize();
    }

    quotient.normalize();

    return quotient;
  }

  public Polynomial<P> rem(Polynomial<P> other) {
    if (this.coefficients.size() == 0 && other.coefficients.size() == 0) {
      return new Polynomial<P>(new ArrayList<>());
    }

    Polynomial<P> remainder = new Polynomial<>(this.coefficients);

    P neutralElement =
        this.coefficients.stream()
            .findFirst()
            .orElse(other.coefficients.stream().findFirst().get())
            .neutral();

    final int quotientSize =
        this.coefficients.size() > other.coefficients.size()
            ? this.coefficients.size() - other.coefficients.size()
            : 0;

    Polynomial<P> quotient =
        new Polynomial<>(new ArrayList<>(Collections.nCopies(quotientSize, neutralElement)));

    while (remainder.coefficients.size() >= other.coefficients.size()) {
      P leadingCoefficient =
          remainder
              .coefficients
              .get(remainder.coefficients.size() - 1)
              .div(other.coefficients.get(other.coefficients.size() - 1));

      ArrayList<P> newQuotientCoefficients =
          new ArrayList<>(
              Collections.nCopies(
                  remainder.coefficients.size() - other.coefficients.size() + 1, neutralElement));

      newQuotientCoefficients.set(newQuotientCoefficients.size() - 1, leadingCoefficient);

      Polynomial<P> newQuotient = new Polynomial<>(newQuotientCoefficients);

      quotient = quotient.add(newQuotient);
      remainder = remainder.sub(other.prod(newQuotient));

      remainder.normalize();
    }

    remainder.normalize();

    return remainder;
  }

  public boolean gt(Polynomial<P> other) {
    if (this.coefficients.size() > other.coefficients.size()) {
      return true;
    } else if (this.coefficients.size() < other.coefficients.size()) {
      return false;
    } else {
      for (int coeffIdx = this.coefficients.size() - 1; coeffIdx >= 0; coeffIdx--) {
        if (this.coefficients.get(coeffIdx).gt(other.coefficients.get(coeffIdx))) {
          return true;
        } else if (this.coefficients.get(coeffIdx).lt(other.coefficients.get(coeffIdx))) {
          return false;
        }
      }

      return false;
    }
  }

  public boolean lt(Polynomial<P> other) {
    if (this.coefficients.size() < other.coefficients.size()) {
      return true;
    } else if (this.coefficients.size() > other.coefficients.size()) {
      return false;
    } else {
      for (int coeffIdx = this.coefficients.size() - 1; coeffIdx >= 0; coeffIdx--) {
        if (this.coefficients.get(coeffIdx).lt(other.coefficients.get(coeffIdx))) {
          return true;
        } else if (this.coefficients.get(coeffIdx).gt(other.coefficients.get(coeffIdx))) {
          return false;
        }
      }

      return false;
    }
  }

  public P coeff(int coeffIdx) throws NoCoeffException {
    if (coeffIdx >= this.coefficients.size()) {
      throw new NoCoeffException();
    } else {
      return this.coefficients.get(coeffIdx);
    }
  }

  public P eval(P x) {
    P result = this.coefficients.get(0).neutral();

    for (int coeffIdx = 0; coeffIdx < this.coefficients.size(); coeffIdx++) {
      result = result.add(this.coefficients.get(coeffIdx).prod(x.pow(coeffIdx)));
    }

    return result;
  }

  @Override
  public boolean equals(Object obj) {
    if (obj == null || !(obj instanceof Polynomial)) {
      return false;
    }

    return this.coefficients.equals(((Polynomial<P>) obj).coefficients);
  }

  @Override
  public String toString() {
    if (this.coefficients.size() == 0) {
      return "0";
    }

    StringBuilder sb = new StringBuilder();

    for (int coeffIdx = this.coefficients.size() - 1; coeffIdx >= 0; coeffIdx--) {
      P coeff = this.coefficients.get(coeffIdx);

      if (!coeff.equals(coeff.neutral())) {
        if (coeffIdx < this.coefficients.size() - 1) {
          sb.append(" + ");
        }

        sb.append(coeff.toString());

        if (coeffIdx > 0) {
          sb.append("x^");
          sb.append(coeffIdx);
        }
      }
    }

    return sb.toString();
  }

  private void normalize() {
    if (this.coefficients.size() == 0) {
      return;
    }

    for (int coeffIdx = this.coefficients.size() - 1; coeffIdx >= 0; --coeffIdx) {
      final P neutralElement = this.coefficients.get(0).neutral();

      if (!this.coefficients.get(coeffIdx).equals(neutralElement)) {
        break;
      }

      this.coefficients.remove(coeffIdx);
    }
  }
}
