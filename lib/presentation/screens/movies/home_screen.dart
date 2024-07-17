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
  }

  @override
  Widget build(BuildContext context) {
    // obtiene un future List con las peliculas
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    // obtendremos una lista algo mas corta para que el carrusel no sea muy extenso
    final slideShowMovies = ref.watch(moviesSlideshowProvider);

    // muestra circulo de carga mientras descarga peliculas
    if (slideShowMovies.isEmpty) {
      return const Center(
        child: CircularProgressIndicator()
      );
    }

    // Se requiere el CustomScrollView para usar un *SliverAppBar* que aparezca/desaparezca
    // mostrando nuestro CustomAppbar() al deslizar arriba y abajo el scroll
    return CustomScrollView(
      slivers: [

        // AppBar que se oculta y muestra con el scroll vertical
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),

        // Lista de objetos que se desplazan verticalmente
        SliverList(delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              children: [
                
            
                MoviesSlideshow(movies: slideShowMovies),
            
                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: "En cines",
                  subTitle: "jueves 13",
                  loadNextPage: () {
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                  }
                ),
            
                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: "Populares",
                  loadNextPage: () {
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                  }
                ),
            
                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: "Mejor clasificadas",
                  loadNextPage: () {
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                  }
                )
              
                
              ],
            );

          },
          childCount: 1
          )
        )
      ]      
    );
  }
}
