import 'package:flutter/material.dart';
import '../data/resume_data.dart';
import '../widgets.dart';

class AchievementsSection extends StatelessWidget {
  const AchievementsSection();

  @override
  Widget build(BuildContext context) {
    final chips = SakshamData.achievements.map((e) => Chip3D(e)).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        H2('Achievements'),
        const SizedBox(height: 12),
        Wrap(spacing: 8, runSpacing: 8, children: chips),
      ],
    );
  }
}