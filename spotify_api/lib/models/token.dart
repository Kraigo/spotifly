import 'dart:convert';

class Token {
  final String accessToken;
  final String tokenType;
  final String scope;
  final int expiresIn;
  final String? refreshToken;

  Token({
    required this.accessToken,
    required this.tokenType,
    required this.scope,
    required this.expiresIn,
    this.refreshToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'scope': scope,
      'expires_in': expiresIn,
      'refresh_token': refreshToken,
    };
  }

  factory Token.fromMap(Map<String, dynamic> map) {
    return Token(
      accessToken: map['access_token'] ?? '',
      tokenType: map['token_type'] ?? '',
      scope: map['scope'] ?? '',
      expiresIn: map['expires_in']?.toInt() ?? 0,
      refreshToken: map['refresh_token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Token.fromJson(String source) => Token.fromMap(json.decode(source));
}
