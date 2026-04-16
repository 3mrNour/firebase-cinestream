import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinestream/data/api/api_endpoints.dart';
import 'package:cinestream/providers/movies_provider.dart';
import 'package:cinestream/screens/MovieScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpComingMoviesCarousel extends StatelessWidget {
  const UpComingMoviesCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return SizedBox(
      height: 185,
      width: .infinity,
      child: CarouselSlider.builder(
        itemCount: moviesProvider.nowPlayingMovies.length,
        itemBuilder: (context, index, realIndex) => Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(20),
            child: Stack(
              fit: .passthrough,
              children: [
                CachedNetworkImage(
                  memCacheWidth: 800,
                  imageUrl:
                      ApiEndpoints().ImageBaseUrl +
                      moviesProvider.nowPlayingMovies[index].backdropPath,
                  fit: BoxFit.cover,
                  alignment: .center,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            color: Color(0xffFFCD30),
                            strokeWidth: 10,
                          ),
                        ),
                      ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),

                Positioned(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black, Colors.transparent],
                        stops: const [0.0, 0.6],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 10,
                  right: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        moviesProvider.nowPlayingMovies[index].title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      Text(
                        moviesProvider.nowPlayingMovies[index].overview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: const Color.fromARGB(104, 255, 255, 255),
                        ),
                      ),
                    ],
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: Ink(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MovieScreen(
                              movie: moviesProvider.nowPlayingMovies[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 1.7,
          viewportFraction: .86,
          enlargeCenterPage: true,
          autoPlayCurve: Curves.easeInOutCubic,
          autoPlayAnimationDuration: Duration(seconds: 2),
          autoPlayInterval: Duration(seconds: 7),
          pauseAutoPlayInFiniteScroll: true,
        ),
      ),
    );
  }
}
