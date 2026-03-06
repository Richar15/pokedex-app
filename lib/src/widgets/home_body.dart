import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/src/api/api_constants/pokemon_list_state.dart';
import 'package:pokedex/src/providers/pokemon_provider.dart';
import 'package:pokedex/src/widgets/pokemon/pokemon_list.dart';
import 'package:pokedex/src/widgets/error_view.dart';
import 'package:pokedex/src/widgets/loading_view.dart';

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
        return const LoadingView();

      case PokemonListState.error:
        return ErrorView(
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
