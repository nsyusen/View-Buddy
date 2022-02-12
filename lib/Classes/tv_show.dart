// Keeps information regarding TV Shows and their poster images
class TVShow {
  final String _title;
  final String _imageURL;
  final String _overview;
  final int _id;

  const TVShow({
    required String title,
    required String imageURL,
    required String overview,
    required int id,
  }) : _title = title, _imageURL = "https://image.tmdb.org/t/p/original" + imageURL, _overview = overview, _id = id;

  String get title => _title;
  String get imageURL => _imageURL;
  String get overview => _overview;
  int get id => _id;
}