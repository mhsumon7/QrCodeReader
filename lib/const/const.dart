import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final TextDecoration textDecoration;
  final int? maxLines;
  final TextStyle? style;
  const AppText({
    Key? key,
    required this.text,
    this.style,
    this.fontSize = 18,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.textAlign,
    this.textDecoration = TextDecoration.none,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!.toString(),
      textAlign: textAlign,
      maxLines: maxLines,
      style: GoogleFonts.robotoMono(textStyle: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),),

    );
  }
}
