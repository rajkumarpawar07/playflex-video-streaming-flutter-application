import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import '../models/credit_model.dart';
import '../models/liked_model.dart';
import '../models/movie_model.dart';
import '../src/utils/theme/widget_theme/my_elevated_button.dart';
import '../utils.dart';
import '../widgets/cast.dart';
import '../widgets/reviews.dart';
import '../widgets/similar.dart';
import '../widgets/videoPlayerScreen.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(
      {Key? key,
      required this.data,
      required this.index,
      this.creditData,
      required this.isTvShow})
      : super(key: key);
  final int index;
  final Model data;
  final Credit? creditData;
  final bool isTvShow;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int count = 0;
  bool _is3MonthsSelected = false;
  bool _is1YearSelected = true;
  bool _isElevated = false;
  int value = 0;
  Widget CustomRadioButton(String text, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          value = index;
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: (value == index) ? Colors.red : Colors.purple,
        ),
      ),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      // borderSide:
      //     BorderSide(color: (value == index) ? Colors.green : Colors.black),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: BorderSide(color: (value == index) ? Colors.red : Colors.purple),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    count = 0;
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<LikedModel>('liked');
    return Scaffold(
        body: CustomScrollView(
      // sliver app bar
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.black,
          expandedHeight: MediaQuery.of(context).size.height / 1.8,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: IconButton(
                  onPressed: () {
                    box.put(
                        widget.data.results[widget.index].id,
                        LikedModel(
                            title: widget.data.results[widget.index].title ??
                                widget.data.results[widget.index].name!,
                            genres: widget.data.results[widget.index].genreIds!,
                            voteAverage:
                                widget.data.results[widget.index].voteAverage!,
                            posterPath:
                                widget.data.results[widget.index].posterPath!,
                            isLiked: !(box
                                    .get(
                                      widget.data.results[widget.index].id,
                                    )
                                    ?.isLiked ??
                                false)));
                    setState(() {});
                  },
                  icon: box
                              .get(
                                widget.data.results[widget.index].id,
                              )
                              ?.isLiked ??
                          false
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border,
                        )),
            )
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              '$imageUrl${widget.data.results[widget.index].posterPath}',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey,
                  child: const Center(child: Text('No Image')),
                );
              },
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((ctx, _) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.data.results[widget.index].title ??
                            widget.data.results[widget.index].name!,
                        style: GoogleFonts.poppins(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    // Spacer(),
                    GestureDetector(
                      onTap: () {
                        print(count);

                        /// todo: play video
                        if (count == 0) {
                          Get.to(() => VideoPlayerScreen());
                        } else {
                          /// Subscription Model
                          setState(() {
                            _isElevated = !_isElevated;
                          });
                          showModalBottomSheet(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              context: context,
                              builder: (context) {
                                return Container(
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        "Subscribe now and start streaming",
                                        style: GoogleFonts.poppins(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      SizedBox(height: 15),
                                      Container(
                                        decoration: BoxDecoration(
                                          // color: Colors.red,
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: EdgeInsets.only(
                                            top: 20, bottom: 20),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(Icons.hd),
                                                Text(
                                                  "Full HD 1080p Video",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(Icons.smart_screen),
                                                Text(
                                                  "TV, Laptop & Mobile",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(Icons.do_not_disturb),
                                                Text(
                                                  "Add Free watching",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(Icons
                                                    .multitrack_audio_rounded),
                                                Text(
                                                  "Upto Dolby Atoms",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.8,
                                              height: 70,
                                              // color: Colors.white,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        // _is1YearSelected =
                                                        //     !_is1YearSelected;
                                                        _is3MonthsSelected =
                                                            !_is3MonthsSelected;
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                '3 Months',
                                                                style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        16.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              Icon(
                                                                _is1YearSelected
                                                                    ? Icons
                                                                        .circle_outlined
                                                                    : Icons
                                                                        .check_circle_outline,
                                                                color: _is1YearSelected
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .black,
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            "Rs.99/Month",
                                                            style: GoogleFonts.poppins(
                                                                fontSize: 12.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      )),
                                                ],
                                              )),
                                          Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.8,
                                              height: 70,
                                              // color: Colors.white,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          _is1YearSelected =
                                                              !_is1YearSelected;
                                                          // _is3MonthsSelected =
                                                          //     !_is3MonthsSelected;
                                                        });
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                '1 Year',
                                                                style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        16.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              Icon(
                                                                _is1YearSelected
                                                                    ? Icons
                                                                        .circle_outlined
                                                                    : Icons
                                                                        .check_circle_outline,
                                                                color: _is1YearSelected
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .black,
                                                              )
                                                            ],
                                                          ),
                                                          Text(
                                                            "Rs.79/Month",
                                                            style: GoogleFonts.poppins(
                                                                fontSize: 12.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      )),
                                                ],
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      MyElevatedButton(
                                        width: double.infinity,
                                        onPressed: () {},
                                        borderRadius: BorderRadius.circular(50),
                                        child: Text(
                                          'SUBSCRIBE',
                                          style: GoogleFonts.poppins(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        }
                        count++;
                      },
                      child: AnimatedContainer(
                        child: Icon(
                          Icons.play_arrow,
                          size: 35,
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                            boxShadow: _isElevated
                                ? [
                                    BoxShadow(
                                        color: Colors.grey[500]!,
                                        offset: Offset(4, 4),
                                        blurRadius: 5,
                                        spreadRadius: 1),
                                    BoxShadow(
                                        color: Colors.black,
                                        offset: Offset(-4, -4),
                                        blurRadius: 3,
                                        spreadRadius: 1)
                                  ]
                                : null),
                        height: 50,
                        width: 50, duration: Duration(milliseconds: 200),
                        // color: Colors.red,
                      ),
                    )
                  ],
                ),
                Wrap(
                  children: List.generate(
                      widget.data.results[widget.index].genreIds!.length,
                      (genreIndex) => Padding(
                            padding: const EdgeInsets.only(right: 10, top: 4),
                            child: Chip(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              side: const BorderSide(width: 0),
                              backgroundColor: Colors.black54.withOpacity(0.1),
                              label: Text(
                                getGenres(widget
                                        .data.results[widget.index].genreIds!)
                                    .split(',')
                                    .elementAt(genreIndex),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                          )),
                ),
                const SizedBox(
                  height: 6,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.date_range,
                        color: Colors.blue,
                      ),
                      Text(widget.data.results[widget.index].releaseDate == null
                          ? widget.data.results[widget.index].firstAirDate
                              .toString()
                              .substring(0, 4)
                          : widget.data.results[widget.index].releaseDate
                              .toString()
                              .substring(0, 4)),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text(widget.data.results[widget.index].voteAverage
                          .toString()),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Story Line',
                  style: GoogleFonts.poppins(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  widget.data.results[widget.index].overview!,
                  style: GoogleFonts.poppins(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white70),
                ),
                const SizedBox(
                  height: 25,
                ),
                CastWidget(
                  id: widget.data.results[widget.index].id!,
                  isTvShow: widget.isTvShow,
                ),
                SimilarWidget(
                    data: widget.data,
                    index: widget.index,
                    isTvShow: widget.isTvShow),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Reviews',
                  style: GoogleFonts.poppins(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                ReviewsWidget(
                    isTvShow: widget.isTvShow,
                    id: widget.data.results[widget.index].id!)
              ],
            ),
          );
        }, childCount: 1))
      ],
    ));
  }
}
