import 'package:clmd_flutter/utils/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const double headerHeight = 90;

const double pagePaddingNum = 37;

final EdgeInsets pagePadding =
    EdgeInsets.only(left: pagePaddingNum.w, right: pagePaddingNum.w);

final EdgeInsets pagePaddingAll = EdgeInsets.all(pagePaddingNum.w);

class CommonColors {
  // static const primaryColor = Color.fromRGBO(2, 129, 117, 1);
  // static const primary2Color = Color.fromRGBO(0, 152, 116, 1);
  // static const secondColor = Color.fromRGBO(146, 220, 139, 1);
  // static const thirdColor = Color.fromRGBO(147, 220, 139, 0.45);
  // static const fourColor = Color.fromRGBO(233, 248, 232, 1);
  // static const fiveColor = Color.fromRGBO(24, 175, 154, 1);
  // static const iconBgColor = Color.fromRGBO(206, 239, 203, 1);
  // static const defaultButtonColor = Color.fromRGBO(28, 93, 84, 1);
  // static const homeButtonColor = Color.fromRGBO(255, 227, 178, 1);
  // static const homeButtonTextColor = Color.fromRGBO(0, 0, 0, 1);
  // static const reverseColor = Color.fromRGBO(240, 158, 46, 1);
  // static const homeBgOfAge = Color.fromRGBO(255, 251, 242, 1);
  // static const boxShadow = Color.fromRGBO(0, 0, 0, 0.09);
  // static const textShadow = Color.fromRGBO(248, 248, 248, 1);
  // static const lightPrimaryColor = Color.fromRGBO(24, 176, 155, 1);
  // static const tipsBgColor = Color.fromRGBO(234, 234, 234, 1);
  // static const primaryFontColor = Color.fromRGBO(70, 70, 70, 1);
  // static const primaryGray = Color.fromRGBO(181, 181, 181, 1);
  // static const deepRedFont = Color.fromRGBO(252, 0, 78, 1);
  // static const lightFont = Color.fromRGBO(70, 70, 70, 1);

  static Color primaryColor = Env<Color>().withL([
    const Color.fromRGBO(59, 123, 255, 1),
    const Color.fromRGBO(2, 129, 117, 1),
  ]);
  static Color secondColor = Env<Color>().withL([
    const Color.fromRGBO(167, 196, 255, 1),
    const Color.fromRGBO(146, 220, 139, 1),
  ]);
  static Color defaultButtonColor = Env<Color>().withL([
    const Color.fromRGBO(59, 123, 255, 1),
    const Color.fromRGBO(2, 129, 117, 1),
  ]);
  static Color homeButtonColor = Env<Color>().withL([
    const Color.fromRGBO(59, 123, 255, 1),
    const Color.fromRGBO(2, 129, 117, 1)
  ]);
  static Color homeButtonTextColor = Env<Color>().withL([
    const Color.fromRGBO(0, 0, 0, 1),
    const Color.fromRGBO(2, 129, 117, 1),
  ]);
  static Color primary2Color = Env<Color>().withL([
    const Color.fromRGBO(59, 123, 255, 1),
    const Color.fromRGBO(2, 129, 117, 1),
  ]);
  static Color homeBgOfAge = Env<Color>().withL([
    const Color.fromRGBO(255, 255, 255, 1),
    const Color.fromRGBO(2, 129, 117, 1),
  ]);
  static Color thirdColor = Env<Color>().withL([
    const Color.fromRGBO(167, 196, 255, 1),
    const Color.fromRGBO(2, 129, 117, 1),
  ]);
  static Color fourColor = Env<Color>().withL([
    const Color.fromRGBO(243, 247, 255, 1),
    const Color.fromRGBO(2, 129, 117, 1),
  ]);
  static Color fiveColor = Env<Color>().withL([
    const Color.fromRGBO(136, 175, 255, 1),
    const Color.fromRGBO(2, 129, 117, 1),
  ]);
  static Color reverseColor = Env<Color>().withL([
    const Color.fromRGBO(252, 0, 78, 1),
    const Color.fromRGBO(2, 129, 117, 1),
  ]);
  static Color boxShadow = Env<Color>().withL([
    const Color.fromRGBO(0, 0, 0, 0.09),
    const Color.fromRGBO(2, 129, 117, 1),
  ]);
  static Color textShadow = Env<Color>().withL([
    const Color.fromRGBO(248, 248, 248, 1),
    const Color.fromRGBO(2, 129, 117, 1),
  ]);
  static Color lightPrimaryColor = Env<Color>().withL([
    const Color.fromRGBO(136, 175, 255, 1),
    const Color.fromRGBO(2, 129, 117, 1),
  ]);
  static Color tipsBgColor = Env<Color>().withL([
    const Color.fromRGBO(234, 234, 234, 1),
    const Color.fromRGBO(2, 129, 117, 1),
  ]);
  static Color primaryFontColor = Env<Color>().withL([
    const Color.fromRGBO(70, 70, 70, 1),
    const Color.fromRGBO(2, 129, 117, 1),
  ]);
  static Color primaryGray = Env<Color>().withL([
    const Color.fromRGBO(181, 181, 181, 1),
    const Color.fromRGBO(2, 129, 117, 1),
  ]);
  static Color deepRedFont = Env<Color>().withL([
    const Color.fromRGBO(252, 0, 78, 1),
    const Color.fromRGBO(2, 129, 117, 1),
  ]);
  static Color lightFont = Env<Color>().withL([
    const Color.fromRGBO(70, 70, 70, 1),
    const Color.fromRGBO(2, 129, 117, 1),
  ]);
  static Color iconBgColor = Env<Color>().withL([
    const Color.fromRGBO(202, 219, 255, 1),
    const Color.fromRGBO(2, 129, 117, 1),
  ]);
  static Color roamTextColor = Env<Color>().withL([
    const Color.fromRGBO(51, 51, 51, 1),
    const Color.fromRGBO(2, 129, 117, 1),
  ]);
  static Color fillColor = Env<Color>().withL([
    const Color.fromRGBO(245, 245, 245, 1),
    const Color.fromRGBO(2, 129, 117, 1),
  ]);

