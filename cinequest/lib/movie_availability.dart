class MovieAvailability{
  final int id;
  final String country_short_form;
  final String link;
  final List<FlatRate> flatrate;

  MovieAvailability({
    required this.id,
    required this.country_short_form,
    required this.link,
    required this.flatrate,
  });

  factory MovieAvailability.fromJson(int id, String country_short_form, Map<String, dynamic> json) {
    return MovieAvailability(
      id: id,
      country_short_form: country_short_form,
      link: json['link'],
      flatrate: (json['flatrate'] as List<dynamic>).map((providerJson) => FlatRate.fromJson(providerJson)).toList(),
    );
  }
}

class FlatRate {
  final String logo_path;
  final int provider_id;
  final String provider_name;
  final int display_priority;

  FlatRate({
    required this.logo_path,
    required this.provider_id,
    required this.provider_name,
    required this.display_priority,
  });

  factory FlatRate.fromJson(Map<String, dynamic> json) {
    return FlatRate(
      logo_path: json['logo_path'],
      provider_id: json['provider_id'],
      provider_name: json['provider_name'],
      display_priority: json['display_priority'],
    );
  }
}