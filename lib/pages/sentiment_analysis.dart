import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import '../pages/MovieReviewScreen.dart';
import '../src/utils/theme/widget_theme/my_elevated_button.dart';

class SentimentAnyalisScreen extends StatefulWidget {
  const SentimentAnyalisScreen({super.key});

  @override
  State<SentimentAnyalisScreen> createState() => _myPageState();
}

class _myPageState extends State<SentimentAnyalisScreen> {
  List<String> _movies = [];
  List<String> _movieIds = [];
  String movie_name = "";
  bool isLoading = false;
  bool isLoading2 = false;

  /// function that will execute and will return all movie names when clicked search
  void _postData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.post(
        // Uri.parse('http://192.168.29.234:5000/search_movie'),
        Uri.parse('https://playflex-flask-server1.onrender.com/search_movie'),
        headers: {
          'Content-Type': 'application/json', // Set the correct content type
        },
        body: json.encode(<String, dynamic>{
          'name': movie_name,
        }),
      );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        // Successful response
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> movies = data['movies'];
        List<dynamic> movieIds = data['res'];

        setState(() {
          _movies = List<String>.from(movies);
          _movieIds = List<String>.from(movieIds);
          isLoading = false;
        });
      } else {
        // Handle error response
        // You can set an error message or handle it as needed
        print('Error: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      // Handle network or other errors
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
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
          isLoading2 = false;
        });
        print(response.body);
        Get.to(() => MovieReviewScreen(
            jsonResponse: json.decode(response.body), isLoading: isLoading2));
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                label: Text(
                  "Enter Movie Name",
                  style: TextStyle(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(color: Colors.white)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(color: Colors.white)),
              ),
              onChanged: (text) {
                movie_name = text;
              },
              // controller: _textFieldController,
            ),
            SizedBox(height: 20),
            MyElevatedButton(
              width: double.infinity,
              onPressed: _postData,
              borderRadius: BorderRadius.circular(50),
              child: Text(
                'SEARCH',
                style: GoogleFonts.poppins(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            isLoading
                ? Center(
                    child: Lottie.asset(
                      width: 100,
                      'assets/lattie_animations/loading.json',
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: _movies.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              _movies[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          ),
                          onTap: () async {
                            await fetchMovieDetails(
                                _movieIds[index].toString());
                          },
                          // subtitle: Text('ID: ${_movieIds[index]}'),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
