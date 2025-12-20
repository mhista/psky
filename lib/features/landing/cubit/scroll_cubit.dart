// lib/core/common/cubits/scroll_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ScrollCubit extends Cubit<void> {
  ScrollCubit() : super(null);

  // Store GlobalKeys for each section
  final Map<String, GlobalKey> _sectionKeys = {};

  // Register a section with its key
  void registerSection(String sectionName, GlobalKey key) {
    _sectionKeys[sectionName] = key;
  }

  // Unregister a section (for cleanup)
  void unregisterSection(String sectionName) {
    _sectionKeys.remove(sectionName);
  }

  // Scroll to a specific section
  void scrollToSection(String sectionName) {
    final key = _sectionKeys[sectionName];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        alignment: 0.0, // 0.0 = top of viewport, 0.5 = center, 1.0 = bottom
      );
    }
  }

  // Get all registered sections
  List<String> get registeredSections => _sectionKeys.keys.toList();
}