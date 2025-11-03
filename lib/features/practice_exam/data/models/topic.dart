// ============================================================================
// TOPIC MODEL
// ============================================================================

class Topic {
  final String id;
  final String name;
  final String description;
  final List<String> subtopics;
  final int estimatedQuestions; // Estimated number of questions from this topic

  Topic({
    required this.id,
    required this.name,
    this.description = '',
    this.subtopics = const [],
    this.estimatedQuestions = 0,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'subtopics': subtopics,
      'estimatedQuestions': estimatedQuestions,
    };
  }

  // Create from JSON
  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      subtopics: (json['subtopics'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      estimatedQuestions: json['estimatedQuestions'] as int? ?? 0,
    );
  }

  Topic copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? subtopics,
    int? estimatedQuestions,
  }) {
    return Topic(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      subtopics: subtopics ?? this.subtopics,
      estimatedQuestions: estimatedQuestions ?? this.estimatedQuestions,
    );
  }
}
