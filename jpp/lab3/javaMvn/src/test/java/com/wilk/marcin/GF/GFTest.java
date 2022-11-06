package com.wilk.marcin.GF;

import static org.junit.Assert.*;

import org.junit.Test;

public class GFTest {
  @Test
  public void GFcreationTest() {
    try {
      GF gf = new GF(-1);

      assertTrue(false);
    } catch (GFNegativeException e) {
      assertTrue(true);
    } catch (GFException e) {
      assertTrue(false);
    }

    try {
      GF gf = new GF(1234567891);

      assertTrue(false);
    } catch (GFTooBigException e) {
      assertTrue(true);
    } catch (GFException e) {
      assertTrue(false);
    }

    try {
      GF gf = new GF(50);

      assertEquals(gf.toLong(), 50);
    } catch (GFException e) {
      assertTrue(false);
    }
  }

  @Test
  public void GFAdditionTest() {
    try {
      GF gf1 = new GF(50);
      GF gf2 = new GF(50);

      gf1.add(gf2);

      assertEquals(gf1.toLong(), 100);

      gf1 = new GF(1234567890);
      gf2 = new GF(1);

      gf1.add(gf2);

      assertEquals(gf1.toLong(), 0);

      gf1 = new GF(1234567890);
      gf2 = new GF(1);
      GF gf3 = new GF(10);

      gf1.add(gf2).add(gf3);

      assertEquals(gf1.toLong(), 10);
    } catch (GFException e) {
      assertTrue(false);
    }
  }

  @Test
  public void GFSubtractionTest() {
    try {
      GF gf1 = new GF(51);
      GF gf2 = new GF(50);

      gf1.subtract(gf2);

      assertEquals(gf1.toLong(), 1);

      gf1 = new GF(50);
      gf2 = new GF(51);

      gf1.subtract(gf2);

      assertEquals(gf1.toLong(), 1234567890);

      gf1 = new GF(50);
      gf2 = new GF(51);
      GF gf3 = new GF(10);

      gf1.subtract(gf2).subtract(gf3);

      assertEquals(gf1.toLong(), 1234567880);
    } catch (GFException e) {
      assertTrue(false);
    }
  }

  @Test
  public void GFMultiplicationTest() {
    try {
      GF gf1 = new GF(50);
      GF gf2 = new GF(50);

      gf1.multiply(gf2);

      assertEquals(gf1.toLong(), 2500);

      gf1 = new GF(1234567890);
      gf2 = new GF(2);

      gf1.multiply(gf2);

      assertEquals(gf1.toLong(), 1234567889);

      gf1 = new GF(1234567890);
      gf2 = new GF(2);
      GF gf3 = new GF(2);

      gf1.multiply(gf2).multiply(gf3);

      assertEquals(gf1.toLong(), 1234567887);
    } catch (GFException e) {
      assertTrue(false);
    }
  }

  @Test
  public void GFDivisionTest() {
    try {
      GF gf1 = new GF(100);
      GF gf2 = new GF(50);

      gf1.divide(gf2);

      assertEquals(gf1.toLong(), 2);

      gf1 = new GF(100);
      gf2 = new GF(3);

      gf1.divide(gf2);

      assertEquals(gf1.toLong(), 33);

      gf1 = new GF(100);
      gf2 = new GF(3);
      GF gf3 = new GF(3);

      gf1.divide(gf2).divide(gf3);

      assertEquals(gf1.toLong(), 11);
    } catch (GFException e) {
      assertTrue(false);
    }
  }

}
