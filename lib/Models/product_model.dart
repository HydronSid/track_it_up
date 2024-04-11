class ProductModel {
  final String? id;
  final String? name;
  final String? fats;
  final String? foodtype;
  final String? calories;
  final String? protein;
  final String? carbohydrate;
  final String? image;
  final String? quantity;

  ProductModel({
    this.id,
    this.name,
    this.fats,
    this.foodtype,
    this.calories,
    this.protein,
    this.carbohydrate,
    this.image,
    this.quantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json["id"].toString(),
      name: json["name"].toString(),
      fats: json["fats"].toString(),
      foodtype: json["foodtype"].toString(),
      calories: json["calories"].toString(),
      protein: json["protein"].toString(),
      carbohydrate: json["carbohydrate"].toString(),
      image: "assets/images/${json["image"]}",
      quantity: "4");
}
