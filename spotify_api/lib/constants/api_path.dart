part of app_constants;

class ApiPath {
  static const baseUrl = "https://api.spotify.com/v1";
  static getPlaylist(String id) => '/playlists/$id';
  static const getCurrentUserPlaylists  = '/me/playlists';
  static const token = '/api/token';

  static getTrack(String id) => '/tracks/$id';
}