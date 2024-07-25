// Devuelve true o false a partir de si se ha cargado
// la pagina que muestra los listados de peliculas

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';

final initialLoadingProvider = Provider<bool>((ref){

  // estan vacios los listados de peliculas?
  final step1 = ref.watch(moviesSlideshowProvider).isEmpty;
  final step2 = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final step3 = ref.watch(popularMoviesProvider).isEmpty;
  final step4 = ref.watch(topRatedMoviesProvider).isEmpty;
  final step5 = ref.watch(upcomingMoviesProvider).isEmpty;

  if ( step1 || step2 || step3 || step4 || step5 ) return true; // falta algo por cargar
  return false; // ha terminado de cargar
});