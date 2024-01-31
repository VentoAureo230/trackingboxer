class Photo {
  final int id;
  final String url;
  final String longitude;
  final String latitude;
  final DateTime publicationDate;

  Photo({required this.id, required this.url, required this.longitude, required this.latitude, required this.publicationDate});

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
    return {
      'id': id,
      'url': url,
      'longitude': longitude,
      'latitude': latitude,
      'publication_date': publicationDate.toIso8601String(),
    };
  }
}