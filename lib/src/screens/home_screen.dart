import 'package:flutter/material.dart';
import 'package:pokedex/src/providers/pokemon_provider.dart';
import 'package:pokedex/src/widgets/home_app_bar.dart';
import 'package:pokedex/src/widgets/home_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PokemonProvider _provider;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _provider = PokemonProvider();
    _provider.addListener(_onUpdate);
    _provider.loadPokemon();
  }

  @override
  void dispose() {
    _provider.removeListener(_onUpdate);
    _provider.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onUpdate() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        controller: _searchController,
        onChanged: _provider.search,
        onClear: () {
          _searchController.clear();
          _provider.search('');
        },
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/icon/pokemon.png'),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: HomeBody(
          provider: _provider,
          searchController: _searchController,
        ),
      ),
    );
  }
}
