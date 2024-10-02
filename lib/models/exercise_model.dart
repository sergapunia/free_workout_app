class ExerciseModel {
  late String name;
  late String description;
  late String targetGroup;
  late String complexity;
  ExerciseModel({
    required this.name,
    required this.description,
    required this.targetGroup,
    required this.complexity,
  });

  ExerciseModel.fromJson(Map<String, dynamic> json) {
    name = json["name"] ?? "";
    description = json["description"] ?? "";
    targetGroup = json["targetGroup"] ?? "";
    complexity = json["complexity"] ?? "";
  }

  Map<String, String> toJson() {
    Map<String, String> data = {};
    data["name"] = name;
    data["description"] = description;
    data["targetGroup"] = targetGroup;
    data["complexity"] = complexity;
    return data;
  }
}
