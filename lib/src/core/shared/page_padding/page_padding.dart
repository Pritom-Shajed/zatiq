import 'package:flutter/material.dart';

class PagePadding extends StatelessWidget {
  final Widget child;
  const PagePadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: child,
    ));
  }
}
