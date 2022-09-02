import 'dart:convert';

class Image {
  final String url;
  final int height;
  final int width;
  Image({
    required this.url,
    required this.height,
    required this.width,
  });

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'height': height,
      'width': width,
    };
  }

  factory Image.fromMap(Map<String, dynamic> map) {
    return Image(
      url: map['url'] ?? '',
      height: map['height']?.toInt() ?? 0,
      width: map['width']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Image.fromJson(String source) => Image.fromMap(json.decode(source));
}
