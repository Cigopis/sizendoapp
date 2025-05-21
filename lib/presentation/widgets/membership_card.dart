import 'package:flutter/material.dart';
import 'package:sizendoapp/data/models/member.dart';  

class MembershipCard extends StatelessWidget {
  final Member member;

  const MembershipCard({super.key, required this.member});

  Color getColorByPaket(String paket) {
    switch (paket.toLowerCase()) {
      case 'aktivis':
        return Colors.deepOrangeAccent;
      case 'netizen':
        return Colors.amber;
      case 'inisiator':
        return Colors.indigo;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final paketLower = member.paket.toLowerCase();
    if (member.status.toLowerCase() != 'active' ||
        !(paketLower == 'aktivis' || paketLower == 'netizen' || paketLower == 'inisiator')) {
      return const SizedBox.shrink();
    }

    final color = getColorByPaket(member.paket);

    return Positioned(
      top: 185,
      right: 16,
      left: 16,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Membership", style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 4),
                Text(
                  member.paket,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
            Column(
  crossAxisAlignment: CrossAxisAlignment.end,
  children: [
    const Text("Aktif s/d", style: TextStyle(color: Colors.white70)),
    const SizedBox(height: 4),
    Text(member.endDate, style: const TextStyle(color: Colors.white)),
  ],
)

          ],
        ),
      ),
    );
  }
}
