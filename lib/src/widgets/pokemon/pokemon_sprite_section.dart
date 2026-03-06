import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PokemonSpriteSection extends StatelessWidget {
  const PokemonSpriteSection({super.key, required this.spriteUrl});

  final String spriteUrl;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.primaryContainer, cs.secondaryContainer],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: CachedNetworkImage(
        imageUrl: spriteUrl,
        height: 200,
        fit: BoxFit.contain,
        placeholder: (_, __) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (_, __, ___) =>
            const Icon(Icons.catching_pokemon, size: 80),
      ),
    );
  }
}
