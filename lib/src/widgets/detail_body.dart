import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/pokemon_detail.dart';
import 'label.dart';
import 'stat_tile.dart';
import 'type_chip.dart';

class DetailBody extends StatelessWidget {
  const DetailBody({super.key, required this.detail});

  final PokemonDetail detail;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Banner con sprite
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
                    Center(
                      child: Text(
                        '#${detail.id.toString().padLeft(3, '0')}  '
                            '${detail.name[0].toUpperCase()}${detail.name.substring(1)}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const PokemonLabel(text: 'Tipos'),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: detail.types
                          .map((t) => TypeChip(type: t))
                          .toList(),
                    ),
                    const Divider(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StatTile(
                          icon: Icons.height,
                          label: 'Altura',
                          value: '${detail.heightInMeters} m',
                        ),
                        StatTile(
                          icon: Icons.monitor_weight_outlined,
                          label: 'Peso',
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