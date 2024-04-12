class MealModel {
  final String? id;
  final String? prodId;
  final String? name;
  final String? quantity;
  final String? totalCalories;
  final String? protein;
  final String? carbohydrate;

  MealModel({
    this.id,
    this.prodId,
    this.name,
    this.quantity,
    this.totalCalories,
    this.protein,
    this.carbohydrate,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) => MealModel(
        id: json["id"].toString(),
        prodId: json["prodId"].toString(),
        name: json["name"].toString(),
        quantity: json["quantity"].toString(),
        totalCalories: json["totalCalories"].toString(),
        protein: json["protein"].toString(),
        carbohydrate: json["carbohydrate"].toString(),
      );
}
