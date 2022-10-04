import 'package:flutter/material.dart';

class LoginLayout extends StatelessWidget {
  const LoginLayout({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: child,
    );
  }
}
