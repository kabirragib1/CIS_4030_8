class MovieCompany {

  int id;
  String logo_path;
  String name;
  String origin_country;

  MovieCompany(this.id, this.logo_path, this.name, this.origin_country);

  factory MovieCompany.fromJson(Map<String, dynamic> json) {

  return MovieCompany(
    json['id'] as int,
    json['logo_path'] != null ? json['logo_path'] as String : '',
    json['name'] as String,
    json['origin_country'] as String,
  );
}

}