import 'package:note/allPackageInp.dart';

Widget buildConButton(
    {height,
    width,
    color,
    borderRadius,
    text,
    colorText,
    bool loading = false,
    fontWeight,
    borderColor,
    fontSize}) {
  return Container(
    height: height ?? 50.h,
    width: width ?? 1.sw,
    decoration: BoxDecoration(
        color: color ?? AppBodyColor.blue,
        borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
        border: Border.all(color: borderColor ?? Colors.transparent)),
    child: Center(
        child: loading
            ? CircularProgressIndicator(
                color: AppBodyColor.white,
              )
            : Text(
                text,
                style: TextStyle(
                    color: colorText ?? AppTextColor.white,
                    fontWeight: fontWeight ?? FontWeight.w500,
                    fontSize: fontSize ?? 18.w),
              )),
  );
}
