
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pokedex/src/providers/api_provider.dart';

import '../models/pokemon.dart';
import '../models/pokemon_detail.dart';


class PokemonService {
  PokemonService._();

  static final PokemonService instance = PokemonService._();

  final _apiProvider = ApiProvider.instance;

  String get _baseUrl => _apiProvider.baseUrl;

  String get _pokemonEndpoint => dotenv.env['POKEMON_ENDPOINT']!;

  int get _limit => int.parse(dotenv.env['POKEMON_LIMIT']!);


  Future<List<Pokemon>> fetchPokemonList() async {
    final url = '$_baseUrl/$_pokemonEndpoint?limit=$_limit';
    try {
      final data = await _apiProvider.client.get(url);
      final results = data['results'] as List;
      return results
          .map((item) => Pokemon.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Error al cargar la lista de Pokémon: $e');
    }
  }

  Future<PokemonDetail> fetchPokemonDetail(String name) async {
    final url = '$_baseUrl/$_pokemonEndpoint/$name';
    try {
      final data = await _apiProvider.client.get(url);
      return PokemonDetail.fromJson(data);
    } catch (e) {
      throw Exception('Error al cargar detalle de $name: $e');
    }
  }
}
