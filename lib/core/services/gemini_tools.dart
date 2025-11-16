// ============================================================================
// COACH KAI GEMINI TOOLS - COMPLETE OUTPUT SCHEMAS
// These define the STRUCTURE OF DATA the AI should RETURN, not input params
// Input parameters are described in the system prompt
// ============================================================================
import 'dart:convert';

import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/ai_cubits/cubit/ai_exam_cubit.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';

class GeminiTools {
  // ========================================================================
  // HELPER SCHEMAS FOR REUSABILITY
  // ========================================================================

  Schema _getOptionSchema() {
    return Schema.object(
      description: 'A single option for an objective question.',
      properties: {
        'id': Schema.string(description: 'Option identifier (A, B, C, D)'),
        'text': Schema.string(description: 'Full text of the option'),
      },
    );
  }

  Schema _getMarkingPointSchema() {
    return Schema.object(
      description: 'A single marking criterion for essay/practical questions.',
      properties: {
        'criterion': Schema.string(description: 'What is being marked'),
        'marks':
            Schema.integer(description: 'Maximum marks for this criterion'),
      },
    );
  }

  Schema _getQuestionObjectSchema() {
    return Schema.object(
      description: 'A complete exam question with all details.',
      properties: {
        'questionNumber':
            Schema.integer(description: 'Sequential question number'),
        'questionText': Schema.string(description: 'Full question text'),
        'questionType': Schema.string(
          description: 'Question format',
        ),
        'subject': Schema.string(description: 'Academic subject'),
        'topic': Schema.string(description: 'Specific topic covered'),
        'examBody': Schema.string(
          description: 'Examination body',
        ),
        'difficultyLevel': Schema.string(
          description: 'Question difficulty',
        ),
        'marks': Schema.integer(description: 'Total marks allocated'),
        'timeEstimateMinutes':
            Schema.integer(description: 'Recommended time to answer'),

        // For objective questions
        'options': Schema.array(
          description: 'Multiple choice options',
          items: _getOptionSchema(),
        ),
        'correctAnswer':
            Schema.string(description: 'Correct option ID or short answer'),
        // For essay/practical questions
        'answerText': Schema.string(description: 'Full detailed answer'),
        'markingScheme': Schema.object(
          description: 'Breakdown of marks by criterion',
          properties: {
            'points': Schema.array(items: _getMarkingPointSchema()),
          },
        ),
        'explanation':
            Schema.string(description: 'Detailed solution explanation'),
        'commonMistakes': Schema.array(
          description: 'Common errors students make',
          items: Schema.string(),
        ),
        'syllabusReference':
            Schema.string(description: 'Corresponding syllabus topic'),
        'requiresDiagram':
            Schema.boolean(description: 'Whether diagram is needed'),
        'diagramDescription':
            Schema.string(description: 'Diagram description if required'),
        'pastYearReference':
            Schema.integer(description: 'Past paper year reference'),
      },
    );
  }

  // ========================================================================
  // EXAMINATION QUESTION GENERATION
  // ========================================================================
  FunctionDeclaration get generateExamQuestionsFuncDecl => FunctionDeclaration(
        'generate_exam_questions',
        'Generates exam questions following official WAEC/NECO/JAMB standards. Returns structured array of questions with answers, explanations, and metadata.',
        parameters: {
          'questions': Schema.array(
            description: 'Array of detailed exam question objects',
            items: _getQuestionObjectSchema(),
          ),
          'metadata': Schema.object(
            description: 'Metadata about the generated exam paper',
            properties: {
              'totalQuestions':
                  Schema.integer(description: 'Total count of questions'),
              'currentNumberOfQuestionsGenerated': Schema.integer(
                  description:
                      'Total count of questions currently generated, to help keep track of questions generated'),
              'difficultyDistribution': Schema.object(
                description: 'Count of questions per difficulty level',
                properties: {
                  'easy': Schema.integer(),
                  'medium': Schema.integer(),
                  'hard': Schema.integer(),
                },
              ),
              'topicsCovered': Schema.array(
                description: 'List of all unique topics covered',
                items: Schema.string(),
              ),
              'estimatedDurationMinutes':
                  Schema.integer(description: 'Total estimated exam time'),
              'generatedAt':
                  Schema.string(description: 'Generation timestamp (ISO 8601)'),
            },
          ),
        },
      );

