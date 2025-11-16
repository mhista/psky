// ============================================================================
// NECO SUBJECTS DATA - COMPLETE DATASET
// Similar structure to WAEC but with NECO-specific details
// ============================================================================

import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_data_models/exampaper.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_data_models/subject.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_data_models/syllabus.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_data_models/topic.dart';


class NecoSubjectsData {
  static List<Subject> getAllSubjects() {
    return [
      // Most NECO subjects overlap with WAEC but with different syllabuses
      _englishLanguage(),
      _generalMathematics(),
      _civicEducation(),
      _physics(),
      _chemistry(),
      _biology(),
      _furtherMathematics(),
      _agriculturalScience(),
      _economics(),
      _commerce(),
      _financialAccounting(),
      _geography(),
      _government(),
      _literatureInEnglish(),
      _history(),
      _christianReligiousStudies(),
      _islamicStudies(),
      // Add more subjects as needed
    ];
  }

  static Subject _englishLanguage() {
    return Subject(
      id: 'eng_neco_001',
      name: 'English Language',
      code: '302',
      category: SubjectCategory.compulsory,
      isCompulsory: true,
      availableIn: [ExamBody.neco],
      description: 'NECO English Language examination',
      syllabuses: [
        Syllabus(
          id: 'eng_neco_2025',
          subjectId: 'eng_neco_001',
          examBody: ExamBody.neco,
          year: 2025,
          aims: [
            'Test proficiency in English communication',
            'Evaluate comprehension and expression skills',
            'Assess vocabulary and grammar usage',
          ],
          papers: [
            ExamPaper(
              id: 'eng_neco_paper1',
              name: 'Paper 1',
              type: PaperType.essay,
              duration: '2½ hours',
              totalMarks: 100,
              description: 'Essay, Comprehension, Summary',
            ),
            ExamPaper(
              id: 'eng_neco_paper2',
              name: 'Paper 2',
              type: PaperType.objective,
              duration: '1½ hours',
              totalMarks: 60,
              numberOfQuestions: 60,
              description: 'Objective Test',
            ),
            ExamPaper(
              id: 'eng_neco_paper3',
              name: 'Paper 3',
              type: PaperType.oral,
              duration: '30 minutes',
              totalMarks: 40,
              description: 'Oral English Test',
            ),
          ],
          topics: [
            Topic(
              id: 'eng_neco_topic_001',
              name: 'Comprehension',
              subtopics: ['Reading', 'Analysis', 'Inference'],
              estimatedQuestions: 10,
            ),
            Topic(
              id: 'eng_neco_topic_002',
              name: 'Summary',
              subtopics: ['Identifying main points', 'Paraphrasing'],
              estimatedQuestions: 1,
            ),
            Topic(
              id: 'eng_neco_topic_003',
              name: 'Grammar',
              subtopics: ['Parts of Speech', 'Tenses', 'Clauses'],
              estimatedQuestions: 20,
            ),
            Topic(
              id: 'eng_neco_topic_004',
              name: 'Vocabulary',
              subtopics: ['Synonyms', 'Antonyms', 'Word Formation'],
              estimatedQuestions: 15,
            ),
            Topic(
              id: 'eng_neco_topic_005',
              name: 'Essay Writing',
              subtopics: ['Narrative', 'Descriptive', 'Argumentative'],
              estimatedQuestions: 1,
            ),
          ],
        ),
      ],
    );
  }

  static Subject _generalMathematics() {
    return Subject(
      id: 'math_neco_001',
      name: 'General Mathematics',
      code: '402',
      category: SubjectCategory.compulsory,
      isCompulsory: true,
      availableIn: [ExamBody.neco],
      description: 'NECO Mathematics examination',
      syllabuses: [
        Syllabus(
          id: 'math_neco_2025',
          subjectId: 'math_neco_001',
          examBody: ExamBody.neco,
          year: 2025,
          aims: [
            'Develop mathematical thinking',
            'Apply mathematical concepts',
            'Solve real-world problems',
          ],
          papers: [
            ExamPaper(
              id: 'math_neco_paper1',
              name: 'Paper 1',
              type: PaperType.objective,
              duration: '2 hours',
              totalMarks: 60,
              numberOfQuestions: 60,
              description: 'Objective Questions',
            ),
            ExamPaper(
              id: 'math_neco_paper2',
              name: 'Paper 2',
              type: PaperType.essay,
              duration: '2½ hours',
              totalMarks: 100,
              numberOfQuestions: 13,
              questionsToAnswer: 10,
              description: 'Theory Questions',
            ),
          ],
          topics: [
            Topic(
              id: 'math_neco_topic_001',
              name: 'Number and Numeration',
              subtopics: ['Number bases', 'Fractions', 'Indices', 'Logarithms'],
              estimatedQuestions: 10,
            ),
            // Add more topics similar to WAEC
          ],
        ),
      ],
    );
  }

  // Add similar methods for other subjects (_civicEducation, _physics, etc.)
  // Following the same pattern as WAEC but with NECO-specific details

  static Subject _civicEducation() {
    return Subject(
      id: 'civic_neco_001',
      name: 'Civic Education',
      code: '216',
      category: SubjectCategory.compulsory,
      isCompulsory: true,
      availableIn: [ExamBody.neco],
      syllabuses: [
        Syllabus(
          id: 'civic_neco_2025',
          subjectId: 'civic_neco_001',
          examBody: ExamBody.neco,
          year: 2025,
          topics: [
            Topic(
              id: 'civic_neco_topic_001',
              name: 'Democracy',
              subtopics: ['Principles', 'Features', 'Types'],
              estimatedQuestions: 5,
            ),
          ],
        ),
      ],
    );
  }

  // Simplified stubs for other subjects - expand as needed
  static Subject _physics() => _createSubject('Physics', '512', SubjectCategory.science);
  static Subject _chemistry() => _createSubject('Chemistry', '505', SubjectCategory.science);
  static Subject _biology() => _createSubject('Biology', '504', SubjectCategory.science);
  static Subject _furtherMathematics() => _createSubject('Further Mathematics', '401', SubjectCategory.science);
  static Subject _agriculturalScience() => _createSubject('Agricultural Science', '502', SubjectCategory.science);
  static Subject _economics() => _createSubject('Economics', '203', SubjectCategory.commercial);
  static Subject _commerce() => _createSubject('Commerce', '103', SubjectCategory.commercial);
  static Subject _financialAccounting() => _createSubject('Financial Accounting', '104', SubjectCategory.commercial);
  static Subject _geography() => _createSubject('Geography', '204', SubjectCategory.commercial);
  static Subject _government() => _createSubject('Government', '205', SubjectCategory.arts);
  static Subject _literatureInEnglish() => _createSubject('Literature in English', '210', SubjectCategory.arts);
  static Subject _history() => _createSubject('History', '207', SubjectCategory.arts);
  static Subject _christianReligiousStudies() => _createSubject('Christian Religious Studies', '202', SubjectCategory.arts);
  static Subject _islamicStudies() => _createSubject('Islamic Studies', '208', SubjectCategory.arts);

  static Subject _createSubject(String name, String code, SubjectCategory category) {
    return Subject(
      id: '${code}_neco',
      name: name,
      code: code,
      category: category,
      availableIn: [ExamBody.neco],
      syllabuses: [
        Syllabus(
          id: '${code}_neco_2025',
          subjectId: '${code}_neco',
          examBody: ExamBody.neco,
          year: 2025,
          topics: [],
        ),
      ],
    );
  }
}
