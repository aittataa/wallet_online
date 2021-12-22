transactionsFromMap(var map) {
  return List<Transactions>.from(map.map((value) => Transactions.fromMap(value)));
}

class Transactions {
  final int? id;
  final String? description;
  final DateTime? date;
  final double? amount;
  final int? categoryID;
  final String? categoryTitle;
  final int? state;
  Transactions({
    this.id,
    this.description,
    this.date,
    this.amount,
    this.categoryID,
    this.categoryTitle,
    this.state,
  });

  factory Transactions.fromMap(Map<String, dynamic> map) {
    return Transactions(
      id: map['id'],
      description: map['description'],
      date: map['date'] == null ? null : DateTime.parse(map['date']),
      amount: map['amount'],
      categoryID: map['category_id'],
      categoryTitle: map['title'],
      state: map['state'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "description": description,
      "date": date?.toIso8601String(),
      "amount": amount,
      "category_id": categoryID,
      "state": state,
    };
  }
}
