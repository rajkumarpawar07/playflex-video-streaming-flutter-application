import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../services/services.dart';
import 'movies_listview.dart';

class SimilarWidget extends StatefulWidget {
  const SimilarWidget(
      {Key? key,
      required this.data,
      required this.index,
      required this.isTvShow})
      : super(key: key);
  final Model data;
  final int index;
  final bool isTvShow;
  @override
  State<SimilarWidget> createState() => _SimilarWidgetState();
}

class _SimilarWidgetState extends State<SimilarWidget> {
  late Future<Model> _future;
  @override
  void initState() {
    _future =
        getSimilar(widget.data.results[widget.index].id!, widget.isTvShow);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MoviesListView(
      future: _future,
      headlineText: 'Similar',
    );
  }
}
