import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinestream/data/api/api_endpoints.dart';
import 'package:cinestream/data/models/movie_model.dart';
import 'package:cinestream/providers/selectedMovie_provider.dart';
import 'package:cinestream/screens/MovieScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RelatedMoviesBuilder extends StatelessWidget {
  final Movie movie;
  const RelatedMoviesBuilder({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SelectedMovieProvider(movie),

      child: Consumer<SelectedMovieProvider>(
        builder: (context, value, child) => SizedBox(
          height: 200,
          child: value.isLoadingRelated && value.relatedMovies.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xffFFCD30)),
                )
              : ListView.builder(
                  cacheExtent: 500,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: value.relatedMovies.length,
                  itemBuilder: (context, index) {
                    final relatedMovie = value.relatedMovies[index];
                    return Container(
                      width: 120,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: Ink(
                          child: InkWell(
                            splashColor: const Color.fromARGB(122, 255, 193, 7),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MovieScreen(movie: relatedMovie),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  CachedNetworkImage(
                                    memCacheWidth: 280,
                                    imageUrl:
                                        ApiEndpoints().ImageBaseUrl +
                                        relatedMovie.posterPath,
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder:
                                        (context, url, progress) =>
                                            const Center(
                                              child: SizedBox(
                                                height: 30,
                                                width: 30,
                                                child:
                                                    CircularProgressIndicator(
                                                      color: Colors.amber,
                                                      strokeWidth: 3,
                                                    ),
                                              ),
                                            ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    height: 90,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Colors.black87,
                                            Colors.transparent,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 8,
                                    left: 8,
                                    child: Column(
                                      mainAxisAlignment: .start,
                                      crossAxisAlignment: .start,
                                      children: [
                                        Container(
                                          width: 80,
                                          child: Text(
                                            relatedMovie.title,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: .w600,
                                              fontSize: 12,
                                            ),
                                            maxLines: 2,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 14,
                                            ),
                                            const SizedBox(width: 3),
                                            Text(
                                              relatedMovie.voteAverage
                                                  .toStringAsFixed(1),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
