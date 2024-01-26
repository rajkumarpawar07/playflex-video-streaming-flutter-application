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

class whatToWtach extends StatefulWidget {
  const whatToWtach({super.key});

  @override
  State<whatToWtach> createState() => _whatToWtachState();
}

class _whatToWtachState extends State<whatToWtach> {
  late Future<Model> topRatedFuture;

  @override
  void initState() {
    topRatedFuture = getTopRatedMovies();
    super.initState();
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
          _incrementCounter();
        },
      ),
    );
  }
}
