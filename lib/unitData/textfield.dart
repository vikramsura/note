import 'package:note/allPackageInp.dart';

Widget buildTextField(context,
    {controllerData,
    color,
    String? Function(String?)? validator,
    top,
    colorBorder,
    borderRadius,
    keyboardType,
    obscureText,
    hintText,
    suffixIcon,
    maxLines,
    textColor,
    hintColor,
    labelText,
    focusNode,
    prefixIcon,
    maxLength,
    prefix,
    readOnly,
    Function(String)? onChanged}) {
  return Padding(
    padding: EdgeInsets.only(top: top ?? 20.h),
    child: TextFormField(
      onChanged: onChanged,
      readOnly: readOnly ?? false,
      focusNode: focusNode,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      maxLines: maxLines ?? 1,
      // minLines: 1,
      // textCapitalization: keyboardType == TextInputType.number
      //     ? TextCapitalization.none
      //     : TextCapitalization.sentences,
      maxLength: maxLength ?? 200,
      textAlignVertical: suffixIcon != null || prefixIcon != null
          ? TextAlignVertical.center
          : null,
      validator: validator,
      style: TextStyle(color: textColor ?? AppTextColor.black),
      keyboardType: keyboardType ?? TextInputType.multiline,
      controller: controllerData,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
          isDense: false,
          filled: true,
          errorMaxLines: 2,
          contentPadding:
              EdgeInsets.only(left: 20.w, right: 10.w, top: 4.h, bottom: 4.h),
          counterText: "",
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          prefix: prefix,
          hintStyle: TextStyle(color: hintColor ?? AppTextColor.grey),
          hintText: hintText,
          labelText: labelText,
          fillColor: color ?? AppBodyColor.white,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: colorBorder ?? AppBodyColor.grey),
              borderRadius: BorderRadius.circular(borderRadius ?? 12.r)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorBorder ?? AppBodyColor.grey),
              borderRadius: BorderRadius.circular(borderRadius ?? 12.r)),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorBorder ?? AppBodyColor.grey),
              borderRadius: BorderRadius.circular(borderRadius ?? 12.r)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorBorder ?? AppBodyColor.grey),
              borderRadius: BorderRadius.circular(borderRadius ?? 12.r))),
    ),
  );
}
