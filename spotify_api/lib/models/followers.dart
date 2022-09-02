import 'dart:convert';

class Followers {
  final String href;
  final int total;
  Followers({
    required this.href,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'href': href,
      'total': total,
    };
  }

  factory Followers.fromMap(Map<String, dynamic> map) {
    return Followers(
      href: map['href'] ?? '',
      total: map['total']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Followers.fromJson(String source) => Followers.fromMap(json.decode(source));
}