import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  // OBTIENE LA VARIABLE DE ENTORNO DESDE /.ENV GRACIAS AL PAQUETE DOTENV
  static String theMovieDbKey = dotenv.env["THE_MOVIEDB_KEY"] ?? "THE_MOVIEDB_KEY not found.";
}