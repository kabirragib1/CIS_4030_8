class MovieCrew {

  String name;
  String job;

  MovieCrew(this.name, this.job);

  factory MovieCrew.fromJson(Map<String, dynamic> json) {

  return MovieCrew(
    json['name'] as String,
    json['job'] as String,
  );
}

}