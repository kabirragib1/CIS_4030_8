class MovieGenre {

  int id;
  String name;

  MovieGenre(this.id, this.name);

  factory MovieGenre.fromJson(Map<String, dynamic> json) {

  return MovieGenre(
    json['id'] as int,
    json['name'] as String,
  );
}

}