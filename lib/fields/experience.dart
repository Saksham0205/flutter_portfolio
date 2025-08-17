import 'package:flutter/material.dart';
import '../widgets.dart';


class ExperienceSection extends StatelessWidget {
  const ExperienceSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        H2('Experience'),
        const SizedBox(height: 16),
        TimelineItem(
          title: 'SDE Intern — Spyne',
          location: 'Gurgaon, India',
          date: 'May 2025 – Present',
          bullets: const [
            'Built reseller‑level dashboards with Metabase, TypeScript & REST APIs + LLM integrations for analytics.',
            'Tools & ops to scale AI‑driven automotive retail across US/EU markets.',
          ],
        ),
        TimelineItem(
          title: 'Founder — Ajnabee',
          location: 'New Delhi, India',
          date: 'Jan 2024 – Present',
          bullets: const [
            'Shipped a scalable Flutter app (Bloc/Provider) with Firebase; high‑quality, maintainable codebase.',
            'Integrated secure UPI payments (REST) reducing transaction risks by ~30%.',
            'Led a 10‑member team; deployed for a 330M+ potential user base.',
          ],
        ),
      ],
    );
  }
}

