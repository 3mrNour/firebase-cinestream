import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinestream/data/api/api_endpoints.dart';
import 'package:cinestream/providers/movies_provider.dart';
import 'package:cinestream/screens/MovieScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRatedListBuilder extends StatelessWidget {
  const TopRatedListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GridView.builder(
        cacheExtent: 500,
        shrinkWrap: true,
        padding: .only(bottom: 100),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.1 / 1.5,
        ),
        itemCount: moviesProvider.popularMovies.length,
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            height: 200,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),

              child: Stack(
                fit: .passthrough,
                children: [
                  CachedNetworkImage(
                    memCacheWidth: 300,

                    imageUrl:
                        ApiEndpoints().ImageBaseUrl +
                        moviesProvider.popularMovies[index].posterPath,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
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
                      height: .infinity,
                      width: .infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black, Colors.transparent],
                          stops: const [0.0, 0.5],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    width: 60,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(
                          255,
                          15,
                          15,
                          12,
                        ).withOpacity(0.5),

                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: .center,
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            SizedBox(width: 5),
                            Text(
                              moviesProvider.popularMovies[index].voteAverage
                                  .toStringAsFixed(1),
                              style: TextStyle(
                                color: Colors.amber,
                                fontWeight: .bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 10,
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color.fromARGB(155, 50, 11, 143),
                            border: Border.all(
                              color: Color.fromARGB(176, 95, 27, 255),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                              vertical: 2,
                            ),
                            child: Text(
                              moviesProvider.getFirstGenre(
                                currentMovie:
                                    moviesProvider.popularMovies[index],
                                index: index,
                                moviesList: moviesProvider.popularMovies,
                              ),
                              style: TextStyle(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                fontWeight: .w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: 150,
                          child: Text(
                            moviesProvider.popularMovies[index].title,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: .w600,
                              fontSize: 16,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Ink(
                      child: InkWell(
                        splashColor: Colors.white.withOpacity(0.5),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MovieScreen(
                                movie: moviesProvider.popularMovies[index],
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
          );
        },
      ),
    );
  }
}
