import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {

  final String? text;
  final VoidCallback ? onpressed;

  CustomButton({this.text, this.onpressed});
  @override
  Widget build(BuildContext context) {
    return  TextButton(
      onPressed: onpressed,
      style: TextButton.styleFrom(
        backgroundColor: primaryColor,
        padding: EdgeInsets.all(15),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
      child: CustomText(
        text: text!,
        alignment: Alignment.center,
        color: Colors.white,
      ),
    );
  }

}
