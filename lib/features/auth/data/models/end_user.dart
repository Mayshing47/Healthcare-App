class EndUser {
  String id;
  final String name;
  final String email;
  final DateTime createdAt;

  EndUser({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  factory EndUser.fromJson(Map<String, dynamic> data, String id) {
    return EndUser(
      id: id,
      name: data['name'],
      email: data['email'],
      createdAt: DateTime.parse(data['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