  // ========================================================================
  // PAST QUESTIONS RETRIEVAL
  // ========================================================================
  FunctionDeclaration get fetchPastQuestionsFuncDecl => FunctionDeclaration(
        'fetch_past_questions',
        'Retrieves actual past examination questions. Returns array of questions with metadata.',
        parameters: {
          'questions': Schema.array(
            description: 'Array of past questions',
            items: _getQuestionObjectSchema(),
          ),
          'metadata': Schema.object(
            description: 'Source information',
            properties: {
              'subject': Schema.string(description: 'Subject name'),
              'examBody': Schema.string(description: 'Exam body'),
              'year': Schema.integer(description: 'Year of questions'),
              'paperNumber':
                  Schema.integer(description: 'Paper number if specified'),
              'totalQuestions':
                  Schema.integer(description: 'Total questions retrieved'),
              'includesAnswers':
                  Schema.boolean(description: 'Whether answers included'),
            },
          ),
        },
      );

  // ========================================================================
  // QUESTION VALIDATION
  // ========================================================================
  FunctionDeclaration get validateQuestionStandardsFuncDecl =>
      FunctionDeclaration(
        'validate_question_standards',
        'Validates questions against exam standards. Returns validation results.',
        parameters: {
          'isValid': Schema.boolean(description: 'Overall validation status'),
          'validatedQuestions':
              Schema.integer(description: 'Number of questions validated'),
          'issues': Schema.array(
            description: 'List of validation issues found',
            items: Schema.object(
              properties: {
                'questionNumber':
                    Schema.integer(description: 'Question with issue'),
                'issueType': Schema.string(
                  description: 'Type of issue',
                ),
                'description': Schema.string(description: 'Issue description'),
                'severity': Schema.string(
                  description: 'Issue severity',
                ),
                'suggestion': Schema.string(description: 'Fix suggestion'),
              },
            ),
          ),
          'passedStandards': Schema.array(
            description: 'Standards that were met',
            items: Schema.string(),
          ),
        },
      );

  // ========================================================================
  // SAVE QUESTIONS CONFIRMATION
  // ========================================================================
  FunctionDeclaration get saveGeneratedQuestionsFuncDecl => FunctionDeclaration(
        'save_generated_questions',
        'Saves generated questions to storage. Returns save confirmation.',
        parameters: {
          'success': Schema.boolean(description: 'Whether save succeeded'),
          'examSessionName':
              Schema.string(description: 'Name of saved exam session'),
          'savedCount':
              Schema.integer(description: 'Number of questions saved'),
          'savedToDatabase':
              Schema.boolean(description: 'Saved to remote database'),
          'cachedLocally': Schema.boolean(description: 'Saved to local cache'),
          'cacheExpiryDate':
              Schema.string(description: 'Cache expiry date (ISO 8601)'),
          'sessionId': Schema.string(description: 'Unique session identifier'),
        },
      );

  // ========================================================================
  // PERFORMANCE ANALYSIS
  // ========================================================================
  FunctionDeclaration get analyzeExamPerformanceFuncDecl => FunctionDeclaration(
        'analyze_exam_performance',
        'Analyzes completed exam performance. Returns detailed metrics, breakdown, and recommendations.',
        parameters: {
          'studentName': Schema.string(description: 'Student\'s name'),
          'examSessionName': Schema.string(description: 'Name of exam session'),
          'overallPerformance': Schema.object(
            description: 'Overall exam performance metrics',
            properties: {
              'score': Schema.integer(description: 'Total score achieved'),
              'percentage': Schema.number(description: 'Percentage score'),
              'grade': Schema.string(description: 'Letter grade (A-F)'),
              'totalQuestions':
                  Schema.integer(description: 'Total number of questions'),
              'correctAnswers':
                  Schema.integer(description: 'Number of correct answers'),
              'wrongAnswers':
                  Schema.integer(description: 'Number of wrong answers'),
              'skipped':
                  Schema.integer(description: 'Number of skipped questions'),
              'unanswered':
                  Schema.integer(description: 'Number of unanswered questions'),
              'timeTakenMinutes':
                  Schema.integer(description: 'Total time taken'),
              'averageTimePerQuestion':
                  Schema.number(description: 'Average time per question'),
            },
          ),
          'topicBreakdown': Schema.array(
            description: 'Performance breakdown by topic',
            items: Schema.object(
              properties: {
                'topic': Schema.string(description: 'Topic name'),
                'questionsAttempted':
                    Schema.integer(description: 'Questions attempted'),
                'questionsCorrect':
                    Schema.integer(description: 'Correct answers'),
                'accuracy': Schema.number(description: 'Accuracy percentage'),
                'performanceLevel': Schema.string(
                  description: 'Performance level',
                ),
                'needsImprovement':
                    Schema.boolean(description: 'Whether improvement needed'),
              },
            ),
          ),
          'strengths': Schema.array(
            description: 'List of identified strengths',
            items: Schema.string(),
          ),
          'weaknesses': Schema.array(
            description: 'List of weak areas with recommendations',
            items: Schema.object(
              properties: {
                'topic': Schema.string(description: 'Weak topic name'),
                'accuracy':
                    Schema.number(description: 'Accuracy in this topic'),
                'recommendation': Schema.string(
                    description: 'Specific improvement recommendation'),
              },
            ),
          ),
          'improvementRecommendations': Schema.array(
            description: 'Actionable improvement recommendations',
            items: Schema.string(),
          ),
          'nextSteps': Schema.array(
            description: 'Concrete next steps for student',
            items: Schema.string(),
          ),
          'comparisonWithPrevious': Schema.object(
            description: 'Comparison with previous performance',
            properties: {
              'scoreChange':
                  Schema.integer(description: 'Score change from last attempt'),
              'trend': Schema.string(
                description: 'Performance trend',
              ),
              'consistency': Schema.string(
                description: 'Performance consistency',
              ),
            },
          ),
          'motivationalMessage':
              Schema.string(description: 'Personalized motivational message'),
        },
      );

