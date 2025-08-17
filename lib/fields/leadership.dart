import 'package:flutter/material.dart';
import '../widgets.dart';


class LeadershipSection extends StatelessWidget {
  const LeadershipSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        H2('Leadership & Community'),
        const SizedBox(height: 12),
        TimelineItem(
          title: 'Flutter Mentor — GDG MAIT',
          location: 'Delhi',
          date: 'Sep 2024 – Present',
          bullets: const [
            'Guided 150+ developers via workshops; emphasis on secure coding.',
          ],
        ),
        TimelineItem(
          title: 'Coordinator — TechCom (MAIT)',
          location: 'Delhi',
          date: 'Oct 2023 – Present',
          bullets: const [
            'Led ML/blockchain workshops for 200+ students; fostered innovation.',
            'Organized HackWithMAIT 4.0/5.0 with 1000+ participants.',
          ],
        ),
      ],
    );
  }
}


