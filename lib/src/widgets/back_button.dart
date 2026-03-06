import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.onPressed,
    this.icon = Icons.arrow_back,
    this.route = '/',
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed ?? () => context.go(route),
      tooltip: 'Retroceder',
    );
  }
}
