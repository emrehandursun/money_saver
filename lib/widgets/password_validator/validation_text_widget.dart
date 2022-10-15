import 'package:flutter/material.dart';

/// ValidationTextWidget that represent style of each one of them and shows as list of condition that you want to the app user
class ValidationTextWidget extends StatelessWidget {
  final Color color;
  final String text;
  final int? value;

  const ValidationTextWidget({super.key, required this.color, required this.text, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
          height: MediaQuery.of(context).size.width * 0.03,
          child: CircleAvatar(
            backgroundColor: color,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
          child: Text(
            text.replaceFirst("-", value.toString()),
            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03, color: color),
          ),
        )
      ],
    );
  }
}
