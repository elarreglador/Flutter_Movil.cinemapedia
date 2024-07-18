// este datasource se crea con la intencion de trabajar exclusivamente con
// mobiedb, si necesitamos obtener de otras fuentes crearemos un datasource
// diferente y especializado.

import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: "https://api.themoviedb.org/3",
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-ES'
      }));

  // Devuelve una lista de peliculas a partir de un json (usado mas abajo)
  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) =>
            moviedb.posterPath !=
            'no-poster') //FILTRO: Descarta peliculas sin poster
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  // Obtiene el listado de peliculas en cines
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get("/movie/now_playing", queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  //Obtiene el listado de peliculas populares
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get("/movie/popular", queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  //Obtiene el listado de peliculas mejor puntuadas
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response =
        await dio.get("/movie/top_rated", queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  //Obtiene el listado de peliculas pendientes de estreno
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response =
        await dio.get("/movie/upcoming", queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }
}
