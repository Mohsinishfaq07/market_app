import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyTextField extends ConsumerWidget {
  final String? hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final double? width;
  final double? height;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? borderRadius;
  final Color? containerColor;
  final bool obscureText;

  final Function(String)? onChanged;
  final int maxLines;

  const MyTextField({
    super.key,
    this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.width,
    this.height,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius,
    this.containerColor,
    this.maxLines = 1,
    required this.onChanged,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FocusNode focusNode = FocusNode();
    final borderRadiusValue = borderRadius ?? 10;
    final containerColorValue = containerColor ?? Colors.grey.withOpacity(0.2);
    return Consumer(
      builder: (context, ref, child) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: containerColorValue,
            borderRadius: BorderRadius.circular(borderRadiusValue),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: TextField(
            focusNode: focusNode,
            onTapOutside: (val) {
              FocusScope.of(context).unfocus();
            },
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
            ),
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            maxLines: maxLines,
            obscureText: obscureText,
          ),
        );
      },
    );
  }
}
