import 'package:flutter/material.dart';

class OtherUserMessage extends StatelessWidget {
  final String message;

  OtherUserMessage({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          margin: EdgeInsets.only(top: 10, bottom: 5, left: 12, right: 90),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey,
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
