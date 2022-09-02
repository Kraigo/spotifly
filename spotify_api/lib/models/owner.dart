import 'dart:convert';

import 'package:spotify_api/models/external_url.dart';

import 'followers.dart';

class Owner {
  final ExternalUrl externalUrls;
  // final Followers followers;
  final String href;
  final String id;
  final String type;
  final String uri;
  final String displayName;
  Owner({
    required this.externalUrls,
    // required this.followers,
    required this.href,
    required this.id,
    required this.type,
    required this.uri,
    required this.displayName,
  });

  Map<String, dynamic> toMap() {
    return {
      'external_urls': externalUrls.toMap(),
      // 'followers': followers.toMap(),
      'href': href,
      'id': id,
      'type': type,
      'uri': uri,
      'display_name': displayName,
    };
  }

  factory Owner.fromMap(Map<String, dynamic> map) {
    return Owner(
      externalUrls: ExternalUrl.fromMap(map['external_urls']),
      // followers: Followers.fromMap(map['followers']),
      href: map['href'] ?? '',
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      uri: map['uri'] ?? '',
      displayName: map['display_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Owner.fromJson(String source) => Owner.fromMap(json.decode(source));
}
