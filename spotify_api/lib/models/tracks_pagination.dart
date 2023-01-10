import 'dart:convert';

import 'track.dart';

class TracksPagination {
  final String href;
  final List<Track> items;
  final int limit;
  final String next;
  final int offset;
  final String previous;
  final int total;

  TracksPagination({
    required this.href,
    required this.items,
    required this.limit,
    required this.next,
    required this.offset,
    required this.previous,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'href': href,
      'items': items.map((x) => x.toMap()).toList(),
      'limit': limit,
      'next': next,
      'offset': offset,
      'previous': previous,
      'total': total,
    };
  }

  factory TracksPagination.fromMap(Map<String, dynamic> map) {
    return TracksPagination(
      href: map['href'] ?? '',
      items: List<Track>.from(map['items']?.map((x) => Track.fromMap(x)) ?? []),
      limit: map['limit']?.toInt() ?? 0,
      next: map['next'] ?? '',
      offset: map['offset']?.toInt() ?? 0,
      previous: map['previous'] ?? '',
      total: map['total']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TracksPagination.fromJson(String source) =>
      TracksPagination.fromMap(json.decode(source));
}
