class ApiConstants {
  static const spriteBaseUrl =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork';

       static String getSpriteUrl(int pokemonId) {
    return '$spriteBaseUrl/$pokemonId.png';
  }
}