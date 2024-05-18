

import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Este repositorio es de solo lectura y su objetivo es proporcionar 
// a todos los demas providers la info de este repositorio
final movieRepositoryProvider = Provider((ref){
  return MovieRepositoryImpl(datasource: MoviedbDatasource());
});