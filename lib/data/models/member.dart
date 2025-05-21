class Member {
  final String id;
  final String orderId;
  final String nama;
  final String email;
  final String paket;
  final String total;
  final String noWa;
  final String sosmed;
  final String catatan;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String isActive;
  final String startDate;
  final String endDate;

  Member ({
    required this.id,
    required this.orderId,
    required this.nama,
    required this.email,
    required this.paket,
    required this.total,
    required this.noWa,
    required this.sosmed,
    required this.catatan,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.startDate,
    required this.endDate,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    print('Parsing Member JSON: $json');
  return Member(
      id: json['id']?.toString() ?? '',
      orderId: json['order_id']?.toString() ?? '',
      nama: json['nama_member']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      paket: json['paket']?.toString() ?? '',
      total: json['total']?.toString() ?? '',
      noWa: json['no_wa']?.toString() ?? '',
      sosmed: json['sosmed']?.toString() ?? '',
      catatan: json['catatan']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
      isActive: json['is_active']?.toString() ?? '',
      startDate: json['start_date']?.toString() ?? '',
      endDate: json['end_date']?.toString() ?? '',
    );
  }
}