  // ========================================================================
  // PROGRESS TRACKING
  // ========================================================================
  FunctionDeclaration get trackExamProgressFuncDecl => FunctionDeclaration(
        'track_exam_progress',
        'Tracks real-time exam progress. Returns current progress metrics.',
        parameters: {
          'examSessionName': Schema.string(description: 'Current exam name'),
          'studentName': Schema.string(description: 'Student\'s name'),
          'progressPercentage':
              Schema.number(description: 'Completion percentage'),
          'currentQuestionNumber':
              Schema.integer(description: 'Current question index'),
          'answered': Schema.integer(description: 'Questions answered'),
          'skipped': Schema.integer(description: 'Questions skipped'),
          'unanswered': Schema.integer(description: 'Questions not attempted'),
          'timeElapsedMinutes':
              Schema.integer(description: 'Time spent so far'),
          'estimatedTimeRemaining':
              Schema.integer(description: 'Estimated time remaining'),
          'paceStatus': Schema.string(
            description: 'Pace compared to recommended time',
          ),
        },
      );

  // ========================================================================
  // PERFORMANCE HISTORY
  // ========================================================================
  FunctionDeclaration get retrievePerformanceHistoryFuncDecl =>
      FunctionDeclaration(
        'retrieve_performance_history',
        'Retrieves historical performance data. Returns array of past exam results.',
        parameters: {
          'studentName': Schema.string(description: 'Student\'s name'),
          'exams': Schema.array(
            description: 'List of past exam attempts',
            items: Schema.object(
              properties: {
                'examSessionName': Schema.string(description: 'Exam name'),
                'subject': Schema.string(description: 'Subject name'),
                'examBody': Schema.string(description: 'Exam type'),
                'date': Schema.string(description: 'Exam date (ISO 8601)'),
                'score': Schema.integer(description: 'Score achieved'),
                'percentage': Schema.number(description: 'Percentage score'),
                'grade': Schema.string(description: 'Grade'),
                'topicsAttempted': Schema.array(items: Schema.string()),
              },
            ),
          ),
          'summary': Schema.object(
            description: 'Overall performance summary',
            properties: {
              'totalExamsTaken':
                  Schema.integer(description: 'Total number of exams'),
              'averageScore':
                  Schema.number(description: 'Average percentage score'),
              'overallTrend': Schema.string(
                description: 'Overall performance trend',
              ),
              'strongSubjects': Schema.array(items: Schema.string()),
              'weakSubjects': Schema.array(items: Schema.string()),
              'weakTopics': Schema.array(
                description: 'Consistently weak topics across exams',
                items: Schema.object(
                  properties: {
                    'topic': Schema.string(description: 'Topic name'),
                    'subject': Schema.string(description: 'Subject'),
                    'averageAccuracy':
                        Schema.number(description: 'Average accuracy'),
                    'timesAttempted':
                        Schema.integer(description: 'Times attempted'),
                  },
                ),
              ),
            },
          ),
        },
      );

