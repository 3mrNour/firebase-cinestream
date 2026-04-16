import 'package:cinestream/providers/navBar_provider.dart';
import 'package:cinestream/providers/search_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    final navProvider = Provider.of<NavProvider>(context);
    if (!searchProvider.isSearchMode) {
      _searchController.clear();
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: SizedBox(
          width: 320,
          height: 40,
          child: TextField(
            cursorColor: Colors.amber,
            textInputAction: TextInputAction.search,
            keyboardType: TextInputType.text,
            controller: _searchController,
            onSubmitted: (value) {
              searchProvider.submitSearch(value);
              navProvider.changeIndex(1);
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 10,
              ),
              labelText: "Search for movies, TV shows, and more",
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelStyle: TextStyle(
                color: Color.fromARGB(68, 255, 255, 255),
                fontSize: 14,
              ),
              prefixIcon: const Icon(Icons.search, color: Color(0xffFFCD30)),
              filled: true,
              fillColor: Color.fromARGB(75, 124, 92, 192),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  color: Color.fromARGB(0, 255, 207, 48),
                  width: 0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  color: Color(0xffFFCD30),
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
