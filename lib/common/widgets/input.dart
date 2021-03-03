import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
/**
 * 自定义Input组件,用于填写表单信息
 * @author yinlei
*/
Widget TextFormWidget({
  @required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
  double marginTop = 22,
  bool autofocus = false,
  bool obscureText = false,
  String labelText,
  String hintText,
  bool isPassword = false,
  Widget suffixIcon,
  ValueChanged<String> onChanged,
  int maxLines = 1,
}) {
  return Container(
    margin: EdgeInsets.only(top: marginTop.h),
    child: TextFormField(
      autofocus: autofocus,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 9),
        border: OutlineInputBorder(),
        suffixIcon: isPassword?suffixIcon:null,
      ),
      maxLines: 1,
      onChanged: onChanged ?? null,
      autocorrect: false,
      obscureText: obscureText,
      validator: (v) {
        return v.trim().isNotEmpty ? null : "请填写$labelText";
      },
    ),
  );
}