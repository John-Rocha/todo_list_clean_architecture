class UserModel {
  final String id;
  final String name;
  final String email;
  final String? imageUrl;
  final bool isActivated;
  DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.imageUrl,
    this.isActivated = true,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? imageUrl,
    bool? isActivated,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      isActivated: isActivated ?? this.isActivated,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      imageUrl: map['photoUrl'],
      isActivated: map['isActivated'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': imageUrl,
      'isActivated': isActivated,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
