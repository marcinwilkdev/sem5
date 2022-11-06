package com.wilk.marcin.GF;

public class GFDivisionByZeroException extends GFException {
  public GFDivisionByZeroException(String errorMessage) {
    super(errorMessage);
  }

  public GFDivisionByZeroException(String errorMessage, Throwable err) {
    super(errorMessage, err);
  }
}
