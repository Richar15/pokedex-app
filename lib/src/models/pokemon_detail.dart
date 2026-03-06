class PokemonDetail {
  const PokemonDetail({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
    required this.spriteUrl,
  });

  final int id;
  final String name;


  final int height;


  final int weight;

  final List<String> types;
  final String spriteUrl;

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    final types = (json['types'] as List<dynamic>)
        .map((t) => t['type']['name'] as String)
        .toList();

    final sprites = json['sprites'] as Map<String, dynamic>? ?? {};
    final other = sprites['other'] as Map<String, dynamic>? ?? {};
    final artwork = other['official-artwork'] as Map<String, dynamic>? ?? {};

    final spriteUrl =
        artwork['front_default'] as String? ??
            sprites['front_default'] as String? ??
            '';

    return PokemonDetail(
      id: json['id'] as int,
      name: json['name'] as String,
      height: json['height'] as int,
      weight: json['weight'] as int,
      types: types,
      spriteUrl: spriteUrl,
    );
  }


  double get heightInMeters => height / 10;


  double get weightInKg => weight / 10;
}
