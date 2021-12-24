transactionsFromMap(var map) {
  return List<Transactions>.from(map.map((value) => Transactions.fromMap(value)));
}

class Transactions {
  final int? id;
  final String? description;
  final DateTime? date;
  final double? amount;
  final int? categoryID;
  final String? title;
  final int? state;
  Transactions({
    this.id,
    this.description,
    this.date,
    this.amount,
    this.categoryID,
    this.title,
    this.state,
  });

  factory Transactions.fromMap(Map<String, dynamic> map) {
    return Transactions(
      id: map['id'],
      amount: map['amount'],
      title: map['title'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      state: map['state'],
      categoryID: map['category_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "amount": amount,
      "title": title,
      "description": description,
      "date": date?.toIso8601String(),
      "state": state,
      "category_id": categoryID,
    };
  }
}
