import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:view_buddy/Classes/cast_member.dart';
import 'package:view_buddy/Classes/tv_show.dart';

// An interface to perform TV Show queries on TMDb
class TVService {

  final String _tmdbAPI = "3b05de31c5bf2d6e9222e656c2d4b3bc";

  // Retrieves popular TV Shows from TMDb
  Future<List<TVShow>> fetchPopularTVShows() async {
    List<TVShow> finalTVShows = [];
    final response = await http.get(Uri.parse("https://api.themoviedb.org/3/tv/popular?api_key=${_tmdbAPI}&language=en-US"));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      List<dynamic> shows = body["results"];
      shows.forEach((show) {
        finalTVShows.add(TVShow(title: show["name"], imageURL: show["poster_path"], overview: show["overview"], id: show["id"]));
      });
      return finalTVShows;
    } else {
      throw Exception("Failed to load popular TV shows");
    }
  }

  // Retrieves cast members for a TV Show with specified TMDB id
  Future<List<CastMember>> getTVCast(int id) async {
    List<CastMember> members = [];
    final response = await http.get(Uri.parse("https://api.themoviedb.org/3/tv/$id/credits?api_key=${_tmdbAPI}&language=en-US"));
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