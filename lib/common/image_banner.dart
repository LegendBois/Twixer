import 'package:flutter/material.dart';

class ImageBanner extends StatelessWidget {
  final String _imagePath;

  ImageBanner(this._imagePath);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: 200.0,
      ),
      decoration: BoxDecoration(color: Colors.black),
      child: Image.network(
        _imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