  static const primaryBgColor = Color.fromRGBO(255, 255, 255, 1);

  static const deepGrey = Color.fromRGBO(101, 101, 101, 1);
  static const normalGrey = Color.fromRGBO(166, 166, 166, 1);
  static const normalBlack = Color.fromRGBO(89, 89, 89, 1);
  static const maskGrey = Color.fromRGBO(56, 56, 56, .5);
  static const lightGrey = Color.fromRGBO(204, 204, 204, 1);
  static const normalRed = Color.fromRGBO(255, 63, 63, 1);
  static const deepRed = Color.fromRGBO(218, 20, 20, 1);

  static const normalYellow = Color.fromRGBO(255, 217, 54, 1);
  static const unSelectedColor = Color.fromRGBO(243, 247, 255, 1);
  static const unSelectedColor2 = Color.fromRGBO(21, 89, 223, 1); //
  static const blueFont = Color.fromRGBO(41, 105, 235, 1); // Color(0xFF2969EB);
  static const black = Color.fromRGBO(0, 0, 0, 1); // Color(0xFF000000);
  static const red = Color.fromRGBO(252, 0, 78, 1); // Color(0xFFFC004E);
  static const grey = Color.fromRGBO(130, 130, 130, 1); // Color(0xFF828282);
  static const health_color_green =
      Color.fromRGBO(90, 213, 90, 1); //const Color(0xff5AD55A);
  static const health_color_yellow =
      Color.fromRGBO(255, 180, 18, 1); //const Color(0xffFFB412);
  static const health_color_orange =
      Color.fromRGBO(253, 109, 0, 1); //const Color(0xffFD6D00);
  static const health_color_red =
      Color.fromRGBO(255, 73, 129, 1); //const Color(0xffFF4981);
  static const health_color_light_red =
      Color.fromRGBO(255, 172, 198, 1); //const Color(0xffFFACC6);
  static const white =
      Color.fromRGBO(255, 255, 255, 1); //const Color(0xFFFFFFFF);
  static const fontBlack =
      Color.fromRGBO(89, 89, 89, 1); // const Color(0xFF595959);
  static const blue =
      Color.fromRGBO(59, 123, 255, 1); //const Color(0xFF3B7BFF);
}

final defaultShadowDecoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 13,
    ),
  ],
);
final defaultDecoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 5.5,
    ),
  ],
);

final whiteBorderDecoration = BoxDecoration(
  border: Border.all(color: Colors.white, width: 3.w),
  borderRadius: BorderRadius.circular(35.w),
);
