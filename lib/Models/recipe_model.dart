class RecipeModel {
  final String? recipeId;
  final String? name;
  final String? image;
  final List? ingredients;
  final List? description;

  RecipeModel({
    this.recipeId,
    this.name,
    this.image,
    this.ingredients,
    this.description,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        recipeId: json["recipeId"].toString(),
        name: json["name"].toString(),
        image: "assets/images/recipies/${json["image"]}",
        ingredients: json["ingredients"],
        description: json["description"],
      );
}
