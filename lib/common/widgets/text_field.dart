import 'package:cj_flutter_riverpod_instagram_clone/common/constants/border_radius.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/constants/spacing.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/enums/color.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/enums/font_size.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InstaTextField extends StatefulWidget {
  TextEditingController? controller;
  final String label;
  final bool obscureText;
  final int maxLines;
  final String initialValue;

  final Widget? prefixIcon;
  final Function(String)? onChanged;
  InstaTextField({
    this.controller,
    super.key,
    required this.label,
    this.obscureText = false,
    this.maxLines = 1,
    this.initialValue = '',
    this.prefixIcon,
    this.onChanged,
  });

  @override
  State<InstaTextField> createState() => _InstaTextFieldState();
}

class _InstaTextFieldState extends State<InstaTextField> {
  @override
  void initState() {
    super.initState();
    widget.controller?.text = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      maxLines: widget.maxLines,
      onChanged: _onChanged,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: TextStyle(color: applyColor[InstaColor.disabled]),
        contentPadding: const EdgeInsets.symmetric(
          vertical: InstaSpacing.verySmall,
          horizontal: InstaSpacing.verySmall,
        ),
        prefixIcon: widget.prefixIcon,
        labelText: widget.label,
        alignLabelWithHint: true,
        labelStyle: TextStyle(fontSize: InstaFontSize.medium.value),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(InstaBorderRadius.small),
          ),
          borderSide: BorderSide(
            color: applyColor[InstaColor.tertiary]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(InstaBorderRadius.small),
          ),
          borderSide: BorderSide(color: applyColor[InstaColor.disabled]!),
        ),
      ),
    );
  }

  void _onChanged(String value) {
    widget.onChanged?.call(value);
  }
}
