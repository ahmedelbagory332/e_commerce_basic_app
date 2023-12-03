import 'package:flutter/material.dart';

const kTextColor = Color(0xFFFFFFFF);
const kTextLightColor = Color(0xFFACACAC);

const kDefaultPaddin = 20.0;
const kMainColor = Color(0xFFBBD6B8);
const kMainDarkColor = Color(0xFF557C55);
const Color greyscale900 = Color(0xFF212121);
const Color kDarkBlue = Color(0xffa42903);
bool isValidCardNumber(String cardNumber) {
  RegExp visaRegex = RegExp(r'^4[0-9]{12}(?:[0-9]{3})?$'); // Visa pattern
  RegExp mastercardRegex = RegExp(r'^5[1-5][0-9]{14}$'); // Mastercard pattern
  RegExp amexRegex = RegExp(r'^3[47][0-9]{13}$'); // American Express pattern

  if (visaRegex.hasMatch(cardNumber)) {
    return true; // Visa card pattern matched
  } else if (mastercardRegex.hasMatch(cardNumber)) {
    return true; // Mastercard pattern matched
  } else if (amexRegex.hasMatch(cardNumber)) {
    return true; // American Express pattern matched
  } else {
    return false; // No matching card pattern found
  }
}
