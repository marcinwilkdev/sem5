package com.wilk.marcin;

import com.wilk.marcin.GF.*;

public class App {

  public static void main(String[] args) {
    try {
      GF gf = new GF(-50);

      System.out.println(gf);
    } catch (GFException e) {
      System.out.println(e.getMessage());
    }
  }
}
