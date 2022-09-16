///HTTP response received after asking for user's favorited posts
class FavResponse {
  final int postid;
  final int category;
  final DateTime timestamp;

  FavResponse({this.postid, this.category, this.timestamp});

  factory FavResponse.fromJson(Map<String, dynamic> json) {
    return FavResponse(
        postid: int.tryParse(json['postid']),
        category: int.tryParse(json['category']),
        timestamp: DateTime.tryParse(json['timestamp']));
  }
}
