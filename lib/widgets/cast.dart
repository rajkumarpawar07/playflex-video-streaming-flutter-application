import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retry/retry.dart';

import '../models/credit_model.dart';
import '../services/services.dart';
import '../utils.dart';

class CastWidget extends StatefulWidget {
  const CastWidget({Key? key, required this.id, required this.isTvShow})
      : super(key: key);
  final int id;
  final bool isTvShow;

  @override
  State<CastWidget> createState() => _CastWidgetState();
}

class _CastWidgetState extends State<CastWidget> {
  late Future<Credit> creditsFuture;
  @override
  void initState() {
    creditsFuture = getCredits(widget.id, widget.isTvShow);
    super.initState();
  }

  Future<Credit> _retryOnSocketException(
      Future<Credit> Function() function) async {
    const maxAttempts = 3;
    const delayFactor = Duration(seconds: 2);

    for (var attempt = 0; attempt < maxAttempts; attempt++) {
      try {
        return await function();
      } on SocketException {
        // Handle SocketException, if needed
        print('SocketException occurred. Retrying...');
        await Future.delayed(delayFactor);
      } catch (e) {
        // Handle other types of errors
        print('Error: $e. Retrying...');
        await Future.delayed(delayFactor);
      }
    }
    // If all attempts fail, throw the last error
    throw Exception('Max attempts reached. Unable to complete the operation.');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Credit>(
      future: _retryOnSocketException(() => creditsFuture),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            // Your existing code for handling successful data retrieval
            var data = snapshot.data?.cast;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'The Cast',
                  style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                AspectRatio(
                  aspectRatio: 2.1,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: data!.length > 20 ? 20 : data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 40,
                              child: ClipOval(
                                child: FadeInImage(
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    '$imageUrl${data[index].profilePath}',
                                  ),
                                  placeholder: const NetworkImage(
                                    'http://www.familylore.org/images/2/25/UnknownPerson.png',
                                  ),
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.network(
                                      'http://www.familylore.org/images/2/25/UnknownPerson.png',
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                data[index].name!,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            // Handle the error more gracefully, e.g., show an error message
            print('Error: ${snapshot.error}');
            return Text('Error loading data. Please try again.');
          }
        }

        // While the future is still loading, return a loading indicator or an empty widget.
        return Center(
            child: const CircularProgressIndicator(
          color: Colors.white,
        ));
      },
    );
  }
}
