import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:view_buddy/Classes/movie.dart';

import 'Bodies/movie_page_body.dart';

class MoviePageScreen extends StatelessWidget {

  final CachedNetworkImage image; // Cached movie poster
  final Movie movie;

  const MoviePageScreen({
    Key? key,
    required this.image,
    required this.movie,
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
          child: MoviePageBody(image: image, movie: movie),
        )
    );
  }

}