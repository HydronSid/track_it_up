class ProductModel {
  final String? id;
  final String? name;
  final String? nutrition;
  final String? foodtype;
  final String? calories;
  final String? protein;
  final String? carbohydrate;
  final String? image;

  ProductModel({
    this.id,
    this.name,
    this.nutrition,
    this.foodtype,
    this.calories,
    this.protein,
    this.carbohydrate,
    this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        nutrition: json["nutrition"] ?? "",
        foodtype: json["foodtype"] ?? "",
        calories: json["calories"] ?? "",
        protein: json["protein"] ?? "",
        carbohydrate: json["carbohydrate"],
        image: "assets/images/${json["image"]}",
      );
}
