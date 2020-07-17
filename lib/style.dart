import 'package:flutter/material.dart';

const LargeTextSize = 26.0;
const MediumTextSize = 20.0;
const BodyTextSize = 16.0;
const SmallTextSize = 12.0;
const VerySmallTextSize = 10.0;

const String FontNameDefault = 'Montserrat';
const String StyledFontName = 'Megrim';
const String SubsFontName = "Julius Sans One";

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

const Body1TextStyle = TextStyle(
  shadows: [
    Shadow(offset: Offset(1, 1), color: Colors.black),
  ],
  fontFamily: FontNameDefault,
  fontWeight: FontWeight.w300,
  fontSize: BodyTextSize,
  color: Colors.white,
);

const Body2TextStyle = TextStyle(
  fontFamily: FontNameDefault,
  fontWeight: FontWeight.w300,
  fontSize: BodyTextSize,
  color: Colors.white,
);

const BodyTextFancy = TextStyle(
  shadows: [
    Shadow(offset: Offset(1, 1), color: Colors.white),
  ],
  fontFamily: StyledFontName,
  fontWeight: FontWeight.w300,
  fontSize: BodyTextSize,
  color: Colors.white,
);

const Subtitle1TextStyle = TextStyle(
  shadows: [
    Shadow(offset: Offset(1, 1), color: Colors.black),
  ],
  fontFamily: SubsFontName,
  fontWeight: FontWeight.w300,
  fontSize: SmallTextSize,
  color: Colors.white,
);

const Subtitle2TextStyle = TextStyle(
  shadows: [
    Shadow(offset: Offset(1, 1), color: Colors.black),
  ],
  fontFamily: FontNameDefault,
  fontWeight: FontWeight.w300,
  fontSize: VerySmallTextSize,
  color: Colors.white,
);

const TitleTextStyleJulius = TextStyle(
  shadows: [
    Shadow(offset: Offset(1, 1), color: Colors.black),
  ],
  fontFamily: FontNameDefault,
  fontWeight: FontWeight.w600,
  fontSize: LargeTextSize,
  color: Colors.white,
);

const TitleTextStyleJuliusR = TextStyle(
  shadows: [
    Shadow(offset: Offset(1, 1), color: Colors.black),
  ],
  fontFamily: FontNameDefault,
  fontWeight: FontWeight.w600,
  fontSize: MediumTextSize,
  color: Colors.white,
);
