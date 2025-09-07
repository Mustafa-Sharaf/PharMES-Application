class RepositoryModel {
  final int id;
  final String name;

  RepositoryModel({required this.id, required this.name});

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      id: json['id'] ??0,
      name: json['repository_name'] ??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'repository_name': name,
    };
  }

  @override
  String toString() => name;
}

