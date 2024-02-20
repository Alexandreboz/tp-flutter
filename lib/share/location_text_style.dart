import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:td/share/location_style.dart';

class LocationTextStyle {
  static final baseTextStyle = GoogleFonts.getFont('Raleway').copyWith(color: LocationStyle.colorPurple);

  static final regularTestStyle = baseTextStyle.copyWith(fontSize: 13);

  static final regularWhiteTextStyle = baseTextStyle.copyWith(color: Colors.white70, fontSize: 13);

  static final boldTextStyle = baseTextStyle.copyWith(fontWeight: FontWeight.bold);
}