import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinestream/data/api/api_endpoints.dart';
import 'package:cinestream/data/models/movie_model.dart';
import 'package:cinestream/providers/favourite_provider.dart';
import 'package:cinestream/screens/MovieScreen.dart';
import 'package:cinestream/widgets/DelightedToastBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Image(
          image: AssetImage('assets/images/Favourites.png'),
          width: 200,
        ),
        centerTitle: true,
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
            Positioned.fill(
              child: Opacity(
                opacity: 0.1,
                child: ShaderMask(
                  blendMode: BlendMode.dstIn,
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent],
                      stops: [0.0, 2.0],
                    ).createShader(bounds);
                  },
                  child: Image.asset(
                    'assets/images/HD-wallpaper-horror-movie-posters-movies-poster-vintage.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: SafeArea(
                child: Consumer<FavoriteProvider>(
                  builder: (context, favoriteProvider, child) {
                    if (favoriteProvider.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xffFFCD30),
                          strokeWidth: 8,
                        ),
                      );
                    }

                    if (favoriteProvider.favorites.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.favorite_border,
                                color: Colors.white38,
                                size: 72,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'No favourites yet',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Add a movie to your favourites and it will show up here instantly.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      cacheExtent: 500,
                      padding: const EdgeInsets.only(top: 20, bottom: 100),
                      itemCount: favoriteProvider.favorites.length,
                      itemBuilder: (context, index) {
                        final movie = favoriteProvider.favorites[index];
                        return _buildFavouriteCard(
                          context,
                          favoriteProvider,
                          movie,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavouriteCard(
    BuildContext context,
    FavoriteProvider favoriteProvider,
    Movie movie,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 46, 32, 73),
        border: Border.all(color: const Color.fromARGB(26, 255, 230, 0)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: const Color.fromARGB(26, 255, 193, 7),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MovieScreen(movie: movie),
              ),
            );
          },
          child: SizedBox(
            height: 200,
            child: Row(
              children: [
                SizedBox(width: 10),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: CachedNetworkImage(
                    memCacheWidth: 350,
                    imageUrl: ApiEndpoints().ImageBaseUrl + movie.posterPath,
                    width: 120,
                    height: 180,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 120,
                      height: 180,
                      color: Colors.black12,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xffFFCD30),
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 120,
                      height: 180,
                      color: Colors.black26,
                      child: const Icon(
                        Icons.broken_image,
                        color: Colors.white54,
                        size: 34,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 12),
                  child: SizedBox(
                    width: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
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
                            const Icon(
                              Icons.calendar_month,
                              color: Colors.grey,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              movie.releaseDate.year.toString(),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 15),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              movie.voteAverage.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),

                        const SizedBox(height: 10),
                        Text(
                          movie.overview,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(51, 255, 193, 7),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                favoriteProvider.getGenreName(
                                  movie.genreIds.first,
                                ),
                                style: const TextStyle(
                                  color: Colors.amber,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                favoriteProvider.toggleFavorite(movie);
                                CustomToast.show(
                                  context,
                                  status: ToastStatus.removedFromFavorite,
                                );
                              },
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.amber,
                                size: 28,
                              ),
                            ),
                          ],
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
    );
  }
}
