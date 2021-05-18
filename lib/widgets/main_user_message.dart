import 'package:flutter/material.dart';

class MainUserMessage extends StatelessWidget {
  final String message;

  MainUserMessage({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          margin: EdgeInsets.only(top: 10, bottom: 5, left: 90, right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.green,
          ),
          child: Text(
            message,
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
