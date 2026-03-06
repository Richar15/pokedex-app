
class Pokemon {
  const Pokemon({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }

  int get id {
    final segments = url.split('/');
    return int.parse(segments[segments.length - 2]);
  }

}
