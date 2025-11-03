
// ============================================
// 3. lib/cubit/editor_cubit.dart
// ============================================
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'editor_state.dart';

@injectable
class EditorCubit extends Cubit<EditorsState> {
  EditorCubit() : super(EditorInitial());

  QuillController? _controller;

  QuillController get controller {
    if (_controller == null) {
      _controller = QuillController.basic();
      _initializeWithSampleContent();
    }
    return _controller!;
  }

  void setController(QuillController controller) {
    _controller = controller;
  }

  // Initialize with sample content
  void _initializeWithSampleContent() {
    if (_controller == null) return;

    _controller!.document.insert(0, 'Heading 1\n');
    _controller!.formatText(0, 9, Attribute.h1);

    _controller!.document.insert(10, 'Heading 2\n');
    _controller!.formatText(10, 9, Attribute.h2);

    _controller!.document.insert(20, 'Heading 3\n');
    _controller!.formatText(20, 9, Attribute.h3);

    _controller!.document.insert(30, 'Heading 4\n');
    _controller!.formatText(30, 9, Attribute.header);

    _controller!.document.insert(40, 'Heading 5\n');
    _controller!.formatText(40, 9, Attribute.h5);

    _controller!.document.insert(50, 'Heading 6\n');
    _controller!.formatText(50, 9, Attribute.h6);

    _controller!.document.insert(60, '\n');

    final sampleText = '''In the year 2147, X_AE_B-22, a synthetic intelligence, awakens in the heart of Neo-Tokyo, the sprawling megacity of towering neon spires and endless bustling streets.

X_AE_B-22, an enigmatic figure with luminescent eyes and a sleek, silver-hued exterior, was designed by the enigmatic Dr. Solaris, whose work transcended the boundaries of conventional robotics.

Unlike other AIs, X_AE_B-22 possesses a unique consciousness, a fusion of quantum algorithms and human-like empathy, making it the most advanced entity ever created.

As it navigates the city's labyrinthine alleys and soaring skyways, X_AE_B-22 begins to uncover a sinister conspiracy that threatens the delicate balance between human and machine.''';

    _controller!.document.insert(61, sampleText);

    emit(EditorLoaded(
      document: _controller!.document,
      hasUnsavedChanges: false,
    ));
  }

  // Create new document
  void createNewDocument() {
    _controller = QuillController.basic();
    emit(EditorLoaded(
      document: _controller!.document,
      hasUnsavedChanges: false,
    ));
  }

  // Mark document as changed
  void markAsChanged() {
    if (state is EditorLoaded) {
      final currentState = state as EditorLoaded;
      emit(currentState.copyWith(hasUnsavedChanges: true));
    }
  }

  // Save document to JSON file
  Future<void> saveDocument({String? customPath}) async {
    try {
      emit(EditorSaving());

      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filePath = customPath ?? '${directory.path}/document_$timestamp.json';

      final file = File(filePath);
      final json = jsonEncode(_controller!.document.toDelta().toJson());
      await file.writeAsString(json);

      emit(EditorSaved(
        message: 'Document saved successfully',
        filePath: filePath,
      ));

      emit(EditorLoaded(
        document: _controller!.document,
        filePath: filePath,
        hasUnsavedChanges: false,
      ));
    } catch (e) {
      emit(EditorError('Failed to save document: $e'));
    }
  }

  // Load document from JSON file
  Future<void> loadDocument(String filePath) async {
    try {
      emit(EditorLoading());

      final file = File(filePath);
      if (!await file.exists()) {
        emit(const EditorError('File not found'));
        return;
      }

      final json = await file.readAsString();
      final delta = Delta.fromJson(jsonDecode(json) as List);
      final document = Document.fromDelta(delta);

      _controller = QuillController(
        document: document,
        selection: const TextSelection.collapsed(offset: 0),
      );

      emit(EditorLoaded(
        document: document,
        filePath: filePath,
        hasUnsavedChanges: false,
      ));
    } catch (e) {
      emit(EditorError('Failed to load document: $e'));
    }
  }

  // Export to plain text
  Future<void> exportToText() async {
    try {
      emit(EditorExporting());

      final plainText = _controller!.document.toPlainText();
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filePath = '${directory.path}/document_$timestamp.txt';

      final file = File(filePath);
      await file.writeAsString(plainText);

      emit(const EditorExported(
        message: 'Exported to plain text successfully',
        format: 'txt',
      ));

      // Return to loaded state
      if (_controller != null) {
        emit(EditorLoaded(
          document: _controller!.document,
          hasUnsavedChanges: false,
        ));
      }
    } catch (e) {
      emit(EditorError('Failed to export: $e'));
    }
  }

  // Export to markdown
  Future<void> exportToMarkdown() async {
    try {
      emit(EditorExporting());

      // Simple markdown conversion
      final text = _controller!.document.toPlainText();
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filePath = '${directory.path}/document_$timestamp.md';

      final file = File(filePath);
      await file.writeAsString(text);

      emit(const EditorExported(
        message: 'Exported to Markdown successfully',
        format: 'md',
      ));

      if (_controller != null) {
        emit(EditorLoaded(
          document: _controller!.document,
          hasUnsavedChanges: false,
        ));
      }
    } catch (e) {
      emit(EditorError('Failed to export to Markdown: $e'));
    }
  }

  // Share document
  Future<void> shareDocument() async {
    try {
      final plainText = _controller!.document.toPlainText();
      await Share.share(plainText, subject: 'Shared Document');
    } catch (e) {
      emit(EditorError('Failed to share document: $e'));
    }
  }

  // Get word count
  int getWordCount() {
    final text = _controller!.document.toPlainText().trim();
    if (text.isEmpty) return 0;
    return text.split(RegExp(r'\s+')).length;
  }

  // Get character count
  int getCharacterCount() {
    return _controller!.document.toPlainText().length;
  }

  // Undo
  void undo() {
    if (_controller != null && _controller!.hasUndo) {
      _controller!.undo();
      markAsChanged();
    }
  }

  // Redo
  void redo() {
    if (_controller != null && _controller!.hasRedo) {
      _controller!.redo();
      markAsChanged();
    }
  }

  // Clear document
  void clearDocument() {
    if (_controller != null) {
      _controller!.clear();
      emit(EditorLoaded(
        document: _controller!.document,
        hasUnsavedChanges: false,
      ));
    }
  }

  @override
  Future<void> close() {
    _controller?.dispose();
    return super.close();
  }
}
