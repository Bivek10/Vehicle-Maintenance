import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CostumTextBorder {
  static InputDecoration textfieldDecoration({
    required context,
    required hintText,
    required lableText,
    required IconData iconData,
    IconButton? suffixIcon,
  }) {
    return InputDecoration(
      //suffixIconColor: Colors.orange,
      hintText: hintText,
      labelText: lableText,
      suffixIcon: suffixIcon != null ? suffixIcon : null,
      prefixIcon: Icon(
        iconData,
        color: Colors.orangeAccent,
      ),
      focusColor: Colors.orangeAccent,
      labelStyle: GoogleFonts.lato(
        textStyle: Theme.of(context).textTheme.headline2,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: Colors.orangeAccent,
        letterSpacing: 0.7,
      ),
      hintStyle: GoogleFonts.lato(
        textStyle: Theme.of(context).textTheme.headline2,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: Colors.orangeAccent,
        letterSpacing: 0.7,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.black,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      border: new OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
          width: 2.0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      isDense: false,
    );
  }

  static TextStyle textfieldstyle = GoogleFonts.lato(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    color: Colors.grey,
    letterSpacing: 0.7,
  );
}
