class UserModel {
  final String? id;
  final String? name;
  final String? height;
  final String? weight;

  UserModel({
    this.id,
    this.name,
    this.height,
    this.weight,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"].toString(),
        name: json["name"].toString(),
        height: json["height"].toString(),
        weight: json["weight"].toString(),
      );
}
