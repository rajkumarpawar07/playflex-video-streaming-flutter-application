import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_flutter_app/pages/sentiment_analysis.dart';
import 'package:login_flutter_app/whatToWatch/what_to_watch.dart';
import '../models/credit_model.dart';
import '../models/movie_model.dart';
import '../services/services.dart';
import '../widgets/movies_listview.dart';
import '../widgets/upcoming.dart';
import 'explore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Model> upcomingFuture,
      trendingFuture,
      popularMoviesFuture,
      popularTvFuture,
      topRatedFuture;
  late Future<Credit> creditsFuture;

  @override
  void initState() {
    setupAlan();
    upcomingFuture = getUpcomingMovies();
    trendingFuture = getTrendingMovies();
    popularMoviesFuture = getPopularMovies();
    popularTvFuture = getPopularTvShows();
    topRatedFuture = getTopRatedMovies();
    super.initState();
  }

  /// setup Alan Ai Voice Assistant
  setupAlan() {
    AlanVoice.addButton(
        "a6f7149dd1b7c6f03c53e9d6d479db162e956eca572e1d8b807a3e2338fdd0dc/stage", // real
        // "a6f7149dd1b7c6f03c53e9d6d479db162e956eca572e1d8b807a3e2338fdd0dc/stagee", // fake
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);
    AlanVoice.callbacks.add((command) => handleCommand(command.data));
    // AlanVoice.addConnectionCallback((state) => handleCommand(state));
  }

  void handleCommand(Map<String, dynamic> responce) {
    print("New command: ${responce}");
    switch (responce["command"]) {
      case "Navigate to trending page":
        print("navigate to trending page");
        Get.to(() => ExplorePage());
        break;
      case "movie details":
        break;
      case "alan information":
        break;
      case "app information":
        break;
      case "alan's favourite movie":
        break;
      case "go back":
        Navigator.pop(context);
        break;
      default:
        print("you entered ${responce["command"]}");
    }
  }

  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple,
              Colors.red,
            ],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black,
            blurRadius: 0.0,
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 64.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/playflex_vect.png',
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => whatToWtach(),
                        ));
                  },
                  leading: Icon(Icons.question_mark),
                  title: Text(
                    'What To Watch',
                    style: GoogleFonts.poppins(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                ListTile(
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SentimentAnyalisScreen(),
                        ));
                  },
                  leading: Icon(Icons.face),
                  title: Text(
                    'Sentiment Analysis',
                    style: GoogleFonts.poppins(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      child: Scaffold(
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
          actions: <Widget>[
            // IconButton(
            //   icon: const Icon(Icons.comment),
            //   tooltip: 'Comment Icon',
            //   onPressed: () {},
            // ), //IconButton
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Setting Icon',
              onPressed: () {},
            ), //IconButton
          ],
          elevation: 20,
          title: Text(
            "Playflex",
            style: GoogleFonts.poppins(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu_rounded),
          ),
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 15,
            ),
            UpcomingMovies(
              future: upcomingFuture,
            ),
            const SizedBox(
              height: 10,
            ),
            MoviesListView(future: trendingFuture, headlineText: 'Trending'),
            MoviesListView(
                future: popularMoviesFuture, headlineText: 'Popular Movies'),
            MoviesListView(
                future: popularTvFuture, headlineText: 'Popular TV Shows'),
            MoviesListView(
                future: topRatedFuture, headlineText: 'Top Rated Movies'),
          ],
        ),
      ),
    );
  }
}
