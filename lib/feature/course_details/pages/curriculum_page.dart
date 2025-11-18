import 'package:edunity/feature/course_details/model/course_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CurriculumPage extends StatelessWidget {
  const CurriculumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Course content",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Gap(16),
          ...courseSections
              .map((section) => _buildSectionCard(context, section)),
        ],
      ),
    );
  }

  Widget _buildSectionCard(BuildContext context, CourseSection section) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 228, 239, 254), // soft pink
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(
          section.title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: Text("${section.lessons.length} lessons"),
        childrenPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children:
            section.lessons.map((lesson) => _buildLessonItem(lesson)).toList(),
      ),
    );
  }

  Widget _buildLessonItem(Lesson lesson) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.play_circle_outline, color: Colors.black54),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              lesson.title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            lesson.duration,
            style: const TextStyle(color: Colors.grey),
          ),
          if (lesson.isPreview)
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(left: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Text(
                  "Preview",
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
