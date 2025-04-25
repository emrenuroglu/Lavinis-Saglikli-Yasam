import 'package:flutter/material.dart';

// Tekrar kullanılabilir Text widget'ı oluşturma fonksiyonu
Widget customText(String text, {double fontSize = 18, FontWeight fontWeight = FontWeight.w500}) {
  return Text(
    text,
    style: TextStyle(
      color: Colors.purple.shade600,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  );
}