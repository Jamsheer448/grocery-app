class GetUser {
  final String name;
  final String id;
  final String phone;

  GetUser({
    required this.name,
    required this.id,
    required this.phone
  });

  factory GetUser.fromJson(Map<String, dynamic> json) {
    return GetUser(
      id: json['id'], // Assuming 'id' is an integer in the JSON
      name: json['name'] as String,
      phone: json['phonenumber'] as String,
    );
  }
}
