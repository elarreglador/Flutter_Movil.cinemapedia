import "package:cinemapedia/domain/entities/movie.dart";

// definimos como quiero que sean mis repositorios de datos
abstract class MoviesRepository{

  //peliculas en cartelera
  Future<List<Movie>> getNowPlaying({ int page = 1 });

  Future<List<Movie>> getPopular({ int page = 1 });

  Future<List<Movie>> getTopRated({ int page = 1 });

  Future<List<Movie>> getUpcoming({ int page = 1 });
}