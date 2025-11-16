
// ============================================================================
// JAMB SUBJECTS DATA - COMPLETE DATASET
// JAMB uses UTME format with different structure
// ============================================================================

import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_data_models/exampaper.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_data_models/subject.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_data_models/syllabus.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exam_data_models/topic.dart';

class JambSubjectsData {
  static List<Subject> getAllSubjects() {
    return [
      // JAMB subjects grouped by course requirements
      _useOfEnglish(),
      _mathematics(),
      _physics(),
      _chemistry(),
      _biology(),
      _economics(),
      _commerce(),
      _accounting(),
      _geography(),
      _government(),
      _literatureInEnglish(),
      _christianReligiousStudies(),
      _islamicStudies(),
      _history(),
      // Add more JAMB subjects
    ];
  }

  static Subject _useOfEnglish() {
    return Subject(
      id: 'eng_jamb_001',
      name: 'Use of English',
      code: 'ENG',
      category: SubjectCategory.compulsory,
      isCompulsory: true,
      availableIn: [ExamBody.jamb],
      description: 'JAMB Use of English (Compulsory for all candidates)',
      syllabuses: [
        Syllabus(
          id: 'eng_jamb_2025',
          subjectId: 'eng_jamb_001',
          examBody: ExamBody.jamb,
          year: 2025,
          aims: [
            'Test proficiency in English',
            'Evaluate comprehension skills',
            'Assess language usage',
          ],
          papers: [
            ExamPaper(
              id: 'eng_jamb_paper1',
              name: 'Use of English',
              type: PaperType.objective,
              duration: '2 hours',
              totalMarks: 100,
              numberOfQuestions: 60,
              questionsToAnswer: 60,
              description: 'UTME Objective Test',
            ),
          ],
          topics: [
            Topic(
              id: 'eng_jamb_topic_001',
              name: 'Comprehension',
              subtopics: ['Passage interpretation', 'Inference'],
              estimatedQuestions: 15,
            ),
            Topic(
              id: 'eng_jamb_topic_002',
              name: 'Lexis and Structure',
              subtopics: ['Grammar', 'Vocabulary', 'Sentence completion'],
              estimatedQuestions: 25,
            ),
            Topic(
              id: 'eng_jamb_topic_003',
              name: 'Oral Forms',
              subtopics: ['Stress', 'Intonation', 'Sounds'],
              estimatedQuestions: 10,
            ),
            Topic(
              id: 'eng_jamb_topic_004',
              name: 'Summary and Continuous Writing',
              subtopics: ['Summary skills', 'Essay writing'],
              estimatedQuestions: 10,
            ),
          ],
        ),
      ],
    );
  }

  static Subject _mathematics() {
    return Subject(
      id: 'math_jamb_001',
      name: 'Mathematics',
      code: 'MTH',
      category: SubjectCategory.compulsory,
      isCompulsory: true,
      availableIn: [ExamBody.jamb],
      description: 'JAMB Mathematics (Compulsory for science/engineering courses)',
      syllabuses: [
        Syllabus(
          id: 'math_jamb_2025',
          subjectId: 'math_jamb_001',
          examBody: ExamBody.jamb,
          year: 2025,
          papers: [
            ExamPaper(
              id: 'math_jamb_paper1',
              name: 'Mathematics',
              type: PaperType.objective,
              duration: '2 hours',
              totalMarks: 100,
              numberOfQuestions: 50,
              questionsToAnswer: 50,
              description: 'UTME Objective Test',
            ),
          ],
          topics: [
            Topic(
              id: 'math_jamb_topic_001',
              name: 'Number and Numeration',
              subtopics: ['Number bases', 'Fractions', 'Indices'],
              estimatedQuestions: 8,
            ),
            Topic(
              id: 'math_jamb_topic_002',
              name: 'Algebraic Processes',
              subtopics: ['Equations', 'Inequalities', 'Functions'],
              estimatedQuestions: 10,
            ),
            // Add more topics
          ],
        ),
      ],
    );
  }

  // Simplified stubs for other subjects
  static Subject _physics() => _createSubject('Physics', 'PHY', SubjectCategory.science);
  static Subject _chemistry() => _createSubject('Chemistry', 'CHM', SubjectCategory.science);
  static Subject _biology() => _createSubject('Biology', 'BIO', SubjectCategory.science);
  static Subject _economics() => _createSubject('Economics', 'ECO', SubjectCategory.commercial);
  static Subject _commerce() => _createSubject('Commerce', 'COM', SubjectCategory.commercial);
  static Subject _accounting() => _createSubject('Accounting', 'ACC', SubjectCategory.commercial);
  static Subject _geography() => _createSubject('Geography', 'GEO', SubjectCategory.commercial);
  static Subject _government() => _createSubject('Government', 'GOV', SubjectCategory.arts);
  static Subject _literatureInEnglish() => _createSubject('Literature in English', 'LIT', SubjectCategory.arts);
  static Subject _christianReligiousStudies() => _createSubject('Christian Religious Studies', 'CRS', SubjectCategory.arts);
  static Subject _islamicStudies() => _createSubject('Islamic Studies', 'IRS', SubjectCategory.arts);
  static Subject _history() => _createSubject('History', 'HIS', SubjectCategory.arts);

  static Subject _createSubject(String name, String code, SubjectCategory category) {
    return Subject(
      id: '${code}_jamb',
      name: name,
      code: code,
      category: category,
      availableIn: [ExamBody.jamb],
      syllabuses: [
        Syllabus(
          id: '${code}_jamb_2025',
          subjectId: '${code}_jamb',
          examBody: ExamBody.jamb,
          year: 2025,
          topics: [],
        ),
      ],
    );
  }
}