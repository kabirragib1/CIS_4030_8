class MovieCast {

  String name;
  String character;

  MovieCast(this.name, this.character);

  factory MovieCast.fromJson(Map<String, dynamic> json) {

  return MovieCast(
    json['name'] as String,
    json['character'] as String
  );
}

}