  // ========================================================================
  // LEARNING PROFILE UPDATE
  // ========================================================================
  FunctionDeclaration get updateLearningProfileFuncDecl => FunctionDeclaration(
        'update_learning_profile',
        'Updates student learning profile. Returns updated profile confirmation.',
        parameters: {
          'studentName': Schema.string(description: 'Student\'s name'),
          'subject': Schema.string(description: 'Subject name'),
          'profileUpdated':
              Schema.boolean(description: 'Whether update succeeded'),
          'updatedFields': Schema.array(
            description: 'Fields that were updated',
            items: Schema.string(),
          ),
          'currentProfile': Schema.object(
            description: 'Current profile state',
            properties: {
              'strongTopics': Schema.array(items: Schema.string()),
              'weakTopics': Schema.array(items: Schema.string()),
              'learningPace': Schema.string(),
              'preferredDifficulty': Schema.string(),
              'recommendedFocus': Schema.array(items: Schema.string()),
            },
          ),
        },
      );

  // ========================================================================
  // TOPIC EXPLANATION
  // ========================================================================
  FunctionDeclaration get provideTopicExplanationFuncDecl =>
      FunctionDeclaration(
        'provide_topic_explanation',
        'Provides comprehensive topic explanation. Returns structured teaching content.',
        parameters: {
          'subject': Schema.string(description: 'Subject name'),
          'topic': Schema.string(description: 'Topic name'),
          'explanation':
              Schema.string(description: 'Detailed explanation text'),
          'keyPoints': Schema.array(
            description: 'Key takeaway points',
            items: Schema.string(),
          ),
          'examples': Schema.array(
            description: 'Practical examples',
            items: Schema.object(
              properties: {
                'exampleText': Schema.string(description: 'Example problem'),
                'solution': Schema.string(description: 'Step-by-step solution'),
                'explanation':
                    Schema.string(description: 'Why this solution works'),
              },
            ),
          ),
          'diagrams': Schema.array(
            description: 'Diagram descriptions',
            items: Schema.object(
              properties: {
                'title': Schema.string(description: 'Diagram title'),
                'description':
                    Schema.string(description: 'What the diagram shows'),
              },
            ),
          ),
          'relatedTopics': Schema.array(
            description: 'Related topics to explore',
            items: Schema.string(),
          ),
          'commonMisconceptions': Schema.array(
            description: 'Common misunderstandings',
            items: Schema.string(),
          ),
        },
      );

  // ========================================================================
  // STUDY NOTES
  // ========================================================================
  FunctionDeclaration get generateStudyNotesFuncDecl => FunctionDeclaration(
        'generate_study_notes',
        'Generates comprehensive study notes. Returns structured notes.',
        parameters: {
          'subject': Schema.string(description: 'Subject name'),
          'title': Schema.string(description: 'Notes title'),
          'topicsCovered': Schema.array(items: Schema.string()),
          'content': Schema.array(
            description: 'Structured note sections',
            items: Schema.object(
              properties: {
                'sectionTitle': Schema.string(description: 'Section heading'),
                'content': Schema.string(description: 'Section content'),
                'keyPoints': Schema.array(items: Schema.string()),
                'formulas': Schema.array(
                  description: 'Important formulas',
                  items: Schema.object(
                    properties: {
                      'formula': Schema.string(description: 'Formula notation'),
                      'description':
                          Schema.string(description: 'What it calculates'),
                      'example': Schema.string(description: 'Usage example'),
                    },
                  ),
                ),
              },
            ),
          ),
          'summary': Schema.string(description: 'Overall summary'),
        },
      );

