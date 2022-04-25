import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const kprimaryColor = Color(0xff16AA32);
const kdarkGreen = Color(0xff0D7D19);
const kdarkMediumGreen = Color(0xff0FBD21);
const kmediumGreen = Color(0xff14E729);
const kmediumlightGreen = Color(0xff3DE959);
const klightGreen = Color(0xff75EC9A);
const kgreycolor1 = Color(0xffC8C8C8);
const kgreycolor2 = Color(0xffA8A8A8);
const kgreycolor3 = Color(0xff808080);
const bgColor = Color(0xffE1F9E0);
const kbtnColor = Color(0xff16AA32);
const kbgColor = Color(0xffE1F9E0);

Widget gapw({double w = 20}) {
  return SizedBox(
    width: w.w,
  );
}

Widget gaph({double h = 20}) {
  return SizedBox(
    height: h.h,
  );
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

MaterialColor kprimarySwatch = createMaterialColor(kprimaryColor);
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
