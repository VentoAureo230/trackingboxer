class Training {
  final int id;
  final int timer;
  final int jumpCount;
  final int photoId;

  Training({required this.id, required this.timer, required this.jumpCount, required this.photoId});

  factory Training.fromMap(Map<String, dynamic> map) {
    return Training(
      id: map['id'],
      timer: map['timer'],
      jumpCount: map['jump_count'],
      photoId: map['photo_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timer': timer,
      'jump_count': jumpCount,
      'photo_id': photoId,
    };
  }
}