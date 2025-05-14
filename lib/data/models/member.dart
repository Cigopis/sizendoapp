class Member {
  final String nama;
  final String email;
  final String paket;

  Member({
    required this.nama,
    required this.email,
    required this.paket,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      nama: json['nama_member'] ?? '', 
      email: json['email'] ?? '',
      paket: json['paket'] ?? '',
    );
  }
  
}

