import 'package:flutter/material.dart';

class CustomTextFieldDecoration {
  static InputDecoration create() {
    return InputDecoration(
      labelText: '',
      contentPadding: EdgeInsets.only(top: 0,bottom: 0,left: 12,right: 12),
      border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15)
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15)
      ),
      filled: true,
    );
  }
}

class CustomMultiTextInputDecoration {
  static InputDecoration create() {
    return InputDecoration(
      labelText: '',
      contentPadding: EdgeInsets.only(top: 12,bottom: 12,left: 12,right: 12),
      border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15)
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15)
      ),
      filled: true,
    );
  }
}
