import 'package:flutter/foundation.dart';
import 'dart:collection' show UnmodifiableListView;
import 'package:pokedex/src/api/api_constants/pokemon_list_state.dart';
import '../models/pokemon.dart';
import '../models/pokemon_detail.dart';
import '../services/pokemon_service.dart';

class PokemonProvider extends ChangeNotifier {
  final _service = PokemonService.instance;

  PokemonListState _state = PokemonListState.idle;
  List<Pokemon> _allPokemon = [];
  List<Pokemon> _filtered = [];
  String _errorMessage = '';
  String _query = '';

  PokemonListState get state => _state;

  List<Pokemon> get pokemon => UnmodifiableListView(_filtered);
  String get errorMessage => _errorMessage;
  String get query => _query;

  Future<void> loadPokemon() async {
    _setState(PokemonListState.loading);
    _errorMessage = '';

    try {
      _allPokemon = await _service.fetchPokemonList();
      _allPokemon.sort((a, b) => a.name.compareTo(b.name));
      _applyFilter();
      _setState(PokemonListState.success);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(PokemonListState.error);
    }
  }

  void search(String query) {
    if (_query == query) return;
    _query = query;
    _applyFilter();
    notifyListeners();
  }

  void _applyFilter() {
    if (_query.isEmpty) {
      _filtered = _allPokemon;
      return;
    }

    final normalizedQuery = _query.toLowerCase();
    _filtered =
        _allPokemon
            .where((p) => p.name.toLowerCase().contains(normalizedQuery))
            .toList()
          ..sort((a, b) => a.name.compareTo(b.name));
  }

  Future<PokemonDetail> fetchDetail(String name) async {
    try {
      return await _service.fetchPokemonDetail(name);
    } catch (e) {
      throw Exception('Error al cargar detalle de $name: $e');
    }
  }

  void _setState(PokemonListState newState) {
    _state = newState;
    notifyListeners();
  }
}
