import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinestream/data/api/api_endpoints.dart';
import 'package:cinestream/providers/movies_provider.dart';
import 'package:cinestream/screens/MovieScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OurChoiceMoive extends StatelessWidget {
  const OurChoiceMoive({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
          child: Image(
            image: AssetImage('assets/images/choices-223.png'),
            width: 200,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 200,

          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(118, 90, 75, 228),
                spreadRadius: 2,
                blurRadius: 20,
                offset: Offset(0, 3),
              ),
            ],
            color: const Color(0x22FFFFFF),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 166, 2),
                Color.fromARGB(118, 255, 255, 255),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color.fromARGB(26, 255, 230, 0)),
          ),
          child: Material(
            color: Colors.transparent,
            child: Ink(
              child: InkWell(
                splashColor: Colors.amber.withOpacity(0.1),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          MovieScreen(movie: moviesProvider.randomMovie!),
                    ),
                  );
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            ApiEndpoints().ImageBaseUrl +
                            moviesProvider.randomMovie!.posterPath,
                        width: 130,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              moviesProvider.randomMovie!.title,

                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,

                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  (moviesProvider.randomMovie!.releaseDate.year)
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Icon(Icons.star, color: Colors.amber, size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  moviesProvider.randomMovie!.voteAverage
                                      .toStringAsFixed(1),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              moviesProvider.randomMovie!.overview,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 10,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                moviesProvider.getFirstGenre(
                                  currentMovie: moviesProvider.randomMovie!,
                                  index: 0,
                                  moviesList: moviesProvider.topRatedMovies,
                                ),
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
