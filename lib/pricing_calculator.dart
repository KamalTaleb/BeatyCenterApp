import 'package:flutter/material.dart';

class SPricingCalculator {
  static double calculateTotalPrice(double servicePrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = servicePrice * taxRate;

    double shippingCost = getShippingCost(location);
    double totalPrice = servicePrice + taxAmount + shippingCost;
    return totalPrice;
  }

  static String calculateShippingCost(double servicePrice, String location) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  static String calculateTax(double servicePrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = servicePrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(String location) {
    return 0.10;
  }

  static double getShippingCost(String location) {
    return 5.00;
  }
}
