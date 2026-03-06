import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/pokemon_detail.dart';
import '../providers/pokemon_provider.dart';
import '../widgets/detail_body.dart';
import '../widgets/error_view.dart';
import '../widgets/back_button.dart';

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
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        context.go('/');
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const CustomBackButton(),
          title: Text(
            _titleName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<PokemonDetail>(
          future: _detailFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return ErrorView(
                message: snapshot.error.toString(),
                onRetry: () => setState(() {
                  _provider.fetchDetail(widget.pokemonName);
                }),
              );
            }
            return DetailBody(detail: snapshot.data!);
          },
        ),
      ),
    );
  }
}
