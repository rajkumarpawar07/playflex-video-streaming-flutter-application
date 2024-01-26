import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/movie_model.dart';
import '../pages/detail_page.dart';
import '../utils.dart';

class randomMovies extends StatefulWidget {
  final int counter;
  final String headlineText;
  final Future<Model> future;
  const randomMovies({
    required this.future,
    Key? key,
    required this.headlineText,
    required this.counter,
  }) : super(key: key);

  @override
  State<randomMovies> createState() => _randomMoviesState();
}

class _randomMoviesState extends State<randomMovies> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Model>(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the future is still loading, display a loading indicator.
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // If there is an error, display an error message or fallback UI.
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          var data = snapshot.data?.results;
          int index = widget.counter; // Index of the movie you want to display

          return Container(
            color: Colors.black,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            isTvShow: widget.headlineText.contains('Movies') ||
                                    data[index].mediaType == MediaType.movie
                                ? false
                                : true,
                            data: snapshot.data!,
                            index: index,
                          ),
                        ),
                      );
                    },
                    child: Stack(children: [
                      Container(
                        child: Image.network(
                          '$imageUrl${data![index].posterPath}',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 240,
                              width: 170,
                              color: Colors.grey,
                            );
                          },
                        ),
                      ),
                      Container(
                        height: 576,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black54, Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            data[index].title ?? data[index].name!,
                            style: GoogleFonts.poppins(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            child: SingleChildScrollView(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.date_range),
                                  Text(
                                    data[index].releaseDate == null
                                        ? data[index]
                                            .firstAirDate
                                            .toString()
                                            .substring(0, 4)
                                        : data[index]
                                            .releaseDate
                                            .toString()
                                            .substring(0, 4),
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Icon(Icons.star),
                                  Text(
                                    data[index].voteAverage.toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            data[index].genreIds!.isNotEmpty
                                ? getGenres(data[index].genreIds!)
                                : '',
                            style: GoogleFonts.poppins(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          // If there is no error and no data, return a fallback UI or an empty widget.
          return const SizedBox.shrink();
        }
      },
    );
  }
}
