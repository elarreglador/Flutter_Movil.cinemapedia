import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

// tomamos la implementacion especifica de TheMovieDB y convertirlo a Movie, de este modo, si mas adelante
// TheMovieDB cambia el formato en la descripcion de las peliculas solo debemos editar este codigo.

// por otro lado usaremos un mapper por cada fuente de codigo.

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
    adult: moviedb.adult,
    backdropPath: (moviedb.backdropPath != '') 
      ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
      : 'https://ih1.redbubble.net/image.1893341687.8294/fposter,small,wall_texture,product,750x1000.jpg',
    genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
    id: moviedb.id,
    originalLanguage: moviedb.originalLanguage,
    originalTitle: moviedb.originalTitle,
    overview: moviedb.overview,
    popularity: moviedb.popularity,
    posterPath: (moviedb.posterPath != '')
    ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
    : 'no-poster',
    releaseDate: moviedb.releaseDate,
    title: moviedb.title,
    video: moviedb.video,
    voteAverage: moviedb.voteAverage,
    voteCount: moviedb.voteCount
  );
}
