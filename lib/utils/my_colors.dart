import 'dart:ui';

class MyColors {
  static final blackColor = HexColor('#0e0e0e');
  static final whiteColor = HexColor('#ffffff');
  static final purpleColor = HexColor('#471aa0');
  static final lightpurpleColor = HexColor('#9747ff');
  }

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final hexColor) : super(_getColorFromHex(hexColor));
}
