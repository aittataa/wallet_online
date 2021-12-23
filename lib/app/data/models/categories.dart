categoriesFromMap(map) {
  return List<Categories>.from(map.map((value) => Categories.fromMap(value)));
}

class Categories {
  final int? id;
  final String? title;
  final int? color;
  final int? state;
  final double? total;

  Categories({
    this.id,
    this.title,
    this.color,
    this.state,
    this.total,
  });

  factory Categories.fromMap(Map<String, dynamic> map) {
    return Categories(
      id: map["id"],
      title: map["title"],
      color: map["color"],
      state: map["state"],
      total: map["total"] ?? 0,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "color": color,
      "state": state,
    };
  }
}
