import 'package:flutter/material.dart';

const LargeTextSize = 26.0;
const MediumTextSize = 20.0;
const BodyTextSize = 16.0;

const String FontNameDefault = 'Montserrat';
const String StyledFontName = 'Megrim';

const AppBarTextStyle = TextStyle(
  shadows: [
    Shadow(offset: Offset(1.5, 1.5), color: Colors.black),
  ],
  fontFamily: StyledFontName,
  fontWeight: FontWeight.w300,
  fontSize: LargeTextSize,
  color: Colors.white,
);

const TitleTextStyle = TextStyle(
  shadows: [
    Shadow(offset: Offset(2, 2), color: Colors.black),
  ],
  fontFamily: FontNameDefault,
  fontWeight: FontWeight.w300,
  fontSize: MediumTextSize,
  color: Colors.white,
);

const Body2TextStyle = TextStyle(
  shadows: [
    Shadow(offset: Offset(1, 1), color: Colors.black),
  ],
  fontFamily: StyledFontName,
  fontWeight: FontWeight.w300,
  fontSize: BodyTextSize,
  color: Colors.white,
);
