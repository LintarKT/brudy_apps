import 'package:brudy_apps/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BrudyApp());
}

// ---------- Warna ----------
const kNavy = Color(0xFF1F2F57);
const kNavyDark = Color(0xFF1B2250);
const kIndigo = Color(0xFF3F4DAE);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brudy Apps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kIndigo),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MatchPager(),
    );
  }
}

// ---------- Model data ----------
class MatchProfile {
  final String name;
  final int match;
  final Color ringColor;
  final List<Color> avatarGradient;
  final List<String> concentrations;
  final String learningStyle;

  const MatchProfile({
    required this.name,
    required this.match,
    required this.ringColor,
    required this.avatarGradient,
    required this.concentrations,
    required this.learningStyle,
  });
}

const profiles = [
  MatchProfile(
    name: 'Phillip Graves',
    match: 90,
    ringColor: Color(0xFF1858E0),
    avatarGradient: [Color(0xFF2D5BFF), Color(0xFFB3B9FF)],
    concentrations: ['HTML', 'CSS'],
    learningStyle: '1-on-1',
  ),
  MatchProfile(
    name: 'Kate Laswell',
    match: 100,
    ringColor: Color(0xFFFFB3B3),
    avatarGradient: [Color(0xFFFF0000), Color(0xFFE56B6B)],
    concentrations: ['Java', 'HTML', 'CSS'],
    learningStyle: '1-on-1',
  ),
];

// ---------- Geser kiri/kanan untuk lihat 2 profil ----------
class MatchPager extends StatelessWidget {
  const MatchPager({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [for (final p in profiles) MatchProfilePage(profile: p)],
    );
  }
}

// ---------- Halaman profil ----------
class MatchProfilePage extends StatefulWidget {
  final MatchProfile profile;
  const MatchProfilePage({super.key, required this.profile});

  @override
  State<MatchProfilePage> createState() => _MatchProfilePageState();
}

class _MatchProfilePageState extends State<MatchProfilePage> {
  static const styles = ['1-on-1', 'Study Group', 'Fokus Sunyi', 'WFC'];

  late List<String> concentrations;
  late String selectedStyle;

  @override
  void initState() {
    super.initState();
    concentrations = List.of(widget.profile.concentrations);
    selectedStyle = widget.profile.learningStyle;
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.profile;

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const BottomBar(),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFEAEAB8),
              Color(0xFFF7F7F0),
              Color(0xFFEDEEF9),
              Color(0xFF9DAEF0),
            ],
            stops: [0.0, 0.25, 0.65, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 140),
            child: Column(
              children: [
                // Judul + tombol kembali
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.maybePop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: kNavy,
                        size: 22,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        p.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: kNavy,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // penyeimbang tombol kembali
                  ],
                ),
                const SizedBox(height: 24),

                // Avatar
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: p.ringColor,
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    width: 152,
                    height: 152,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: p.avatarGradient,
                      ),
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      color: Colors.white,
                      size: 80,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Kecocokan : ${p.match}%',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: kNavy,
                  ),
                ),
                const SizedBox(height: 36),

                // Judul bagian
                const Text(
                  'Academic & Learning',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kNavy,
                  ),
                ),
                const SizedBox(height: 8),

                // Kartu
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: kNavy, width: 1.2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _Label('Konsentrasi Belajar'),
                      const SizedBox(height: 8),
                      _PillField(
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            for (final c in concentrations)
                              _Chip(
                                label: c,
                                onRemove: () =>
                                    setState(() => concentrations.remove(c)),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const _Label('Gaya Belajar'),
                      const SizedBox(height: 8),
                      _PillField(
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            for (final s in styles)
                              s == selectedStyle
                                  ? _Chip(
                                      label: s,
                                      onRemove: () =>
                                          setState(() => selectedStyle = ''),
                                    )
                                  : GestureDetector(
                                      onTap: () =>
                                          setState(() => selectedStyle = s),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 8,
                                        ),
                                        child: Text(
                                          s,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: kNavy,
                                          ),
                                        ),
                                      ),
                                    ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Tombol Kirim Pesan
                SizedBox(
                  width: double.infinity,
                  height: 64,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1F2F57), Color(0xFF4A69BD)],
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Pesan ke ${p.name}')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'Kirim Pesan',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------- Komponen kecil ----------
class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.bold,
      color: kNavy,
    ),
  );
}

class _PillField extends StatelessWidget {
  final Widget child;
  const _PillField({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 48),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: kNavy, width: 1.2),
      ),
      child: child,
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;
  const _Chip({required this.label, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 8, top: 7, bottom: 7),
      decoration: BoxDecoration(
        color: kNavy,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close, color: Colors.white, size: 14),
          ),
        ],
      ),
    );
  }
}

// ---------- Bottom bar dengan tombol tengah ----------
class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 90,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [kNavyDark, kIndigo]),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.white,
                    size: 34,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.account_circle_outlined,
                    color: Colors.white,
                    size: 38,
                  ),
                ),
              ],
            ),
          ),
          // Tombol tengah
          Positioned(
            top: 0,
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFAEB8F0),
              ),
              alignment: Alignment.center,
              child: Container(
                width: 66,
                height: 66,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [kNavyDark, kIndigo],
                  ),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add_comment_outlined,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
