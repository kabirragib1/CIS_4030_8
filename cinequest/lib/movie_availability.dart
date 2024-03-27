class MovieAvailability{
  final int id;
  final String country_short_form;
  final String link;
  final List<StreamingServcie> streaming_services;

  MovieAvailability({
    required this.id,
    required this.country_short_form,
    required this.link,
    required this.streaming_services,
  });

  factory MovieAvailability.fromJson(int id, String country_short_form, Map<String, dynamic> json) {
    return MovieAvailability(
      id: id,
      country_short_form: country_short_form,
      link: json['link'],
      streaming_services: (json['flatrate'] as List<dynamic>).map((streaming_service) => StreamingServcie.fromJson(streaming_service)).toList(),
    );
  }
}

class StreamingServcie {
  final String logo_path;
  final int provider_id;
  final String provider_name;
  final int display_priority;

  StreamingServcie({
    required this.logo_path,
    required this.provider_id,
    required this.provider_name,
    required this.display_priority,
  });

  factory StreamingServcie.fromJson(Map<String, dynamic> json) {
    return StreamingServcie(
      logo_path: json['logo_path'],
      provider_id: json['provider_id'],
      provider_name: json['provider_name'],
      display_priority: json['display_priority'],
    );
  }
}