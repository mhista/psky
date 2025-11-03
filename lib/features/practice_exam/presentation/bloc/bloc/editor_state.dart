// ============================================
// 2. lib/cubit/editor_state.dart
// ============================================
import 'package:equatable/equatable.dart';
import 'package:flutter_quill/flutter_quill.dart';

abstract class EditorsState extends Equatable {
  const EditorsState();

  @override
  List<Object?> get props => [];
}

class EditorInitial extends EditorsState {}

class EditorLoading extends EditorsState {}

class EditorLoaded extends EditorsState {
  final Document document;
  final String? filePath;
  final bool hasUnsavedChanges;

  const EditorLoaded({
    required this.document,
    this.filePath,
    this.hasUnsavedChanges = false,
  });

  @override
  List<Object?> get props => [document, filePath, hasUnsavedChanges];

  EditorLoaded copyWith({
    Document? document,
    String? filePath,
    bool? hasUnsavedChanges,
  }) {
    return EditorLoaded(
      document: document ?? this.document,
      filePath: filePath ?? this.filePath,
      hasUnsavedChanges: hasUnsavedChanges ?? this.hasUnsavedChanges,
    );
  }
}

class EditorSaving extends EditorsState {}

class EditorSaved extends EditorsState {
  final String message;
  final String? filePath;

  const EditorSaved({required this.message, this.filePath});

  @override
  List<Object?> get props => [message, filePath];
}

class EditorError extends EditorsState {
  final String message;

  const EditorError(this.message);

  @override
  List<Object> get props => [message];
}

class EditorExporting extends EditorsState {}

class EditorExported extends EditorsState {
  final String message;
  final String format;

  const EditorExported({required this.message, required this.format});

  @override
  List<Object> get props => [message, format];
}