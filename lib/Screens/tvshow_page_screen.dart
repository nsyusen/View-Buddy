import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:view_buddy/Classes/tv_show.dart';

import 'Bodies/movie_page_body.dart';
import 'Bodies/tvshow_page_body.dart';

class TVShowPageScreen extends StatelessWidget {

  final CachedNetworkImage image; // Cached TV Show poster
  final TVShow tvShow;

  const TVShowPageScreen({
    Key? key,
    required this.image,
    required this.tvShow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/blur_background.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: TVShowPageBody(image: image, tvShow: tvShow),
        )
    );
  }

}