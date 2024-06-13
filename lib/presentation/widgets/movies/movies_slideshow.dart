import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesSlideshow extends StatelessWidget {
  final List<Movie> movies;

  const MoviesSlideshow({
    super.key, 
    required this.movies
  });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme; 

    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        viewportFraction: 0.8, // zoom al 80% permite ver imagen previa y posterior
        scale: 0.9, // al 90% separa cada imagen de la anterior/posterior
        autoplay: true,
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 10),
          builder: DotSwiperPaginationBuilder(
            activeColor: Colors.red,
            color: colors.primary 
          )
        ),
        itemCount: movies.length,
        itemBuilder: (context, index){
          return _Slide(movie: movies[index]);
        }
      ),
    );
  }
}

class _Slide extends StatelessWidget {

  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {

    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black,
          blurRadius: 10,
          offset: Offset(0,5)
        )
      ]
    );

    return Padding(
      padding: const EdgeInsets.only( bottom: 30 ),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Image.network( //IMAGEN DEL CARRUSEL
                movie.backdropPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress){ // Durante la carga de imagenes...
                  if (loadingProgress != null ){
                    return const DecoratedBox(
                      decoration: BoxDecoration( color: Colors.black) // ... el fondo es negro
                    );
                  }
              
                  return FadeInRight(child: child);
                },
              ),
              Padding( //TITULO DE LA PELICULA
                padding: const EdgeInsets.fromLTRB(10,10,0,0),
                child: Text(
                  movie.title, 
                  style: const TextStyle(
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 3.0,
                        color: Colors.black,
                      )
                    ]
                  )
                ),
              )
            ]
          )
        )
      ),
    );
  }
}