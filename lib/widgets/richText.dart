import 'package:flutter/material.dart';

class MyRichText extends StatelessWidget {
  final String text;

  MyRichText({required this.text});

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = [];
    var words = text.split(' ');

    for (var word in words) {
      if (word.startsWith('*') && word.endsWith('*')) {
        textSpans.add(TextSpan(
          text: word.substring(1, word.length - 1),
          style: TextStyle(fontWeight: FontWeight.bold),
        ));
      } else if (word.startsWith('_') && word.endsWith('_')) {
        textSpans.add(TextSpan(
          text: word.substring(1, word.length - 1),
          style: TextStyle(fontStyle: FontStyle.italic),
        ));
      } else {
        textSpans.add(TextSpan(
          text: word + ' ',
        ));
      }
    }

    return RichText(
      text: TextSpan(
        children: textSpans,
      ),
    );
  }
}
