import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets.dart';


class ProjectsSection extends StatelessWidget {
  const ProjectsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        H2('Projects'),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 800;
            if (isWide) {
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: const [
                  _ProjectCard(
                    title: 'Ajnabee Partner',
                    tech: 'Flutter • Firebase • REST',
                    bullets: [
                      'Secure payment integration; ops efficiency +40%.',
                      'Bloc/Provider state mgmt; scalable, maintainable.',
                      'RESTful backend for reliable data handling.',
                    ],
                  ),
                  _ProjectCard(
                    title: 'Reswipe',
                    tech: 'Flutter • Firebase • ML',
                    bullets: [
                      'Job‑matching app with real‑time features (+50% engagement).',
                      'Resume parsing + swipe UX; scalable architecture.',
                      'Solved growth‑driven scaling challenges.',
                    ],
                  ),
                ],
              );
            } else {
              return Column(
                children: const [
                  _ProjectCard(
                    title: 'Ajnabee Partner',
                    tech: 'Flutter • Firebase • REST',
                    bullets: [
                      'Secure payment integration; ops efficiency +40%.',
                      'Bloc/Provider state mgmt; scalable, maintainable.',
                      'RESTful backend for reliable data handling.',
                    ],
                  ),
                  SizedBox(height: 16),
                  _ProjectCard(
                    title: 'Reswipe',
                    tech: 'Flutter • Firebase • ML',
                    bullets: [
                      'Job‑matching app with real‑time features (+50% engagement).',
                      'Resume parsing + swipe UX; scalable architecture.',
                      'Solved growth‑driven scaling challenges.',
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final String title;
  final String tech;
  final List<String> bullets;
  const _ProjectCard({
    required this.title,
    required this.tech,
    required this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth > 800
            ? 380.0
            : constraints.maxWidth - 32;
        return SizedBox(
          width: cardWidth,
          child: const TiltCard(child: _ProjectCardInner())
              .animate()
              .fadeIn(duration: 500.ms)
              .moveY(begin: 12, end: 0, curve: Curves.easeOutCubic),
        );
      },
    );
  }
}

class _ProjectCardInner extends StatelessWidget {
  const _ProjectCardInner();
  @override
  Widget build(BuildContext context) {
    final card = context.findAncestorWidgetOfExactType<_ProjectCard>();
    final isMobile = MediaQuery.of(context).size.width < 768;

    if (card == null) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.all(isMobile ? 14.0 : 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            card.title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: isMobile ? 16 : 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            card.tech,
            style: TextStyle(
              color: Colors.white70,
              fontSize: isMobile ? 12 : 14,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [...card.bullets.map((b) => Bullet(b)).toList()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}