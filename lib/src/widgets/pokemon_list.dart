import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import 'pokemon_card.dart';

class PokemonList extends StatelessWidget {
  const PokemonList({
    super.key,
    required this.pokemonList,
    required this.onPokemonTap,
  });

  final List<Pokemon> pokemonList;
  final void Function(Pokemon) onPokemonTap;

  @override
  Widget build(BuildContext context) {
    if (pokemonList.isEmpty) {
      final cs = Theme.of(context).colorScheme;

      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: cs.secondaryContainer.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.search_off,
                  size: 40,
                  color: cs.onSecondaryContainer,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Pokémon no encontrado',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'No hay resultados para tu búsqueda.\nIntenta con otro nombre o término.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: pokemonList.length,
      itemBuilder: (context, index) {
        final pokemon = pokemonList[index];
        return PokemonCard(
          pokemon: pokemon,
          onTap: () => onPokemonTap(pokemon),
        );
      },
    );
  }
}
