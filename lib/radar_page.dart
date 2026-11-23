import 'package:flutter/material.dart';

const kNavy = Color(0xFF1F2A52);
const kNavy2 = Color(0xFF3F4BAA);
const kGrey = Color(0xFF7A8099);

class RadarUser {
  final String name;
  final String skills;
  final int match;
  final int km;
  final Color color; // warna border avatar
  final Color light; // warna isi avatar
  final Offset pos; // posisi relatif terhadap pusat radar (-1..1)

  const RadarUser({
    required this.name,
    required this.skills,
    required this.match,
    required this.km,
    required this.color,
    required this.light,
    required this.pos,
  });
}

const users = [
  RadarUser(
    name: 'Phillip Graves',
    skills: 'HTML, CSS',
    match: 90,
    km: 1,
    color: Color(0xFF1B5BDB),
    light: Color(0xFF9DB4FF),
    pos: Offset(0.73, 0.73),
  ),
  RadarUser(
    name: 'Kate Laswell',
    skills: 'HTML, CSS, Java Script',
    match: 100,
    km: 3,
    color: Color(0xFFFFB3B3),
    light: Color(0xFFFF1111),
    pos: Offset(0.50, -0.51),
  ),
];

// Avatar tambahan yang hanya tampil di radar
const extraDots = [
  _Dot(Color(0xFFB8B060), Color(0xFFFFD60A), Offset(-0.70, -0.21)),
  _Dot(Color(0xFF00A82D), Color(0xFF7CFF9B), Offset(0.05, 0.44)),
];

class _Dot {
  final Color border, fill;
  final Offset pos;
  const _Dot(this.border, this.fill, this.pos);
}

class RadarPage extends StatefulWidget {
  const RadarPage({super.key});

  @override
  State<RadarPage> createState() => _RadarPageState();
}

class _RadarPageState extends State<RadarPage> {
  bool radarMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEAEDA8), Color(0xFFE6E6E6), Color(0xFF8E9EEB)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 24),
              const Text(
                'BRUDY',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  color: kNavy,
                ),
              ),
              const SizedBox(height: 16),
              _buildToggle(),
              const SizedBox(height: 16),
              Expanded(child: _buildRadarCard()),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildToggle() {
    Widget item(String text, bool selected, VoidCallback onTap) {
      return Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 46,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected ? kNavy : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : kNavy,
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade500),
      ),
      child: Row(
        children: [
          item(
            'Cari Teman',
            !radarMode,
            () => setState(() => radarMode = false),
          ),
          item(
            'Dengan Radar',
            radarMode,
            () => setState(() => radarMode = true),
          ),
        ],
      ),
    );
  }

  Widget _buildRadarCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
        border: Border.all(color: Colors.grey.shade400),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF8F8F6), Color(0xFFE3E7F8)],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 120),
        children: [
          const RadarView(),
          const SizedBox(height: 16),
          for (final u in users) UserTile(user: u),
        ],
      ),
    );
  }

  Widget _buildFab() {
    return Container(
      width: 84,
      height: 84,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFA9B8F0),
      ),
      padding: const EdgeInsets.all(7),
      child: FloatingActionButton(
        elevation: 0,
        backgroundColor: kNavy,
        shape: const CircleBorder(),
        onPressed: () {},
        child: const Icon(
          Icons.add_comment_outlined,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      height: 90,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        gradient: LinearGradient(colors: [kNavy, kNavy2]),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              // Navigator.push(context,
              //   MaterialPageRoute(builder: (_) => const DashboardChat()));
            },
            icon: const Icon(
              Icons.chat_bubble_outline,
              color: Colors.white,
              size: 38,
            ),
          ),
          const SizedBox(width: 80), // ruang untuk FAB
          IconButton(
            onPressed: () {
              // Navigator.push(context,
              //   MaterialPageRoute(builder: (_) => const ProfilDiri()));
            },
            icon: const Icon(
              Icons.account_circle_outlined,
              color: Colors.white,
              size: 42,
            ),
          ),
        ],
      ),
    );
  }
}

/// ===== RADAR =====
class RadarView extends StatelessWidget {
  const RadarView({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(
        builder: (context, c) {
          final size = c.maxWidth;
          final center = size / 2;
          final radius = center * 0.95; // radius lingkaran terluar
          final avatar = size * 0.16;

          Widget place(Offset rel, Widget child) {
            return Positioned(
              left: center + rel.dx * radius - avatar / 2,
              top: center + rel.dy * radius - avatar / 2,
              child: SizedBox(width: avatar, height: avatar, child: child),
            );
          }

          return Stack(
            children: [
              Positioned.fill(child: CustomPaint(painter: RadarPainter())),
              for (final d in extraDots)
                place(d.pos, AvatarCircle(border: d.border, fill: d.fill)),
              for (final u in users)
                place(u.pos, AvatarCircle(border: u.color, fill: u.light)),
              // Pusat (kamu)
              Positioned(
                left: center - avatar * 0.6,
                top: center - avatar * 0.6,
                child: Container(
                  width: avatar * 1.2,
                  height: avatar * 1.2,
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFA9B8F0),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [kNavy, kNavy2],
                      ),
                    ),
                    child: const Icon(
                      Icons.groups_2_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class RadarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = kNavy
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    final center = size.center(Offset.zero);
    final r = size.width / 2 * 0.95;
    for (final f in [1.0, 0.73, 0.44]) {
      canvas.drawCircle(center, r * f, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class AvatarCircle extends StatelessWidget {
  final Color border;
  final Color fill;
  final double? size;
  const AvatarCircle({
    super.key,
    required this.border,
    required this.fill,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(shape: BoxShape.circle, color: border),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [fill, Colors.white.withOpacity(0.6)],
          ),
        ),
        child: const Icon(Icons.person_outline, color: Colors.white, size: 26),
      ),
    );
  }
}

/// ===== KARTU USER =====
class UserTile extends StatelessWidget {
  final RadarUser user;
  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade500),
      ),
      child: Row(
        children: [
          AvatarCircle(border: user.color, fill: user.light, size: 56),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: kNavy,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  user.skills,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kGrey,
                  ),
                ),
                Text(
                  'Kecocokan : ${user.match}%',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kGrey,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              '${user.km} KM',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: kNavy,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
