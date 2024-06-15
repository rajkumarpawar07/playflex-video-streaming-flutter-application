import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_flutter_app/src/constants/sizes.dart';
import 'package:login_flutter_app/whatToWatch/random_movies.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../models/movie_model.dart';
import '../services/services.dart';
import '../src/constants/colors.dart';
import '../src/constants/image_strings.dart';
import '../widgets/movies_listview.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class whatToWtach extends StatefulWidget {
  const whatToWtach({super.key});

  @override
  State<whatToWtach> createState() => _whatToWtachState();
}

class _whatToWtachState extends State<whatToWtach> {
  late Future<Model> topRatedFuture;

  @override
  void initState() {
    // topRatedFuture = getTopRatedMovies();
    // getRandomMovie(1);
    topRatedFuture = getRandomMovie(28);

    super.initState();
  }

  Future<Model> getRandomMovie(int category) async {
    final String apiKey = '685caa0e111d2a893e4f02d52df9587b';
    final String language = 'en-US';
    // try {
    // Generate a random page number between 1 and 1000
    final int randomPage = 1 + (DateTime.now().microsecondsSinceEpoch % 100);

    final String url =
        'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&language=$language&include_adult=false&with_genres=$category&page=$randomPage&sort_by=popularity.desc';

    final http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      // Choose a random movie from the results
      final int randomIndex =
          DateTime.now().microsecondsSinceEpoch % results.length;
      final Map<String, dynamic> movieData = results[randomIndex];

      print('random movie data: $movieData');
      return modelFromJson(response.body);
      // Create a Movie object from the selected movie data
      // return Movie.fromJson(movieData);
    } else {
      throw Exception('failed to load top rated movies');

      print('Failed to load random movie. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    // } catch (e) {
    //   print('error $e');
    // }
  }

  final String myAPI = '685caa0e111d2a893e4f02d52df9587b';
  final String myAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ODVjYWEwZTExMWQyYTg5M2U0ZjAyZDUyZGY5NTg3YiIsInN1YiI6IjY0ZDIzYTA2ODUwOTBmMDBhZTg0ZjY2NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qJIfAirXYT0qaK3n6sHnJEPepr29TKKumEovZScNNzA';

  loadMovies() {
    final tmdbWithCustomLogs = TMDB(
      //TMDB instance
      ApiKeys(myAPI, myAccessToken), //ApiKeys instance with your keys,
      logConfig: const ConfigLogger(
        showLogs: true, //must be true than only all other logs will be shown
        showErrorLogs: true,
      ),
    );
  }

  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        toolbarHeight: 60,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.purple, Colors.red],
                  begin: Alignment.bottomRight,
                  end: Alignment.bottomLeft),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
        ),
        title: Text(
          "What to watch?",
          style: GoogleFonts.poppins(
              fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          randomMovies(
            future: topRatedFuture,
            headlineText: 'Top Rated Movies',
            counter: _counter,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        autofocus: true,
        elevation: 12,
        highlightElevation: 50,
        backgroundColor: tPrimaryColor,
        foregroundColor: Colors.white,
        tooltip: 'Shuffle',
        child: Icon(
          Icons.shuffle,
          size: 30,
          color: Colors.black,
        ),
        onPressed: () {
          // _incrementCounter();
          setState(() {
            topRatedFuture = getRandomMovie(28);
          });
        },
      ),
    );
  }
}
