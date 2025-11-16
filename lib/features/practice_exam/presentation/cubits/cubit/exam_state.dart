// ============================================================================
// STATE
// ============================================================================

part of 'exam_cubit.dart';

@freezed
class ExamState with _$ExamState {
  const factory ExamState.initial() = _Initial;

  const factory ExamState.modeSelected({
    required ExamMode examMode,
    Map<String, List<String>>? selectedSubjectAndTopic,
    String? selectedSubject, // Add this field
    required List<String> selectedSubjectTopics,
  }) = _ModeSelected;

  const factory ExamState.loading() = _Loading;

  const factory ExamState.hasData({
    required ExamMode examMode,
    required List<String> selectedSubjects,
    required List<ExamSession> examSessions,
    required ExamSession currentSession,
  }) = _HasData;

  const factory ExamState.completed({
    required List<ExamSession> examSessions,
    required ExamSession completedSession,
  }) = _Completed;

  const factory ExamState.error({
    required String message,
  }) = _Error;
}
