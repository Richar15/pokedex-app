import 'package:flutter/material.dart';
import 'package:pokedex/src/constants/pokemon_type_colors.dart';


class TypeChip extends StatelessWidget {
  const TypeChip({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    final color = pokemonTypeColors[type] ?? kDefaultTypeColor;
    return Chip(
      label: Text(
        type[0].toUpperCase() + type.substring(1),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
      backgroundColor: color,
      side: BorderSide.none,
    );
  }
}