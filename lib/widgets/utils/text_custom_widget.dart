import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../constant/colors.dart';

class TextCustomWidget extends StatelessWidget {
  TextCustomWidget(
      {required this.color,
       this.fontSize,
       this.fontWeight,
      required this.text, this.textAlign});
  String text;
  Color color;
  double? fontSize;
  FontWeight? fontWeight;
  TextAlign? textAlign  ;
  @override


  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign?? TextAlign.center ,
      style: GoogleFonts.aBeeZee(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
    
  }
}
