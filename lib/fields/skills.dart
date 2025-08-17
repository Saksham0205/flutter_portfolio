import 'package:flutter/material.dart';
import '../data/resume_data.dart';
import '../widgets.dart';


class SkillsSection extends StatelessWidget {
  const SkillsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        H2('Skills'),
        const SizedBox(height: 16),
        _SkillGroup(title: 'Languages', items: SakshamData.skillsLanguages),
        const SizedBox(height: 10),
        _SkillGroup(title: 'Backend', items: SakshamData.skillsBackend),
        const SizedBox(height: 10),
        _SkillGroup(title: 'Frameworks', items: SakshamData.skillsFrameworks),
        const SizedBox(height: 10),
        _SkillGroup(title: 'Concepts', items: SakshamData.skillsConcepts),
        const SizedBox(height: 10),
        _SkillGroup(title: 'Tools', items: SakshamData.skillsTools),
      ],
    );
  }
}

class _SkillGroup extends StatelessWidget {
  final String title;
  final List<String> items;
  const _SkillGroup({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((e) => Chip3D(e)).toList(),
        ),
      ],
    );
  }
}

