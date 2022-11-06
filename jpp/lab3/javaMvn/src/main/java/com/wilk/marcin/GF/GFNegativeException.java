package com.wilk.marcin.GF;

public class GFNegativeException extends GFException {
  public GFNegativeException(String errorMessage) {
    super(errorMessage);
  }

  public GFNegativeException(String errorMessage, Throwable err) {
    super(errorMessage, err);
  }
}
