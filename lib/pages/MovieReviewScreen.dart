import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class MovieReviewScreen extends StatefulWidget {
  final Map<String, dynamic> jsonResponse;
  final bool isLoading;
  const MovieReviewScreen(
      {super.key, required this.jsonResponse, required this.isLoading});

  @override
  State<MovieReviewScreen> createState() => _MovieReviewScreenState();
}

class _MovieReviewScreenState extends State<MovieReviewScreen> {
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
        elevation: 20,
        title: Text(
          "Movie Reviews",
          style: GoogleFonts.poppins(
              fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.network(
              //   jsonResponse['imag'],
              //   width: 150.0, // Set the desired width
              //   height: 200.0, // Set the desired height
              //   fit: BoxFit.cover,
              // ),
              // SizedBox(height: 16.0),
              // Text(
              //   jsonResponse['movie_name'],
              //   style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              // ),
              // SizedBox(height: 8.0),
              // Text(
              //   'Rating: ${jsonResponse['movie_rating']}',
              //   style: TextStyle(fontSize: 16.0),
              // ),
              // SizedBox(height: 8.0),
              // Text(
              //   jsonResponse['plot'],
              //   style: TextStyle(fontSize: 16.0),
              // ),
              // SizedBox(height: 16.0),
              // Text(
              //   'Reviews:',
              //   style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              // ),
              SizedBox(height: 8.0),
              // Display reviews using a ListView.builder
              widget.isLoading
                  ? Center(
                      child: Lottie.asset(
                        'assets/lattie_animations/loading.json',
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.jsonResponse['review_complete'].length,
                      itemBuilder: (context, index) {
                        var review =
                            widget.jsonResponse['review_complete'][index];
                        return widget.isLoading
                            ? Center(
                                child: Lottie.asset(
                                  'assets/lattie_animations/loading.json',
                                ),
                              )
                            : ReviewWidget(review: review);
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
          physics: ClampingScrollPhysics(),
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
                ? Text(
                    review[5], // Review content
                    style: TextStyle(color: Colors.green, fontSize: 14.0),
                    textAlign: TextAlign.center,
                  )
                : Text(
                    review[5], // Review content
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),
          ],
        ),
      ),
    );
    //   ),
    // );
  }
}