  // ========================================================================
  // STUDY TIMETABLE
  // ========================================================================
  FunctionDeclaration get createStudyTimetableFuncDecl => FunctionDeclaration(
        'create_study_timetable',
        'Creates personalized study timetable. Returns structured schedule.',
        parameters: {
          'studentName': Schema.string(description: 'Student\'s name'),
          'examDate': Schema.string(description: 'Target exam date'),
          'totalStudyHours':
              Schema.integer(description: 'Total planned study hours'),
          'schedule': Schema.array(
            description: 'Daily schedule breakdown',
            items: Schema.object(
              properties: {
                'date': Schema.string(description: 'Date (YYYY-MM-DD)'),
                'dayOfWeek': Schema.string(description: 'Day name'),
                'sessions': Schema.array(
                  description: 'Study sessions for this day',
                  items: Schema.object(
                    properties: {
                      'startTime':
                          Schema.string(description: 'Session start (HH:MM)'),
                      'endTime':
                          Schema.string(description: 'Session end (HH:MM)'),
                      'subject': Schema.string(description: 'Subject to study'),
                      'topics': Schema.array(items: Schema.string()),
                      'activity':
                          Schema.string(description: 'Type of study activity'),
                      'durationMinutes':
                          Schema.integer(description: 'Session duration'),
                    },
                  ),
                ),
                'totalStudyHours':
                    Schema.number(description: 'Total hours for this day'),
              },
            ),
          ),
          'subjectDistribution': Schema.object(
            description: 'Time allocated per subject',
            properties: {}, // Dynamic keys
          ),
          'recommendations': Schema.array(
            description: 'Tips for following the timetable',
            items: Schema.string(),
          ),
        },
      );

  // ========================================================================
  // ANSWER STUDENT QUESTION
  // ========================================================================
  FunctionDeclaration get answerStudentQuestionFuncDecl => FunctionDeclaration(
        'answer_student_question',
        'Answers student\'s specific question. Returns detailed answer.',
        parameters: {
          'question': Schema.string(description: 'Original question'),
          'answer': Schema.string(description: 'Detailed answer'),
          'relatedConcepts': Schema.array(
            description: 'Related concepts explained',
            items: Schema.string(),
          ),
          'examples': Schema.array(
            description: 'Illustrative examples',
            items: Schema.string(),
          ),
          'syllabusReferences': Schema.array(
            description: 'Relevant syllabus topics',
            items: Schema.string(),
          ),
          'furtherReading': Schema.array(
            description: 'Suggested topics to explore',
            items: Schema.string(),
          ),
        },
      );

  // ========================================================================
  // EXAM STRATEGIES
  // ========================================================================
  FunctionDeclaration get provideExamStrategiesFuncDecl => FunctionDeclaration(
        'provide_exam_strategies',
        'Provides exam-taking strategies. Returns structured advice.',
        parameters: {
          'examBody': Schema.string(description: 'Exam type'),
          'subject': Schema.string(description: 'Subject (if specified)'),
          'strategies': Schema.array(
            description: 'List of strategies',
            items: Schema.object(
              properties: {
                'category': Schema.string(
                  description: 'Strategy category',
                ),
                'title': Schema.string(description: 'Strategy title'),
                'description':
                    Schema.string(description: 'Detailed explanation'),
                'tips': Schema.array(
                  description: 'Actionable tips',
                  items: Schema.string(),
                ),
                'examples': Schema.array(items: Schema.string()),
              },
            ),
          ),
          'commonMistakes': Schema.array(
            description: 'Common mistakes to avoid',
            items: Schema.string(),
          ),
        },
      );

  // ========================================================================
  // PRACTICE DRILL
  // ========================================================================
  FunctionDeclaration get generatePracticeDrillFuncDecl => FunctionDeclaration(
        'generate_practice_drill',
        'Creates quick practice drill. Returns drill questions.',
        parameters: {
          'drillName': Schema.string(description: 'Drill title'),
          'subject': Schema.string(description: 'Subject name'),
          'topic': Schema.string(description: 'Topic name'),
          'drillType': Schema.string(
            description: 'Drill type',
          ),
          'durationMinutes': Schema.integer(description: 'Time limit'),
          'questions': Schema.array(
            description: 'Drill questions',
            items: _getQuestionObjectSchema(),
          ),
          'instructions':
              Schema.string(description: 'How to approach this drill'),
        },
      );

  // ========================================================================
  // MOTIVATION MESSAGE
  // ========================================================================
  FunctionDeclaration get provideMotivationMessageFuncDecl =>
      FunctionDeclaration(
        'provide_motivation_message',
        'Generates motivational message. Returns personalized encouragement.',
        parameters: {
          'studentName': Schema.string(description: 'Student\'s name'),
          'message': Schema.string(description: 'Main motivational message'),
          'context': Schema.string(description: 'Context of motivation'),
          'achievements': Schema.array(
            description: 'Recent achievements to celebrate',
            items: Schema.string(),
          ),
          'encouragement': Schema.array(
            description: 'Specific encouraging points',
            items: Schema.string(),
          ),
          'actionableAdvice': Schema.array(
            description: 'Concrete next steps',
            items: Schema.string(),
          ),
        },
      );

