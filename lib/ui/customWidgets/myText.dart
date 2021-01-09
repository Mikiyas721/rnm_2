import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String label;
  final String value;
  final EdgeInsetsGeometry padding;
  final Color textColor;

  MyText({
    @required this.label,
    @required this.value,
    this.padding = const EdgeInsets.only(bottom: 5),
    this.textColor = Colors.black
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:padding,
      child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: '$label: ',
                  style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              TextSpan(
                  text: value,
                  style: TextStyle(color: textColor, fontSize: 17))
            ],
          )),
    );
  }
}
