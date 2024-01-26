import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/movie_model.dart';
import '../pages/detail_page.dart';
import '../utils.dart';
import 'carousel_slider.dart';

class UpcomingMovies extends StatelessWidget {
  const UpcomingMovies({required this.future, Key? key}) : super(key: key);
  final Future<Model> future;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Model>(
      future: future,
      builder: (context, snapshot) {
        try {
          if (snapshot.hasData) {
            final data = snapshot.data?.results;
            return Column(
              children: [
                Text(
                  'Upcoming Movies',
                  style: GoogleFonts.poppins(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                  // height: 30,
                ),
                MyCarouselSlider(
                  itemCount: data!.length,
                  itemBuilder: (context, index, realindex) {
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  isTvShow: false,
                                  data: snapshot.data!,
                                  index: index,
                                ),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              '$imageUrl${data[index].posterPath!}',
                              // width: 174.5,
                              // height: 250,
                              width: 185,
                              height: 350,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              height: 60,
                              width: 185,
                              padding: const EdgeInsets.all(10),
                              color: Colors.black26,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data[index].title ?? data[index].name!,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    Text(
                                      getGenres(data[index].genreIds!),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            );
          } else if (snapshot.hasError) {
            // Handle errors gracefully
            print('Error: ${snapshot.error}');
            // You can return an error widget or show an error message
            // return Text('Error: ${snapshot.error}');
            return Text('');
          } else {
            return Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 2.5,
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );
          }
        } catch (error) {
          print('Exception: $error');
          // Handle exceptions gracefully
          // You can return an error widget or show an error message
          // return Text('Exception: $error');
          return Text('');
        }
      },
    );
  }
}
