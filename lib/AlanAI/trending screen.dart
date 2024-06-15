import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/movie_model.dart';
import '../widgets/movies_listview.dart';

class TrendingScreenAlanAI extends StatefulWidget {
  final Future<Model> future;
  const TrendingScreenAlanAI({super.key, required this.future});

  @override
  State<TrendingScreenAlanAI> createState() => _TrendingScreenAlanAIState();
}

class _TrendingScreenAlanAIState extends State<TrendingScreenAlanAI> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MoviesListView(
            future: widget.future, headlineText: 'Trending', gridView: true),
      ),
    );
  }
}
