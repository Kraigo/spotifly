import 'dart:convert';

import 'external_url.dart';

class Artist {
  final ExternalUrl external_urls;
  final String href;
  final String id;
  final String name;
  final String type;
  final String uri;
  Artist({
    required this.external_urls,
    required this.href,
    required this.id,
    required this.name,
    required this.type,
    required this.uri,
  });

  Map<String, dynamic> toMap() {
    return {
      'external_urls': external_urls.toMap(),
      'href': href,
      'id': id,
      'name': name,
      'type': type,
      'uri': uri,
    };
  }

  factory Artist.fromMap(Map<String, dynamic> map) {
    return Artist(
      external_urls: ExternalUrl.fromMap(map['external_urls']),
      href: map['href'] ?? '',
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      uri: map['uri'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Artist.fromJson(String source) => Artist.fromMap(json.decode(source));

}