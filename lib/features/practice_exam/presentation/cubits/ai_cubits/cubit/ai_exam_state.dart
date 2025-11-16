part of 'ai_exam_cubit.dart';
// ============================================================================
// STATE
// ============================================================================


@freezed
class AiExamState with _$AiExamState {
  const factory AiExamState.initial() = _Initial;
  
  const factory AiExamState.loading() = _Loading;
  
 const factory AiExamState.hasData({
    required AiQuestionData activeExam,
    required List<AiQuestionData> allExams,
    required int currentIndex,
    int? currentNumberOfQuestionsGenerated,
    @Default(0) int lastFetchThreshold, // Track when we last fetched
    @Default(false) bool didFetchAnyExam, // Track when we last fetched

  }) = _HasData;
  
  
  const factory AiExamState.error({
    required String message,
  }) = _Error;
}