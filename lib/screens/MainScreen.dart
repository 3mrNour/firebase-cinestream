import 'package:cinestream/providers/movies_provider.dart';
import 'package:cinestream/widgets/AllGenresList.dart';
import 'package:cinestream/widgets/CineStreamAppBar.dart';
import 'package:cinestream/widgets/OurChoiceMovie.dart';
import 'package:cinestream/widgets/SearchBox.dart';
import 'package:cinestream/widgets/TopRatedList.dart';
import 'package:cinestream/widgets/UpComingMoviesCarousel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.deepPurple,
        appBar: CineStreamAppBar(),
        body: Container(
          width: .infinity,
          height: .infinity,
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
                  opacity: 0.1,
                  child: ShaderMask(
                    blendMode: BlendMode.dstIn,
                    shaderCallback: (bounds) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black,
                          Colors.black,
                          Colors.transparent,
                        ],
                        stops: [0.0, 0.7, 1.0],
                      ).createShader(bounds);
                    },
                    child: Image.asset(
                      'assets/images/HD-wallpaper-horror-movie-posters-movies-poster-vintage.jpg',
                      scale: 0.2,
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: moviesProvider.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Color(0xffFFCD30),
                          strokeWidth: 10,
                        ),
                      )
                    : Column(
                        children: [
                          SearchBox(),
                          Expanded(
                            child: ListView(
                              children: [
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    crossAxisAlignment: .center,
                                    children: [
                                      Text(
                                        "Now Playing",
                                        textAlign: .right,
                                        style: TextStyle(
                                          color: Color(0xffFFCD30),
                                          fontSize: 20,
                                          fontWeight: .bold,
                                        ),
                                      ),
                                      Text(
                                        " Movies",
                                        textAlign: .right,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: .bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                UpComingMoviesCarousel(),
                                SizedBox(height: 20),
                                OurChoiceMoive(),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    crossAxisAlignment: .center,
                                    children: [
                                      Text(
                                        "All",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Color(0xffFFCD30),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        " Genres",
                                        textAlign: .right,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: .bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                AllGenresList(),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Text(
                                      "Popular",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Color(0xffFFCD30),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      " Movies",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                TopRatedListBuilder(),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
