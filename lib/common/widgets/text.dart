import 'package:cj_flutter_riverpod_instagram_clone/common/constants/font_size.dart';
import 'package:flutter/material.dart';

class InstaText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final int? maxLines;
  final TextAlign? textAlign;
  const InstaText({
    super.key,
    required this.text,
    this.fontSize = InstaFontSize.medium,
    this.fontWeight = FontWeight.normal,
    this.color,
    this.maxLines,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
