class Ingredient {
  final String? item;
  final String? unit;
  final String? type;
  // Amount could be double as well but String is enough here
  final String? amount;

  Ingredient({
    this.item,
    this.unit,
    this.type,
    this.amount,
  });

  // Convert ingredient with item, unit, amount and type to JSON
  Map<String, dynamic> toJson() => {
        'item': item,
        'unit': unit,
        'type': type,
        'amount': amount,
      };

  // Create Ingredient from the ingredient JSON
  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      item: json['item'] as String?,
      unit: json['unit'] as String?,
      type: json['type'] as String?,
      amount: json['amount'] as String?,
    );
  }
}
