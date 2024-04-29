import 'package:note/allPackageInp.dart';

Widget buildText({text, fontSize, color, fontWeight}) {
  return Text(
    text,
    style: TextStyle(
        fontSize: fontSize ?? 14.w,
        color: color ?? AppTextColor.black,
        fontWeight: fontWeight ?? FontWeight.w400,
        fontFamily: "Roboto"),
  );
}

Widget buildTextCen({text, fontSize, color, fontWeight}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
        fontSize: fontSize ?? 14.w,
        color: color ?? AppTextColor.black,
        fontWeight: fontWeight ?? FontWeight.w400,
        fontFamily: "Roboto"),
  );
}
