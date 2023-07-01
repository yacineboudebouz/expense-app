class Expense {
  final int id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;
  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });
  Map<String, dynamic> toMap() => {
        'title': title,
        'amount': amount,
        'date': date,
        'category': category,
      };
  factory Expense.fromString(Map<String, dynamic> value) => Expense(
      id: value['id'],
      title: value['title'],
      amount: double.parse(value['amount']),
      date: DateTime.parse(value['date']),
      category: value['category']);
}
