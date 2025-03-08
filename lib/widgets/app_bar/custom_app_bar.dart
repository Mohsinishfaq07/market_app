import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? color;
  final double? elevation;
  final bool? centerTitle;
  final TextStyle? titleTextStyle;
  final List<Widget>? actions;
  final Widget? backButton;
  final bool? showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.color,
    this.elevation,
    this.centerTitle,
    this.titleTextStyle,
    this.actions,
    this.backButton,
    this.showBackButton,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle titleTextStyleValue = TextStyle(color: Colors.black);
    Color backGroundColor = color ?? Colors.white;
    bool showBackButtonValue = showBackButton ?? true;
    return AppBar(
      scrolledUnderElevation: 0.0,
      automaticallyImplyLeading: showBackButtonValue,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      leading: backButton,
      backgroundColor: backGroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
      title: Text(
        title,
        style: titleTextStyleValue,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
