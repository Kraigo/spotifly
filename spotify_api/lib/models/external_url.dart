import 'dart:convert';

class ExternalUrl {
  final String spotify;
  ExternalUrl({
    required this.spotify,
  });

  Map<String, dynamic> toMap() {
    return {
      'spotify': spotify,
    };
  }

  factory ExternalUrl.fromMap(Map<String, dynamic> map) {
    return ExternalUrl(
      spotify: map['spotify'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ExternalUrl.fromJson(String source) => ExternalUrl.fromMap(json.decode(source));
}