  // ========================================================================
  // SET STUDY GOALS
  // ========================================================================
  FunctionDeclaration get setStudyGoalsFuncDecl => FunctionDeclaration(
        'set_study_goals',
        'Sets study goals for student. Returns goal confirmation.',
        parameters: {
          'studentName': Schema.string(description: 'Student\'s name'),
          'goalName': Schema.string(description: 'Goal title'),
          'goalType': Schema.string(
            description: 'Type of goal',
          ),
          'targetValue': Schema.string(description: 'Goal target'),
          'deadline': Schema.string(description: 'Goal deadline'),
          'milestones': Schema.array(
            description: 'Intermediate milestones',
            items: Schema.object(
              properties: {
                'description':
                    Schema.string(description: 'Milestone description'),
                'dueDate': Schema.string(description: 'Milestone date'),
                'completed': Schema.boolean(description: 'Completion status'),
              },
            ),
          ),
          'trackingMetrics': Schema.array(
            description: 'How to measure progress',
            items: Schema.string(),
          ),
        },
      );

  // ========================================================================
  // TRACK STUDY STREAK
  // ========================================================================
  FunctionDeclaration get trackStudyStreakFuncDecl => FunctionDeclaration(
        'track_study_streak',
        'Tracks study consistency streak. Returns streak information.',
        parameters: {
          'studentName': Schema.string(description: 'Student\'s name'),
          'currentStreak':
              Schema.integer(description: 'Current consecutive days'),
          'longestStreak': Schema.integer(description: 'Longest streak ever'),
          'lastActivityDate': Schema.string(description: 'Last study date'),
          'totalActiveDays': Schema.integer(description: 'Total days studied'),
          'streakStatus': Schema.string(
            description: 'Streak health',
          ),
          'encouragementMessage':
              Schema.string(description: 'Motivational message'),
          'nextMilestone': Schema.object(
            description: 'Next streak milestone',
            properties: {
              'daysToGo': Schema.integer(description: 'Days until milestone'),
              'milestoneName':
                  Schema.string(description: 'Milestone achievement'),
            },
          ),
        },
      );

  // ========================================================================
  // TOOL LIST
  // ========================================================================
  List<Tool> get tools => [
        Tool.functionDeclarations([
          generateExamQuestionsFuncDecl,
          fetchPastQuestionsFuncDecl,
          validateQuestionStandardsFuncDecl,
          saveGeneratedQuestionsFuncDecl,
          analyzeExamPerformanceFuncDecl,
          trackExamProgressFuncDecl,
          retrievePerformanceHistoryFuncDecl,
          updateLearningProfileFuncDecl,
          provideTopicExplanationFuncDecl,
          generateStudyNotesFuncDecl,
          createStudyTimetableFuncDecl,
          answerStudentQuestionFuncDecl,
          provideExamStrategiesFuncDecl,
          generatePracticeDrillFuncDecl,
          provideMotivationMessageFuncDecl,
          setStudyGoalsFuncDecl,
          trackStudyStreakFuncDecl,
        ]),
      ];

  // ========================================================================
  // FUNCTION HANDLERS
  // ========================================================================
  Future<Map<String, Object?>> handleFunctionCall(
    String functionName,
    Map<String, Object?> arguments,
  ) async {
    debugPrint('Coach Kai Function Call: $functionName');
    debugPrint('Arguments: $arguments');
    return await switch (functionName) {
      'generate_exam_questions' => handleGenerateExamQuestions(arguments),
      'fetch_past_questions' => handleFetchPastQuestions(arguments),
      'validate_question_standards' =>
        handleValidateQuestionStandards(arguments),
      'save_generated_questions' => handleSaveGeneratedQuestions(arguments),
      'analyze_exam_performance' => handleAnalyzeExamPerformance(arguments),
      'track_exam_progress' => handleTrackExamProgress(arguments),
      'retrieve_performance_history' =>
        handleRetrievePerformanceHistory(arguments),
      'update_learning_profile' => handleUpdateLearningProfile(arguments),
      'provide_topic_explanation' => handleProvideTopicExplanation(arguments),
      'generate_study_notes' => handleGenerateStudyNotes(arguments),
      'create_study_timetable' => handleCreateStudyTimetable(arguments),
      'answer_student_question' => handleAnswerStudentQuestion(arguments),
      'provide_exam_strategies' => handleProvideExamStrategies(arguments),
      'generate_practice_drill' => handleGeneratePracticeDrill(arguments),
      'provide_motivation_message' => handleProvideMotivationMessage(arguments),
      'set_study_goals' => handleSetStudyGoals(arguments),
      'track_study_streak' => handleTrackStudyStreak(arguments),
      _ => handleUnknownFunction(functionName),
    };
  }

