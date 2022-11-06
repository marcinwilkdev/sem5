package com.wilk.marcin.GF;

public class GFTooBigException extends GFException {
  public GFTooBigException(String errorMessage) {
    super(errorMessage);
  }

  public GFTooBigException(String errorMessage, Throwable err) {
    super(errorMessage, err);
  }
}
