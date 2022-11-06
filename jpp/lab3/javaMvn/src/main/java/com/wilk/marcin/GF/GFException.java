package com.wilk.marcin.GF;

public abstract class GFException extends Exception {
  public GFException(String errorMessage) {
    super(errorMessage);
  }

  public GFException(String errorMessage, Throwable err) {
    super(errorMessage, err);
  }
}
