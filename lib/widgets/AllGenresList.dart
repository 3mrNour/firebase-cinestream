import 'package:cinestream/data/models/genere_model.dart';
import 'package:cinestream/providers/navBar_provider.dart';
import 'package:cinestream/providers/search_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllGenresList extends StatelessWidget {
  const AllGenresList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: 160,
        child: GridView.builder(
          cacheExtent: 500,
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 10,
            childAspectRatio: 1.1 / 1.3,
          ),
          itemCount: genresList.length,
          itemBuilder: (context, index) {
            final genre = genresList[index];

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Material(
                color: Colors.transparent,
                child: Ink(
                  width: 120,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff8747ff),
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [Color(0xff413066), Color(0xff291E40)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    splashColor: Color(0xff413066),
                    onTap: () {
                      Provider.of<SearchProvider>(
                        context,
                        listen: false,
                      ).searchByGenre(genre.id, genre.name);

                      Provider.of<NavProvider>(
                        context,
                        listen: false,
                      ).changeIndex(1);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(genre.icon, color: Colors.amber, size: 25),
                        const SizedBox(height: 8),
                        Text(
                          genre.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
