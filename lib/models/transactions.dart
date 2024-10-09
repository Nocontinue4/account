class Transactions {
  int? keyID;
  final String title;
  final String company;
  final String style;
  final DateTime date;

  Transactions({
    this.keyID,
    required this.title,
    required this.company,
    required this.style,
    required this.date,
  });
}
