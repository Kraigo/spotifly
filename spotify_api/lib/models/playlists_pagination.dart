import 'dart:convert';

import 'playlist.dart';

class PlaylistsPagination {
  final String href;
  final List<Playlist> items;
  final int limit;
  final String next;
  final int offset;
  final String? previous;
  final int total;

  PlaylistsPagination({
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

  factory PlaylistsPagination.fromMap(Map<String, dynamic> map) {
    return PlaylistsPagination(
      href: map['href'] ?? '',
      items: List<Playlist>.from(map['items']?.map((x) => Playlist.fromMap(x))),
      limit: map['limit']?.toInt() ?? 0,
      next: map['next'] ?? '',
      offset: map['offset']?.toInt() ?? 0,
      previous: map['previous'] ?? '',
      total: map['total']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaylistsPagination.fromJson(String source) =>
      PlaylistsPagination.fromMap(json.decode(source));
}
