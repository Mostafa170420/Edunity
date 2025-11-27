class Lesson {
  final String title;
  final String duration;
  final bool isPreview;

  Lesson(this.title, this.duration, {this.isPreview = false});
}

class CourseSection {
  final String title;
  final List<Lesson> lessons;

  CourseSection(this.title, this.lessons);
}

final List<CourseSection> courseSections = [
  CourseSection("Introduction to Calculus", [
    Lesson("What is Calculus?", "15 min", isPreview: true),
    Lesson("Limits and Continuity", "25 min", isPreview: true),
    Lesson("The Derivative Concept", "30 min"),
  ]),
  CourseSection("Differential Calculus", [
    Lesson("Derivatives and Slopes", "20 min"),
    Lesson("Rules of Differentiation", "22 min"),
    Lesson("Chain Rule", "25 min"),
    Lesson("Applications of Derivatives", "30 min"),
  ]),
  CourseSection("Integral Calculus", [
    Lesson("What is Integration?", "18 min"),
    Lesson("Definite Integrals", "24 min"),
    Lesson("Integration by Parts", "26 min"),
    Lesson("Area Under the Curve", "30 min"),
  ]),
];
