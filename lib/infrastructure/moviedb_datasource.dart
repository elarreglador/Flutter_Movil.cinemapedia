// este datasource se crea con la intencion de trabajar exclusivamente con 
// mobiedb, si necesitamos obtener de otras fuentes crearemos un datasource
// diferente y especializado.

import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:dio/dio.dart';
import 'package:cinemapedia/domain/entities/movie.dart';



class MoviedbDatasource extends MoviesDatasource {

  final dio = Dio(BaseOptions(
    baseUrl:  "https://api.themoviedb.org/3",
    
  ));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    


    return [];
  }



}