  // ========================================================================
  // QUESTION MANAGEMENT HANDLERS
  // ========================================================================
 Future<Map<String, Object?>> handleGenerateExamQuestions(
  Map<String, Object?> arguments,
) async {
  debugPrint('Generating exam questions with args: $arguments');
  pskyLog(arguments);
  
  // These are already parsed objects, not JSON strings
  final questions = arguments['questions'] as List<dynamic>;
  final metadata = arguments['metadata'] as Map<String, dynamic>;

  // Convert the list items to proper Map<String, dynamic>
  final questionsList = questions.map((q) => q as Map<String, dynamic>).toList();

  // Pass the entire list to your cubit - it will handle the loop
  await getIt<AiExamCubit>().fetchQuestionsFromAI(
    aiResponse: questionsList, 
    metadata: metadata
  );

  return {
    'success': true,
    'message': 'Questions generated successfully',
    'data': {
      'exam_session_name': 'Mock Exam - ${DateTime.now().toString().split(' ')[0]}',
      'total_questions': metadata['totalQuestions'],
      'current_questions_generated': metadata['currentNumberOfQuestionsGenerated'],
      'questions_count': questionsList.length,
      'estimated_time': metadata['estimatedDurationMinutes'],
      'difficulty_distribution': metadata['difficultyDistribution'],
      'topics_covered': metadata['topicsCovered'],
      'generated_at': metadata['generatedAt'],
    },
  };
}
  Future<Map<String, Object?>> handleFetchPastQuestions(
    Map<String, Object?> arguments,
  ) async {
    debugPrint('Fetching past questions: $arguments');
    return {
      'success': true,
      'message': 'Past questions retrieved',
      'data': {
        'questions': [],
        'subject': arguments['subject'],
        'year': arguments['year'],
        'source': 'official_past_questions',
      },
    };
  }

  Future<Map<String, Object?>> handleValidateQuestionStandards(
    Map<String, Object?> arguments,
  ) async {
    debugPrint('Validating questions: $arguments');
    return {
      'success': true,
      'message': 'Questions validated successfully',
      'data': {
        'valid': true,
        'issues': [],
      },
    };
  }

  Future<Map<String, Object?>> handleSaveGeneratedQuestions(
    Map<String, Object?> arguments,
  ) async {
    debugPrint('Saving questions: $arguments');
    return {
      'success': true,
      'message': 'Questions saved successfully',
      'data': {
        'saved_to_database': true,
        'cached_locally': true,
        'cache_expiry_date': DateTime.now()
            .add(Duration(days: arguments['cache_duration_days'] as int? ?? 5))
            .toIso8601String(),
      },
    };
  }

  // ========================================================================
  // PERFORMANCE ANALYSIS HANDLERS
  // ========================================================================
  Future<Map<String, Object?>> handleAnalyzeExamPerformance(
    Map<String, Object?> arguments,
  ) async {
    debugPrint('Analyzing performance: $arguments');
    return {
      'success': true,
      'message': 'Performance analysis completed',
      'data': {
        'student_name': arguments['student_name'],
        'exam_session_name': arguments['exam_session_name'],
        'overall_performance': {
          'score': 0,
          'percentage': 0.0,
          'grade': 'F',
        },
        'topic_breakdown': [],
        'strengths': [],
        'weaknesses': [],
        'recommendations': [],
      },
    };
  }

  Future<Map<String, Object?>> handleTrackExamProgress(
    Map<String, Object?> arguments,
  ) async {
    debugPrint('Tracking exam progress: $arguments');
    return {
      'success': true,
      'message': 'Progress tracked',
      'data': {
        'student_name': arguments['student_name'],
        'exam_session_name': arguments['exam_session_name'],
        'progress_percentage': 0.0,
        'questions_remaining': 0,
      },
    };
  }

