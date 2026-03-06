import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/pokemon_detail.dart';
import '../providers/pokemon_provider.dart';

/// Shows full details for a single Pokémon.
/// Uses [FutureBuilder] for a clean loading → error → data flow.
class PokemonDetailScreen extends StatefulWidget {
  const PokemonDetailScreen({super.key, required this.pokemonName});

  final String pokemonName;

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  late final Future<PokemonDetail> _detailFuture;
  final _provider = PokemonProvider();

  @override
  void initState() {
    super.initState();
    _detailFuture = _provider.fetchDetail(widget.pokemonName);
  }

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  String get _titleName =>
      widget.pokemonName[0].toUpperCase() + widget.pokemonName.substring(1);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        context.go('/');
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _titleName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<PokemonDetail>(
          future: _detailFuture,
          builder: (context, snapshot) {
            // ── Loading ──────────────────────────────────────────────────────
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // ── Error ────────────────────────────────────────────────────────
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 56,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Could not load details',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        snapshot.error.toString(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              );
            }

            // ── Data ─────────────────────────────────────────────────────────
            return _DetailBody(detail: snapshot.data!);
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private sub-widgets
// ─────────────────────────────────────────────────────────────────────────────

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.detail});

  final PokemonDetail detail;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Banner with sprite
          Container(
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
              imageUrl: detail.spriteUrl,
              height: 200,
              fit: BoxFit.contain,
              placeholder: (_, __) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (_, __, ___) =>
                  const Icon(Icons.catching_pokemon, size: 80),
            ),
          ),

          // Info card
          Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Number + Name
                    Center(
                      child: Text(
                        '#${detail.id.toString().padLeft(3, '0')}  '
                        '${detail.name[0].toUpperCase()}${detail.name.substring(1)}',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Types
                    _Label(text: 'Types'),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: detail.types
                          .map((t) => _TypeChip(type: t))
                          .toList(),
                    ),
                    const Divider(height: 32),

                    // Height & Weight
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _StatTile(
                          icon: Icons.height,
                          label: 'Height',
                          value: '${detail.heightInMeters} m',
                        ),
                        _StatTile(
                          icon: Icons.monitor_weight_outlined,
                          label: 'Weight',
                          value: '${detail.weightInKg} kg',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: Theme.of(
      context,
    ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
  );
}

class _TypeChip extends StatelessWidget {
  const _TypeChip({required this.type});
  final String type;

  static const _colors = <String, Color>{
    'fire': Color(0xFFFF7043),
    'water': Color(0xFF42A5F5),
    'grass': Color(0xFF66BB6A),
    'electric': Color(0xFFFFEE58),
    'psychic': Color(0xFFEC407A),
    'ice': Color(0xFF80DEEA),
    'dragon': Color(0xFF7E57C2),
    'dark': Color(0xFF5D4037),
    'fairy': Color(0xFFF48FB1),
    'normal': Color(0xFFBDBDBD),
    'fighting': Color(0xFFEF5350),
    'flying': Color(0xFF90CAF9),
    'poison': Color(0xFFAB47BC),
    'ground': Color(0xFFD7CCC8),
    'rock': Color(0xFFBCAAA4),
    'bug': Color(0xFFA5D6A7),
    'ghost': Color(0xFF7986CB),
    'steel': Color(0xFFB0BEC5),
  };

  @override
  Widget build(BuildContext context) {
    final color = _colors[type] ?? const Color(0xFFBDBDBD);
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

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(label, style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }
}
