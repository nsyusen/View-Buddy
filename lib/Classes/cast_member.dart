// Keeps information pertaining to an actor
class CastMember {
  final String _name;
  final String _character;
  final String _imageURL;
  final int _id;

  const CastMember({
    required String name,
    required String character,
    required String imageURL,
    required int id,
  }) : _name = name, _imageURL = "https://image.tmdb.org/t/p/original" + imageURL, _character = character, _id = id;

  String get name => _name;
  String get imageURL => _imageURL;
  String get character => _character;
  int get id => _id;

}