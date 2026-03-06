import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/src/api/api_constants/pokemon_list_state.dart';
import 'package:pokedex/src/providers/pokemon_provider.dart';
import 'package:pokedex/src/widgets/pokemon_list.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.provider,
    required this.searchController,
  });

  final PokemonProvider provider;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    switch (provider.state) {
      case PokemonListState.idle:
      case PokemonListState.loading:
        return const Center(child: CircularProgressIndicator());

      case PokemonListState.error:
        return _ErrorView(
          message: provider.errorMessage,
          onRetry: provider.loadPokemon,
        );

      case PokemonListState.success:
        return PokemonList(
          pokemonList: provider.pokemon,
          onPokemonTap: (p) => context.go('/pokemon/${p.name}'),
        );
    }
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 56, color: Colors.red),
            const SizedBox(height: 12),
            Text('Something went wrong',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}