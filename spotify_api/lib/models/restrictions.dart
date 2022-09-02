import 'dart:convert';

class Restrictions {
  final String reason;
  Restrictions({
    required this.reason,
  });

  Restrictions copyWith({
    String? reason,
  }) {
    return Restrictions(
      reason: reason ?? this.reason,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reason': reason,
    };
  }

  factory Restrictions.fromMap(Map<String, dynamic> map) {
    return Restrictions(
      reason: map['reason'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Restrictions.fromJson(String source) => Restrictions.fromMap(json.decode(source));

  @override
  String toString() => 'Restrictions(reason: $reason)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Restrictions &&
      other.reason == reason;
  }

  @override
  int get hashCode => reason.hashCode;
}