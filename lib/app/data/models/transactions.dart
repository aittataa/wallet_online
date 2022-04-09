import 'package:wallet_online/app/data/models/categories.dart';

transactionsFromMap(var map) {
  return List<Transactions>.from(map.map((value) => Transactions.fromMap(value)));
}

class Transactions {
  final int? id;
  final double? amount;
  final String? title;
  final String? description;
  final DateTime? date;
  final int? state;
  final int? categoryID;
  final Categories? category;

  Transactions({
    this.id,
    this.amount,
    this.title,
    this.description,
    this.date,
    this.state,
    this.categoryID,
    this.category,
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

  Map<String, dynamic> toInsert() {
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

  Map<String, dynamic> toUpdate() {
    return {
      "title": title,
      "category_id": categoryID,
    };
  }
}
