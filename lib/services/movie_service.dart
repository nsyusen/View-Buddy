import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:view_buddy/Classes/cast_member.dart';
import 'package:view_buddy/Classes/movie.dart';

// An interface to perform movie queries on TMDb
class MovieService {

  final String _tmdbAPI = "3b05de31c5bf2d6e9222e656c2d4b3bc";

  // Retrieves popular movies from TMDb
  Future<List<Movie>> fetchPopularMovies() async {
    List<Movie> finalMovies = [];
    final response = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/popular?api_key=${_tmdbAPI}&language=en-US"));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      List<dynamic> movies = body["results"];
      movies.forEach((movie) {
        finalMovies.add(Movie(title: movie["original_title"], imageURL: movie["poster_path"], overview: movie["overview"], id: movie["id"]));
      });
      return finalMovies;
    } else {
      throw Exception("Failed to load popular movies");
    }
  }

  // Retrieves cast members for a movie with a specified TMDb id
  Future<List<CastMember>> getMovieCast(int id) async {
    List<CastMember> members = [];
    final response = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/$id/credits?api_key=${_tmdbAPI}&language=en-US"));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      List<dynamic> results = body["cast"];
      results.forEach((result) {
        if (result["name"] != null && result["character"] != null && result["profile_path"] != null && result["id"] != null) {
          members.add(CastMember(name: result["name"], character: result["character"], imageURL: result["profile_path"], id: result["id"]));
        }
      });
      return members;
    } else {
      throw Exception("Failed to load popular movies");
    }
  }
}