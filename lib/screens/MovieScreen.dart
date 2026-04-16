import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinestream/data/api/api_endpoints.dart';
import 'package:cinestream/data/models/movie_model.dart';
import 'package:cinestream/providers/favourite_provider.dart';
import 'package:cinestream/providers/navBar_provider.dart';
import 'package:cinestream/providers/selectedMovie_provider.dart';
import 'package:cinestream/widgets/DelightedToastBar.dart';
import 'package:cinestream/widgets/RelatedMoviesBuilder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieScreen extends StatelessWidget {
  final Movie movie;
  const MovieScreen({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SelectedMovieProvider(movie),
      child: Consumer<SelectedMovieProvider>(
        builder: (context, value, child) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Provider.of<FavoriteProvider>(
                      context,
                      listen: false,
                    ).toggleFavorite(movie);
                    if (Provider.of<FavoriteProvider>(
                      context,
                      listen: false,
                    ).favorites.contains(movie)) {
                      CustomToast.show(
                        status: ToastStatus.addedToFavorite,
                        context,
                      );
                    } else {
                      CustomToast.show(
                        status: ToastStatus.removedFromFavorite,
                        context,
                      );
                    }
                  },
                  icon:
                      Provider.of<FavoriteProvider>(
                        context,
                      ).isFavorite(movie.id)
                      ? Icon(Icons.favorite, color: Colors.amber, size: 28)
                      : Icon(
                          Icons.favorite_border,
                          color: Colors.amber,
                          size: 28,
                        ),
                ),
                const SizedBox(width: 10),
              ],
            ),

            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xff291E40), Color(0xff413066)],
                  stops: [0.1, 0.9],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    child: Opacity(
                      opacity: 0.8,
                      child: ShaderMask(
                        blendMode: BlendMode.dstIn,
                        shaderCallback: (bounds) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black, Colors.transparent],
                            stops: [0.7, 1.0],
                          ).createShader(bounds);
                        },
                        child: CachedNetworkImage(
                          imageUrl:
                              ApiEndpoints().ImageBaseUrl + movie.backdropPath,
                          height: 450,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, progress) =>
                              const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xffFFCD30),
                                ),
                              ),
                          errorWidget: (context, url, error) => Container(
                            height: 350,
                            color: Colors.black26,
                            child: const Icon(
                              Icons.error,
                              color: Colors.amber,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: ListView(
                      children: [
                        SizedBox(height: 150),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            movie.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    movie.voteAverage.toStringAsFixed(1),
                                    style: const TextStyle(
                                      color: Colors.amber,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  const Icon(
                                    Icons.calendar_month,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    (movie!.releaseDate.year).toString(),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: movie.genreIds.map((id) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.amber.withOpacity(0.15),
                                      border: Border.all(
                                        color: Colors.amber.withOpacity(0.5),
                                        width: 0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      value.getGenreName(id),
                                      style: const TextStyle(
                                        color: Colors.amber,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 20),

                              const Text(
                                "Storyline",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                movie.overview,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: const [
                              Text(
                                "Related",
                                style: TextStyle(
                                  color: Color(0xffFFCD30),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                " Shows",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        RelatedMoviesBuilder(movie: movie),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 15),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xffFFCD30).withOpacity(0.2),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Provider.of<NavProvider>(
                                context,
                                listen: false,
                              ).changeIndex(2);
                              Navigator.of(
                                context,
                              ).popUntil((route) => route.isFirst);
                            },
                            icon: const Icon(
                              Icons.bookmark_added_outlined,
                              size: 20,
                            ),
                            label: const Text(
                              "Go to Favourites",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffFFCD30),
                              foregroundColor: const Color(0xff291E40),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                          ),
                        ),
                      ],
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
