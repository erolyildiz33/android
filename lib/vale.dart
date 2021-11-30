class Vale {
  String id;
  String plaka;
  String time;

  Vale({required this.id, required this.plaka, required this.time});

  factory Vale.fromJson(Map<String, dynamic> json) {
    return Vale(
      id: json['id'] as String,
      plaka: json['plaka'] as String,
      time: json['time'] as String,
    );
  }
}
