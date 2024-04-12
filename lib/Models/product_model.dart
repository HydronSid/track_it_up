class ProductModel {
  final String? id;
  final String? name;
  final String? foodtype;
  final String? calories;
  final String? protein;
  final String? carbohydrate;
  final String? image;
  final String? quantity;
  final String? serving;
  final String? grams;

  ProductModel({
    this.id,
    this.name,
    this.foodtype,
    this.calories,
    this.protein,
    this.carbohydrate,
    this.image,
    this.quantity,
    this.serving,
    this.grams,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json["id"].toString(),
      name: json["name"].toString(),
      foodtype: json["foodtype"].toString(),
      calories: json["calories"].toString(),
      protein: json["protein"].toString(),
      carbohydrate: json["carbohydrate"].toString(),
      serving: json["serving"].toString(),
      grams: json["grams"].toString(),
      image: "assets/images/${json["image"]}",
      quantity: "4");
}
