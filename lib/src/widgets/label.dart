import 'package:flutter/material.dart';

class PokemonLabel extends StatelessWidget {
  const PokemonLabel({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: Theme.of(context)
        .textTheme
        .titleSmall
        ?.copyWith(fontWeight: FontWeight.bold),
  );
}