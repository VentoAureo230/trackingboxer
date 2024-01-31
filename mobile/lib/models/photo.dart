class Photo {
  final int? id;
  final String url;
  final String longitude;
  final String latitude;
  final DateTime publicationDate;

  Photo({this.id, required this.url, required this.longitude, required this.latitude, required this.publicationDate});

  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      id: map['id'],
      url: map['url'],
      longitude: map['longitude'].toDouble(),
      latitude: map['latitude'].toDouble(),
      publicationDate: DateTime.parse(map['publication_date']),
    );
  }

  Map<String, dynamic> toMap() {
    var map = {
        'url': url,
        'longitude': longitude,
        'latitude': latitude,
        'publication_date': publicationDate.toIso8601String(),
    };

    if (id != null && id != 0) {
      map['id'] = id as String;
    }

    return map;
  }
}