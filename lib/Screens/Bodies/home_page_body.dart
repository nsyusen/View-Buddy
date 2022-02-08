import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:view_buddy/Classes/movie.dart';
import 'package:view_buddy/Classes/tv_show.dart';
import 'package:view_buddy/Screens/movie_page_screen.dart';
import 'package:view_buddy/Screens/tvshow_page_screen.dart';
import 'package:view_buddy/services/movie_service.dart';
import 'package:view_buddy/services/tv_service.dart';

class HomePageBody extends StatefulWidget {
  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> with AutomaticKeepAliveClientMixin<HomePageBody>{

  late Future<List<Movie>> movie_future;
  late Future<List<TVShow>> tv_future;

  MovieService get movieService => GetIt.I<MovieService>();
  TVService get tvService => GetIt.I<TVService>();

  @override
  void initState() {
    super.initState();
    movie_future = movieService.fetchPopularMovies();
    tv_future = tvService.fetchPopularTVShows();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  top: 20.0,
                ),
                child: Text(
                  "Popular Movies",
                  style: GoogleFonts.manrope(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.w900
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Container(
              width: screenSize.width,
              height: screenSize.height/2,
              child: FutureBuilder<List<Movie>>(
                  future: movie_future,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          addAutomaticKeepAlives: true,
                          itemBuilder: (context, index) => _movieListBuilder(context, index, snapshot)
                      );
                    } else {
                      return Container();
                    }
                  }
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 20.0,
                ),
                child: Text(
                  "Popular TV",
                  style: GoogleFonts.manrope(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.w900
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Container(
              width: screenSize.width,
              height: screenSize.height/2,
              child: FutureBuilder<List<TVShow>>(
                  future: tv_future,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          cacheExtent: 9999,
                          addAutomaticKeepAlives: true,
                          itemBuilder: (context, index) => _tvListBuilder(context, index, snapshot)
                      );
                    } else {
                      return Container();
                    }
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _movieListBuilder(BuildContext context, int index, AsyncSnapshot<List<dynamic>> snapshot) {
    Size screenSize = MediaQuery.of(context).size;
    Movie movie = snapshot.data![index];
    CachedNetworkImage image = CachedNetworkImage(
      imageUrl: movie.imageURL,
      placeholder: (context, url) => Image.asset(
        "assets/images/default_poster.png"
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(context, FadeRoute(page: MoviePageScreen(image: image, movie: movie)));
          },
          child: Container(
            height: double.infinity,
            width: screenSize.height/3,
            child: PhysicalModel(
              color: Colors.transparent,
              shadowColor: Colors.black,
              elevation: 7,
              child: Hero(
                tag: movie.imageURL,
                child: image,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tvListBuilder(BuildContext context, int index, AsyncSnapshot<List<dynamic>> snapshot) {
    Size screenSize = MediaQuery.of(context).size;
    TVShow tvShow = snapshot.data![index];
    CachedNetworkImage image = CachedNetworkImage(
      imageUrl: tvShow.imageURL,
      placeholder: (context, url) => Image.asset(
        "assets/images/default_poster.png"
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.push(context, FadeRoute(page: TVShowPageScreen(image: image, tvShow:tvShow)));
          },
          child: Container(
            height: double.infinity,
            width: screenSize.height/3,
            color: Colors.transparent,
            child: PhysicalModel(
              elevation: 7,
              color: Colors.transparent,
              shadowColor: Colors.black,
              child: Hero(
                tag: tvShow.imageURL,
                child: image,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({
    required this.page
  }) : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) => page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) => FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}