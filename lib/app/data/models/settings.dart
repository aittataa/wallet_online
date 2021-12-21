class Settings {
  final int? id;
  final String? currency;
  Settings({this.id, this.currency});

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      id: map["id"],
      currency: map["currency"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "currency": currency,
    };
  }
}
