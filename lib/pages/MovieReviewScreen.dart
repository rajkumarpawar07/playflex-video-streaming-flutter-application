import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';
import 'package:http/http.dart' as http;

class MovieReviewScreen extends StatefulWidget {
  // final Map<String, dynamic> jsonResponse;
  // final bool isLoading;
  final String movieType;
  const MovieReviewScreen(
      // {super.key, required this.jsonResponse, required this.isLoading});
      {super.key,
      required this.movieType});

  @override
  State<MovieReviewScreen> createState() => _MovieReviewScreenState();
}

class _MovieReviewScreenState extends State<MovieReviewScreen> {
  bool isLoading2 = false;
  Map<String, dynamic> jsonResponse = {};

  @override
  void initState() {
    super.initState();
    fetchMovieDetails(widget.movieType);
    // print(widget.jsonResponse);
  }

  /// function that will execute on onTap of movie name
  Future<void> fetchMovieDetails(String type) async {
    setState(() {
      isLoading2 = true;
    });
    try {
      // Make the GET request
      print(type);
      final response = await http
          // .get(Uri.parse('http://192.168.29.234:5000/responsed_url/$type'));
          .get(Uri.parse(
              'https://playflex-flask-server1.onrender.com/responsed_url/$type'));

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        setState(() {
          jsonResponse = json.decode(response.body);
          isLoading2 = false;
        });
        print(response.body);
        // Get.to(() => MovieReviewScreen(
        //     jsonResponse: json.decode(response.body), isLoading: isLoading2));
      } else {
        // Handle the error if the request was not successful
        print(
            'Failed to load movie details. Status code: ${response.statusCode}');
        setState(() {
          isLoading2 = false;
        });
      }
    } catch (error) {
      // Handle any exceptions that may occur
      print('Error: $error');
      setState(() {
        isLoading2 = false;
      });
    }
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
        elevation: 20,
        title: Text(
          "Movie Reviews",
          style: GoogleFonts.poppins(
              fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: isLoading2
          ? Center(
              child: SizedBox(
                width: 70,
                child: Lottie.asset(
                  'assets/lattie_animations/loading.json',
                ),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.0),
                    // Display reviews using a ListView.builder
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: jsonResponse['review_complete'].length,
                      itemBuilder: (context, index) {
                        var review = jsonResponse['review_complete'][index];
                        return ReviewWidget(review: review);
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class ReviewWidget extends StatelessWidget {
  // final List<dynamic> review;
  final dynamic review;

  ReviewWidget({required this.review});

  @override
  Widget build(BuildContext context) {
    String color = review[4];
    bool isGreen = false;
    if (color == "green") {
      isGreen = true;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        // child: SingleChildScrollView(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Text(
              review[0],
              // Review title
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              review[1], // Review rating
              style: TextStyle(fontSize: 14.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Text(
              review[2], // Review author
              style: TextStyle(fontSize: 14.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            isGreen
                ? ReadMoreText(
                    review[5], // Review content
                    style: TextStyle(color: Colors.green, fontSize: 14.0),
                    textAlign: TextAlign.center,
                    trimLines: 10,
                    trimMode: TrimMode.Line,
                    trimExpandedText: " Show less",
                    trimCollapsedText: " Show more",
                    moreStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                    lessStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  )
                : ReadMoreText(
                    review[5], // Review content
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                    textAlign: TextAlign.center,
                    trimLines: 10,
                    trimMode: TrimMode.Line,
                    trimExpandedText: " Show less",
                    trimCollapsedText: " Show more",
                    moreStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                    lessStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  ),
          ],
        ),
      ),
    );
    //   ),
    // );
  }
}
