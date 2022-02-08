import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:view_buddy/Classes/cast_member.dart';
import 'package:view_buddy/Classes/tv_show.dart';
import 'package:view_buddy/services/tv_service.dart';

class TVShowPageBody extends StatefulWidget {

  final CachedNetworkImage image;
  final TVShow tvShow;

  const TVShowPageBody({
    Key? key,
    required this.image,
    required this.tvShow,
  }) : super(key: key);

  @override
  State<TVShowPageBody> createState() => _MoviePageBodyState();
}

class _MoviePageBodyState extends State<TVShowPageBody> {
  double _currentOpacity = 0.0;
  final _controller = ScrollController();

  late Future<List<CastMember>> tvFuture;

  TVService get tvService => GetIt.I<TVService>();

  @override
  void initState() {
    super.initState();
    tvFuture = tvService.getMovieCast(widget.tvShow.id);
    Future.delayed(const Duration(milliseconds: 250), () {
      setState(() {
        _currentOpacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: screenSize.height,
          width: screenSize.width,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Hero(
              tag: widget.tvShow.imageURL,
              child: widget.image,
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: _currentOpacity,
          duration: const Duration(milliseconds: 250),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: screenSize.height*0.5,
                width: screenSize.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.8)
                        ],
                        stops: [
                          0.0, 0.3
                        ]
                    )
                ),
                child: FutureBuilder<List<CastMember>>(
                  future: tvFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: FadingEdgeScrollView.fromSingleChildScrollView(
                          child: SingleChildScrollView(
                            controller: _controller,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Overview",
                                  style: GoogleFonts.manrope(
                                      fontSize: 40,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900
                                  ),
                                ),
                                Text(
                                  widget.tvShow.overview,
                                  style: GoogleFonts.manrope(
                                      fontSize: 15,
                                      color: Colors.white
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Cast",
                                  style: GoogleFonts.manrope(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w900
                                  ),
                                ),
                                Container(
                                  height: 300,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: min(snapshot.data!.length, 5),
                                      addAutomaticKeepAlives: true,
                                      itemBuilder: (context, index) => _castBuilder(context, index, snapshot)
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                )
            ),
          ),
        ),
        SafeArea(
          child: Padding(
              padding: EdgeInsets.only(
                  left: 20,
                  top: 10
              ),
              child: CircleAvatar(
                backgroundColor: Colors.black,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              )
          ),
        )
      ],
    );
  }

  Widget _castBuilder(BuildContext context, int index, AsyncSnapshot<List<dynamic>> snapshot) {
    CastMember castMember = snapshot.data![index];
    CachedNetworkImage image = CachedNetworkImage(
      imageUrl: castMember.imageURL,
      placeholder: (context, url) => Image.asset(
          "assets/images/default_poster.png"
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        right: 50,
      ),
      child: Column(
        children: [
          Container(
            height: 200,
            child: image,
          ),
          Text(
            castMember.name,
            style: GoogleFonts.manrope(
                color: Colors.white,
                fontSize: 15
            ),
          ),
          Text(
              castMember.character,
              style: GoogleFonts.manrope(
                  color: Colors.white,
                  fontSize: 10
              )
          )
        ],
      ),
    );
  }

}