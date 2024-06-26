import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrl {
  const ApiUrl._();

  static final baseUrl = dotenv.env['baseURL']!;
}
