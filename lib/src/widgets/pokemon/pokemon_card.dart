import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/src/constants/app_colors.dart';
import 'package:pokedex/src/services/pokemon_service.dart';
import '../../models/pokemon.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key, required this.pokemon, required this.onTap});

  final Pokemon pokemon;
  final VoidCallback onTap;

  String get _displayName =>
      pokemon.name[0].toUpperCase() + pokemon.name.substring(1);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 6,
        shadowColor: cs.primary.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [AppColors.cardGradientStart, AppColors.cardGradientEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
                  child: CachedNetworkImage(
                    imageUrl: PokemonService.instance.getSpriteUrl(pokemon.id),
                    fit: BoxFit.contain,
                    placeholder: (_, __) => const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primaryRed,
                        ),
                        strokeWidth: 2,
                      ),
                    ),
                    errorWidget: (_, __, ___) => const Icon(
                      Icons.catching_pokemon,
                      size: 48,
                      color: AppColors.textMedium,
                    ),
                  ),
                ),
              ),
              Text(
                '#${pokemon.id.toString().padLeft(3, '0')}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12, top: 2),
                child: Text(
                  _displayName,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
