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

  bool get _isNoInternetError =>
      message.toLowerCase().contains('internet') ||
      message.toLowerCase().contains('socket') ||
      message.toLowerCase().contains('connection');

  String get _errorTitle =>
      _isNoInternetError ? 'Sin conexión' : 'Algo salió mal';

  String get _errorDescription => _isNoInternetError
      ? 'Parece que no tienes conexión a internet.\nVerifica tu conexión e intenta de nuevo.'
      : 'Hubo un problema al cargar los datos.\nPor favor, intenta de nuevo.';

  @override
  Widget build(BuildContext context) {
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
                color: _isNoInternetError
                    ? cs.errorContainer
                    : Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _isNoInternetError ? Icons.wifi_off : Icons.error_outline,
                size: 40,
                color: _isNoInternetError ? cs.error : Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _errorTitle,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              _errorDescription,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 28),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
