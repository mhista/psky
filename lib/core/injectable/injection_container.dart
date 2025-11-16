// ============================================================================
// FILE: lib/core/injectable/injection_container.dart
// ============================================================================
import 'package:ahiaa_web/core/services/gemini_tools.dart';
import 'package:ahiaa_web/core/injectable/injection_container.config.dart';
import 'package:ahiaa_web/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  // CRITICAL: Initialize Firebase FIRST before any other dependencies
  await _initFirebase();
  
  // Then initialize injectable dependencies (which now can safely use FirebaseAuth.instance)
  // IMPORTANT: Must await this!
  await getIt.init();
  
  // Finally, initialize Gemini and AI models
  await _initAIModels();
}

// ============================================================================
// Firebase Initialization (Must happen FIRST)
// ============================================================================
Future<void> _initFirebase() async {
  try {
    final firebase = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    getIt.registerLazySingleton(() => firebase);
    debugPrint('✅ Firebase initialized successfully');
  } catch (e) {
    debugPrint('❌ Firebase initialization error: $e');
    rethrow;
  }
}

// ============================================================================
// AI Models Initialization (After Firebase and Injectable)
// ============================================================================
Future<void> _initAIModels() async {
  try {
    // Initialize Gemini Tools first
    _initGeminiTool();
    
    // Then initialize models
    await _initChatModel();
    await _initImageModel();
    
    debugPrint('✅ AI Models initialized successfully');
  } catch (e) {
    debugPrint('❌ AI Models initialization error: $e');
    rethrow;
  }
}

// Initialize Gemini tools
void _initGeminiTool() {
  if (!getIt.isRegistered<GeminiTools>()) {
    getIt.registerLazySingleton<GeminiTools>(() => GeminiTools());
  }
}

// Initialize chat model
Future<void> _initChatModel() async {
  if (!getIt.isRegistered<ChatSession>()) {
    final systemPrompt = await rootBundle.loadString('assets/system_prompt.md');
    final model = FirebaseAI.googleAI(auth: getIt<FirebaseAuth>()).generativeModel(
      model: 'gemini-2.5-flash',
      systemInstruction: Content.system(systemPrompt),
      tools: getIt<GeminiTools>().tools,
    );
    getIt.registerLazySingleton<ChatSession>(() => model.startChat());
  }
}

// Initialize image model
Future<void> _initImageModel() async {
  if (!getIt.isRegistered<ImagenModel>()) {
    final model = FirebaseAI.googleAI().imagenModel(
      model: 'imagen-3.0-generate-002',
    );
    getIt.registerLazySingleton<ImagenModel>(() => model);
  }
}