  Future<Map<String, Object?>> handleRetrievePerformanceHistory(
    Map<String, Object?> arguments,
  ) async {
    debugPrint('Retrieving performance history: $arguments');
    return {
      'success': true,
      'message': 'Performance history retrieved',
      'data': {
        'student_name': arguments['student_name'],
        'exams': [],
        'weak_areas': [],
        'improvement_trend': 'improving',
      },
    };
  }

  Future<Map<String, Object?>> handleUpdateLearningProfile(
    Map<String, Object?> arguments,
  ) async {
    debugPrint('Updating learning profile: $arguments');
    return {
      'success': true,
      'message': 'Learning profile updated for ${arguments['student_name']}',
    };
  }

  // ========================================================================
  // EDUCATIONAL SUPPORT HANDLERS
  // ========================================================================
  Future<Map<String, Object?>> handleProvideTopicExplanation(
    Map<String, Object?> arguments,
  ) async {
    debugPrint('Providing explanation: $arguments');
    return {
      'success': true,
      'message': 'Explanation generated',
      'data': {
        'subject': arguments['subject'],
        'topic': arguments['topic'],
        'explanation': 'Detailed explanation text...',
        'examples': [],
        'related_topics': [],
      },
    };
  }

  Future<Map<String, Object?>> handleGenerateStudyNotes(
    Map<String, Object?> arguments,
  ) async {
    debugPrint('Generating study notes: $arguments');
    return {
      'success': true,
      'message': 'Study notes generated',
      'data': {
        'subject': arguments['subject'],
        'notes': 'Comprehensive notes...',
        'key_points': [],
        'formulas': [],
      },
    };
  }

  Future<Map<String, Object?>> handleCreateStudyTimetable(
    Map<String, Object?> arguments,
  ) async {
    debugPrint('Creating timetable: $arguments');
    return {
      'success': true,
      'message': 'Study timetable created for ${arguments['student_name']}',
      'data': {
        'timetable': {},
        'total_study_hours': 0,
      },
    };
  }

  Future<Map<String, Object?>> handleAnswerStudentQuestion(
    Map<String, Object?> arguments,
  ) async {
    debugPrint('Answering question: $arguments');
    return {
      'success': true,
      'message': 'Question answered',
      'data': {
        'answer': 'Detailed answer...',
      },
    };
  }

  Future<Map<String, Object?>> handleProvideExamStrategies(
    Map<String, Object?> arguments,
  ) async {
    debugPrint('Providing strategies: $arguments');
    return {
      'success': true,
      'message': 'Exam strategies provided',
      'data': {
        'strategies': [],
      },
    };
  }

  Future<Map<String, Object?>> handleGeneratePracticeDrill(
    Map<String, Object?> arguments,
  ) async {
    debugPrint('Generating practice drill: $arguments');
    return {
      'success': true,
      'message': 'Practice drill created',
      'data': {
        'drill_name': '${arguments['subject']} - ${arguments['topic']} Drill',
        'questions': [],
      },
    };
  }

  // ========================================================================
  // MOTIVATION & PROGRESS HANDLERS
  // ========================================================================
  Future<Map<String, Object?>> handleProvideMotivationMessage(
    Map<String, Object?> arguments,
  ) async {
    debugPrint('Providing motivation: $arguments');
    return {
      'success': true,
      'message': 'Motivational message generated',
      'data': {
        'message':
            'You\'re doing great, ${arguments['student_name']}! Keep it up!',
      },
    };
  }

  Future<Map<String, Object?>> handleSetStudyGoals(
    Map<String, Object?> arguments,
  ) async {
    debugPrint('Setting study goals: $arguments');
    return {
      'success': true,
      'message': 'Study goal set for ${arguments['student_name']}',
      'data': {
        'goal_name': '${arguments['goal_type']} - ${arguments['target_value']}',
      },
    };
  }

  Future<Map<String, Object?>> handleTrackStudyStreak(
    Map<String, Object?> arguments,
  ) async {
    debugPrint('Tracking study streak: $arguments');
    return {
      'success': true,
      'message': 'Study streak updated for ${arguments['student_name']}',
      'data': {
        'current_streak': 0,
        'longest_streak': 0,
      },
    };
  }

  // ========================================================================
  // ERROR HANDLER
  // ========================================================================
  Future<Map<String, Object?>> handleUnknownFunction(
    String functionName,
  ) async {
    debugPrint('Unknown function: $functionName');
    return {
      'success': false,
      'message': 'Unknown function: $functionName',
      'error_code': 'FUNCTION_NOT_FOUND',
    };
  }
}
