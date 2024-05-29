import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final String? title;
  final Widget child;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final bool? resizeToAvoidBottomInset;
  final Widget? leading;
  final List<Widget> actions;
  const DefaultLayout({
    super.key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.title,
    this.onPressed,
    this.resizeToAvoidBottomInset,
    this.leading,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        appBar: _appbar(),
        backgroundColor: backgroundColor,
        body: child,
      ),
    );
  }

  PreferredSizeWidget? _appbar() {
    if (title != null) {
      return AppBar(
        title: Text(
          title!,
        ),
        scrolledUnderElevation: 0,
        actions: actions,
        leading: leading,
      );
    }
    return null;
  }
}
