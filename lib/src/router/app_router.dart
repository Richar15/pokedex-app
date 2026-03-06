import 'package:go_router/go_router.dart';
import 'package:pokedex/src/widgets/navigation_service.dart';
import '../screens/home_screen.dart';
import '../screens/pokemon_detail_screen.dart';

class AppRouter {
  AppRouter._();

  static const String home = '/';
  static const String detail = '/pokemon/:name';

  static final router = GoRouter(
    navigatorKey: NavigationService.navigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(path: home, builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: detail,
        builder: (context, state) {
          final name = state.pathParameters['name']!;
          return PokemonDetailScreen(pokemonName: name);
        },
      ),
    ],
  );
}
