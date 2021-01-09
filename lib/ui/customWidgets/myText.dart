import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String label;
  final String value;
  final EdgeInsetsGeometry padding;

  MyText({
    @required this.label,
    @required this.value,
    this.padding = const EdgeInsets.only(bottom: 5)
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
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              TextSpan(
                  text: value,
                  style: TextStyle(color: Colors.black, fontSize: 17))
            ],
          )),
    );
  }
}
