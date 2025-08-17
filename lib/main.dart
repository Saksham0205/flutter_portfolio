import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saksham_portfolio/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'data/resume_data.dart';
import 'fields/achievements.dart';
import 'fields/experience.dart';
import 'fields/leadership.dart';
import 'fields/projects.dart';
import 'fields/skills.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTextTheme = GoogleFonts.interTextTheme();
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF7C5CFF),
      brightness: Brightness.dark,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Saksham | Portfolio',
      theme: ThemeData(
        colorScheme: colorScheme,
        textTheme: baseTextTheme,
        scaffoldBackgroundColor: const Color(0xFF0C0D10),
        useMaterial3: true,
      ),
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _expKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _achievementsKey = GlobalKey();
  final _leadershipKey = GlobalKey();
  final _contactKey = GlobalKey();

  late final AnimationController _bgController;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _bgController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.25),
            border: const Border(bottom: BorderSide(color: Colors.white10)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                const SizedBox(width: 16),
                const _Brand(),
                const Spacer(),
                if (isMobile)
                  Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  )
                else ...[
                  _NavButton('About', () => _scrollTo(_aboutKey)),
                  _NavButton('Skills', () => _scrollTo(_skillsKey)),
                  _NavButton('Experience', () => _scrollTo(_expKey)),
                  _NavButton('Projects', () => _scrollTo(_projectsKey)),
                  _NavButton('Achievements', () => _scrollTo(_achievementsKey)),
                  _NavButton('Leadership', () => _scrollTo(_leadershipKey)),
                 // _NavButton('Contact', () => _scrollTo(_contactKey)),
                ],
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ),
      drawer: isMobile
          ? _MobileDrawer(
              onAbout: () => _scrollTo(_aboutKey),
              onSkills: () => _scrollTo(_skillsKey),
              onExperience: () => _scrollTo(_expKey),
              onProjects: () => _scrollTo(_projectsKey),
              onAchievements: () => _scrollTo(_achievementsKey),
              onLeadership: () => _scrollTo(_leadershipKey),
              onContact: () => _scrollTo(_contactKey),
            )
          : null,
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _bgController,
            builder: (_, __) => const _ParticleField(),
          ),
          ListView(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 12 : 16,
              vertical: isMobile ? 16 : 24,
            ),
            children: [
              _Section(
                key: _aboutKey,
                child: const _HeroSection().animate().fadeIn(duration: 600.ms),
              ),
              _Section(key: _skillsKey, child: const SkillsSection()),
              _Section(key: _expKey, child: const ExperienceSection()),
              _Section(key: _projectsKey, child: const ProjectsSection()),
              _Section(
                key: _achievementsKey,
                child: const AchievementsSection(),
              ),
              _Section(key: _leadershipKey, child: const LeadershipSection()),
              const SizedBox(height: 48),
              const Center(
                child: Text(
                  '© ${SakshamData.name} — Built with Flutter',
                  style: TextStyle(color: Colors.white54),
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ],
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 8),
        Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(0.2)
            ..rotateX(-0.1),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [Color(0xFF7C5CFF), Color(0xFFF792FF)],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x807C5CFF),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: const Icon(Icons.bolt, color: Colors.white),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Saksham',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _NavButton(this.label, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(foregroundColor: Colors.white),
        child: Text(label),
      ),
    );
  }
}

class _MobileDrawer extends StatelessWidget {
  final VoidCallback onAbout;
  final VoidCallback onSkills;
  final VoidCallback onExperience;
  final VoidCallback onProjects;
  final VoidCallback onAchievements;
  final VoidCallback onLeadership;
  final VoidCallback onContact;

