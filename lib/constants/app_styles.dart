import 'package:flutter/material.dart';

class AppStyles {
  static const Color primaryColor = Color(0xFF046380);

  static ButtonStyle activeButton = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    // fixedSize: MaterialStateProperty.all<Size>(
    //   const Size(20, 40),
    // ),
  );

  static ButtonStyle nonActiveButton = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    // fixedSize: MaterialStateProperty.all<Size>(
    //   const Size(20, 40),
    // ),
  );
}

class CustomTextStyles {
  static const TextStyle s10w600cb = TextStyle(
    color: Colors.black,
    fontSize: 10,
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w600,
  );

  static const TextStyle s16w400cb = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w400,
  );

  static const TextStyle s16w400cw = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w400,
  );

  static const TextStyle s20w400cb = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w400,
  );

  static const TextStyle s20w600cb = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w600,
  );
}
