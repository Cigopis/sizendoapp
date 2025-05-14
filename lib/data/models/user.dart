class User {
  final String nama;
  final String email;

  User({required this.nama, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nama: json['nama_member'],
      email: json['email'],
    );
  }
}
