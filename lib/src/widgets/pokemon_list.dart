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
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, size: 56),
            SizedBox(height: 12),
            Text('No Pokémon found.'),
          ],
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
