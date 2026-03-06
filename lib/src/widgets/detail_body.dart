import 'package:flutter/material.dart';
import '../models/pokemon_detail.dart';
import 'pokemon/pokemon_sprite_section.dart';
import 'pokemon/pokemon_info_card.dart';

class DetailBody extends StatelessWidget {
  const DetailBody({super.key, required this.detail});

  final PokemonDetail detail;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PokemonSpriteSection(spriteUrl: detail.spriteUrl),
          PokemonInfoCard(detail: detail),
        ],
      ),
    );
  }
}
