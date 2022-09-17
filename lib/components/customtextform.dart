import 'package:flutter/material.dart';

class CustomTextFormSign extends StatelessWidget {
  final String hint;
  final double height;
  final String? Function(String?) valid;
  final TextEditingController mycontroller;
  final IconButton icon;
  final IconButton icon2;
  final TextInputType? keyboardType;
  const CustomTextFormSign(
      {Key? key,
      this.keyboardType,
      required this.hint,
      required this.height,
      required this.mycontroller,
      required this.valid,
      required this.icon,
      required this.icon2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        //keyboardType: TextInputType.multiline,
        keyboardType: keyboardType,
        validator: valid,
        controller: mycontroller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            prefixIcon: icon,
            suffixIcon: icon2,
            hintText: hint,
            hintMaxLines: 20,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
    );
  }
}
