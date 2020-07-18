import 'package:flutter/material.dart';
import 'package:Twixer/style.dart' as style;

class TextSection extends StatelessWidget {
  final String _title;
  final String _body;
  static const double _pad = 16.0;

  TextSection(this._title, this._body);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(_pad),
            child: Text(
              _title,
              style: style.TitleTextGame,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(_pad),
            child: Text(
              _body,
              style: style.Body2TextStyle,
            ),
          ),
        ]);
  }
}
