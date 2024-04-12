class UserModel {
  final String? id;
  final String? name;
  final String? height;
  final String? weight;
  final String? requiredCal;
  final String? requiredProtein;
  final String? requiredCarbs;

  UserModel({
    this.id,
    this.name,
    this.height,
    this.weight,
    this.requiredCal,
    this.requiredProtein,
    this.requiredCarbs,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"].toString(),
        name: json["name"].toString(),
        height: json["height"].toString(),
        weight: json["weight"].toString(),
        requiredCal: json["requiredCal"].toString(),
        requiredProtein: json["requiredProtein"].toString(),
        requiredCarbs: json["requiredCarbs"].toString(),
      );
}
