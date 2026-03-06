
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pokedex/src/api/api_client.dart';
import 'package:pokedex/src/api/interceptors.dart';


class ApiProvider {
  ApiProvider._();

  static final ApiProvider instance = ApiProvider._();

  String get baseUrl => dotenv.env['API_BASE_URL']!;

  final ApiClient client = ApiClient(
    interceptors: [LoggingInterceptor()],
  );
}
