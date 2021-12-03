class Vale {
  String id;
  String plaka;
  String zaman;

  Vale({required this.id, required this.plaka, required this.zaman});

  factory Vale.fromJson(Map<String, dynamic> json) {
    return Vale(
      id: json['id'] as String,
      plaka: json['plaka'] as String,
      zaman: json['zaman'] as String,
    );
  }
}
