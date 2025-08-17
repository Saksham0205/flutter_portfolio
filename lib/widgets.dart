import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimelineItem extends StatelessWidget {
  final String title;
  final String location;
  final String date;
  final List<String> bullets;
  const TimelineItem({
    required this.title,
    required this.location,
    required this.date,
    required this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      margin: EdgeInsets.symmetric(vertical: isMobile ? 8 : 12),
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
        color: Colors.white.withOpacity(0.03),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.work_outline_rounded,
            color: Colors.white70,
            size: isMobile ? 20 : 24,
          ),
          SizedBox(width: isMobile ? 10 : 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: isMobile ? 16 : 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$location • $date',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: isMobile ? 12 : 14,
                  ),
                ),
                const SizedBox(height: 8),
                ...bullets.map((b) => Bullet(b)).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Bullet extends StatelessWidget {
  final String text;
  const Bullet(this.text);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•  ', style: TextStyle(color: Colors.white60)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 13 : 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Chip3D extends StatefulWidget {
  final String label;
  const Chip3D(this.label);

  @override
  State<Chip3D> createState() => _Chip3DState();
}

class _Chip3DState extends State<Chip3D> {
  double dx = 0, dy = 0;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (e) {
        setState(() {
          dx = (e.localPosition.dx - 50) / 200; // tilt intensity
          dy = (e.localPosition.dy - 16) / 80;
        });
      },
      onExit: (_) => setState(() => dx = dy = 0),
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(dy * -0.4)
          ..rotateY(dx * 0.6),
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [Color(0x152AF598), Color(0x152980F0)],
            ),
            border: Border.all(color: Colors.white12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Text(widget.label, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

class H2 extends StatelessWidget {
  final String text;
  const H2(this.text);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final fontSize = isMobile ? 20.0 : 26.0;
    final lineWidth = isMobile ? 40.0 : 80.0;

    if (isMobile && text.length > 15) {
      // For long titles on mobile, use a column layout
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Container(
            width: lineWidth,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              gradient: const LinearGradient(
                colors: [Color(0xFF7C5CFF), Color(0xFFF792FF)],
              ),
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: lineWidth,
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(99),
            gradient: const LinearGradient(
              colors: [Color(0xFF7C5CFF), Color(0xFFF792FF)],
            ),
          ),
        ),
      ],
    );
  }
}

class TiltCard extends StatefulWidget {
  final double width;
  final double height;
  final Widget child;
  const TiltCard({this.width = 280, this.height = 200, required this.child});

  @override
  State<TiltCard> createState() => _TiltCardState();
}

class _TiltCardState extends State<TiltCard> {
  double dx = 0, dy = 0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (e) {
        final size = Size(widget.width, widget.height);
        setState(() {
          dx = (e.localPosition.dx - size.width / 2) / size.width;
          dy = (e.localPosition.dy - size.height / 2) / size.height;
        });
      },
      onExit: (_) => setState(() => dx = dy = 0),
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001) // perspective
          ..rotateX(dy * -0.45)
          ..rotateY(dx * 0.55),
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0x151E1E2A), Color(0x153B2C50)],
            ),
            border: Border.all(color: Colors.white12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 22,
                offset: Offset(0, 12),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        const Color(
                          0x407C5CFF,
                        ).withOpacity(0.25 + dx.abs() * 0.2),
                        Colors.transparent,
                      ],
                      radius: 1.2,
                      center: Alignment(-dx, -dy),
                    ),
                  ),
                ),
              ),
              Positioned.fill(child: widget.child),
            ],
          ),
        ),
      ),
    );
  }
}