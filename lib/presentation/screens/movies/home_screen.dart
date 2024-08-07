import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    // valor booleano verificando si hay peliculas en los listados
    final initialLoading = ref.watch(initialLoadingProvider);

    // obtiene un future List con las peliculas
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    // muestra pantalla de carga hasta que se carguen los listados de peliculas
    if (initialLoading) return const FullScreenLoader();

    // CUERPO DE LA APP
    // Se requiere el CustomScrollView para usar un *SliverAppBar* que aparezca/desaparezca
    // mostrando nuestro CustomAppbar() al deslizar arriba y abajo el scroll
    return CustomScrollView(slivers: [
      // AppBar que se oculta y muestra con el scroll vertical
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppbar(),
        ),
      ),

      // Lista de objetos que se desplazan verticalmente
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            MoviesSlideshow(movies: slideShowMovies),
            MovieHorizontalListview(
                movies: topRatedMovies,
                title: "Mejor clasificadas",
                loadNextPage: () {
                  ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                }),

            MovieHorizontalListview(
                movies: nowPlayingMovies,
                title: "En cines",
                subTitle: "jueves 13",
                loadNextPage: () {
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                }),

            MovieHorizontalListview(
                movies: popularMovies,
                title: "Populares",
                loadNextPage: () {
                  ref.read(popularMoviesProvider.notifier).loadNextPage();
                }),

            MovieHorizontalListview(
                movies: upcomingMovies,
                title: "Proximamente",
                loadNextPage: () {
                  ref.read(upcomingMoviesProvider.notifier).loadNextPage();
                })
                
          ],
        );
      }, childCount: 1))
    ]);
  }
}
