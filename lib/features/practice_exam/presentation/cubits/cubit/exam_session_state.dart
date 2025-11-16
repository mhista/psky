// ============================================================================
// STATE
// ============================================================================

part of 'exam_session_cubit.dart';

@freezed
class ExamSessionState with _$ExamSessionState {
  const factory ExamSessionState.initial() = _Initial;
  
  const factory ExamSessionState.active({
    required ExamSession session,
    required int currentQuestionIndex,
    required int timeRemainingSeconds,
    @Default(false) bool hasReachedQuestionLimit, // New field to track 30 question limit
  }) = _Active;
  
  const factory ExamSessionState.paused({
    required ExamSession session,
    required int currentQuestionIndex,
    required int timeRemainingSeconds,
    @Default(false) bool hasReachedQuestionLimit, // New field for paused state too
  }) = _Paused;
  
  const factory ExamSessionState.completed({
    required ExamSession session,
    required int currentQuestionIndex,

  }) = _Completed;
  
  const factory ExamSessionState.abandoned({
    required ExamSession session,
  }) = _Abandoned;
}