  const _MobileDrawer({
    required this.onAbout,
    required this.onSkills,
    required this.onExperience,
    required this.onProjects,
    required this.onAchievements,
    required this.onLeadership,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0C0D10),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            const _Brand(),
            const SizedBox(height: 32),
            Expanded(
              child: ListView(
                children: [
                  _DrawerItem('About', Icons.person_outline, onAbout),
                  _DrawerItem('Skills', Icons.code, onSkills),
                  _DrawerItem('Experience', Icons.work_outline, onExperience),
                  _DrawerItem('Projects', Icons.folder_open, onProjects),
                  _DrawerItem(
                    'Achievements',
                    Icons.emoji_events_outlined,
                    onAchievements,
                  ),
                  _DrawerItem(
                    'Leadership',
                    Icons.groups_outlined,
                    onLeadership,
                  ),
                  // _DrawerItem('Contact', Icons.mail_outline, onContact),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '© Saksham — Built with Flutter',
                style: TextStyle(color: Colors.white54, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _DrawerItem(this.label, this.icon, this.onTap);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      onTap: () {
        Navigator.of(context).pop(); // Close drawer
        onTap();
      },
    );
  }
}

class _Section extends StatelessWidget {
  final Widget child;
  const _Section({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      margin: EdgeInsets.symmetric(vertical: isMobile ? 16 : 24),
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(isMobile ? 16 : 24),
        border: Border.all(color: Colors.white10),
      ),
      child: child,
    );
  }
}

// ------------------ HERO ------------------
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 900;
    final isMobile = screenWidth < 768;
    final avatarSize = isMobile ? 200.0 : 260.0;
    final nameSize = isMobile ? 28.0 : (isWide ? 42.0 : 36.0);
    final subtitleSize = isMobile ? 14.0 : 18.0;

    return Flex(
      direction: isWide ? Axis.horizontal : Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TiltCard(
          width: avatarSize,
          height: avatarSize,
          child: const _Avatar(),
        ),
        SizedBox(width: isWide ? 24 : 0, height: isWide ? 0 : 24),
        if (isWide)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  SakshamData.name,
                  style: GoogleFonts.poppins(
                    fontSize: nameSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'SDE Intern @ Spyne • Flutter/Full‑Stack • Founder, Ajnabee',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: subtitleSize,
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _Pill(
                      icon: Icons.location_pin,
                      label: SakshamData.location,
                    ),
                    _Pill(
                      icon: Icons.mail,
                      label: SakshamData.email,
                      onTap: () => _openUrl('mailto:${SakshamData.email}'),
                    ),

                  ],
                ),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 12,
                  children: [
                    _SocialButton('GitHub', Icons.code, SakshamData.github),
                    _SocialButton(
                      'LinkedIn',
                      Icons.business_center,
                      SakshamData.linkedin,
                    ),
                    _SocialButton('X', Icons.alternate_email, SakshamData.x),
                    _SocialButton(
                      'Medium',
                      Icons.edit_note,
                      SakshamData.medium,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  'I build scalable, secure Flutter apps & dashboards with REST/Firebase, ship clean code, and lead teams to deliver. Currently crafting analytics & tools for AI‑driven automotive retail.',
                  style: const TextStyle(color: Colors.white70, height: 1.5),
                ),
              ],
            ),
          )
        else
          Column(
            crossAxisAlignment: isMobile
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                SakshamData.name,
                style: GoogleFonts.poppins(
                  fontSize: nameSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: isMobile ? TextAlign.center : TextAlign.start,
              ),
              const SizedBox(height: 6),
              Text(
                'SDE Intern @ Spyne • Flutter/Full‑Stack • Founder, Ajnabee',
                style: TextStyle(color: Colors.white70, fontSize: subtitleSize),
                textAlign: isMobile ? TextAlign.center : TextAlign.start,
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _Pill(icon: Icons.location_pin, label: SakshamData.location),
                  _Pill(
                    icon: Icons.mail,
                    label: SakshamData.email,
                    onTap: () => _openUrl('mailto:${SakshamData.email}'),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 12,
                alignment: isMobile
                    ? WrapAlignment.center
                    : WrapAlignment.start,
                children: [
                  _SocialButton('GitHub', Icons.code, SakshamData.github),
                  _SocialButton(
                    'LinkedIn',
                    Icons.business_center,
                    SakshamData.linkedin,
                  ),
                  _SocialButton('X', Icons.alternate_email, SakshamData.x),
                  _SocialButton('Medium', Icons.edit_note, SakshamData.medium),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                'I build scalable, secure Flutter apps & dashboards with REST/Firebase, ship clean code, and lead teams to deliver. Currently crafting analytics & tools for AI‑driven automotive retail.',
                style: const TextStyle(color: Colors.white70, height: 1.5),
                textAlign: isMobile ? TextAlign.center : TextAlign.start,
              ),
            ],
          ),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        children: [
          Image.asset(
            'assets/avatar.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[800],
                child: const Icon(Icons.person, color: Colors.white, size: 48),
              );
            },
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.15)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  const _Pill({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 10 : 14,
          vertical: isMobile ? 8 : 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.06),
          border: Border.all(color: Colors.white10),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: isMobile ? 16 : 18, color: Colors.white70),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.white70,
                fontSize: isMobile ? 12 : 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final String url;
  const _SocialButton(this.label, this.icon, this.url);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return ElevatedButton.icon(
      onPressed: () => _openUrl(url),
      icon: Icon(icon, size: isMobile ? 16 : 18),
      label: Text(label, style: TextStyle(fontSize: isMobile ? 12 : 14)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.08),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 12 : 16,
          vertical: isMobile ? 8 : 12,
        ),
      ),
    );
  }
}

Future<void> _openUrl(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    debugPrint('Could not open $url');
  }
}



// ------------------ Animated Particle Background ------------------
class _ParticleField extends StatefulWidget {
  const _ParticleField();

  @override
  State<_ParticleField> createState() => _ParticleFieldState();
}

class _ParticleFieldState extends State<_ParticleField>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late List<_Particle> particles;
  final _rng = math.Random();

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 16000),
          )
          ..addListener(() => setState(() {}))
          ..repeat();

    particles = List.generate(200, (_) => _spawnParticle());
  }

  _Particle _spawnParticle() {
    // 3D-ish point in space with perspective projection
    return _Particle(
      x: (_rng.nextDouble() - 0.5) * 2.2, // -1.1 to 1.1
      y: (_rng.nextDouble() - 0.5) * 2.2,
      z: _rng.nextDouble() * 1.5 + 0.1, // depth 0.1..1.6
      speed: _rng.nextDouble() * 0.0009 + 0.0002,
      size: _rng.nextDouble() * 2 + 0.5,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ParticlePainter(particles: particles, tick: _controller.value),
      child: const SizedBox.expand(),
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double tick;
  _ParticlePainter({required this.particles, required this.tick});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0x66FFFFFF);
    final center = size.center(Offset.zero);

    for (var p in particles) {
      // Move particle forward in Z; wrap when past camera
      p.z -= p.speed;
      if (p.z < 0.05) {
        p
          ..x = (math.Random().nextDouble() - 0.5) * 2
          ..y = (math.Random().nextDouble() - 0.5) * 2
          ..z = 1.6;
      }

      // Perspective projection
      final fov = 500.0; // fiddle with FOV for depth feel
      final sx = center.dx + (p.x * fov) / p.z;
      final sy = center.dy + (p.y * fov) / p.z;
      final r = (p.size / p.z) * 0.9;

      // Soft glow
      canvas.drawCircle(Offset(sx, sy), r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}

class _Particle {
  double x, y, z, speed, size;
  _Particle({
    required this.x,
    required this.y,
    required this.z,
    required this.speed,
    required this.size,
  });
}



