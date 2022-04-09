settingsFromMap(map) {
  return List<Settings>.from(map.map((value) => Settings.fromMap(value)));
}

class Settings {
  final int? id;
  final String? currency;
  final String? language;

  Settings({this.id, this.currency, this.language});

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      id: map["id"],
      currency: map["currency"],
      language: map["language"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "currency": currency,
      "language": language,
    };
  }
}
