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
  debugPrint('🚀 ===== STARTING DEPENDENCY CONFIGURATION =====');
  
  try {
    // STEP 1: Initialize Firebase FIRST before any other dependencies
    debugPrint('📍 Step 1/3: Initializing Firebase...');
    await _initFirebase();
    debugPrint('✅ Step 1/3: Firebase initialization completed');
    
    // STEP 2: Initialize injectable dependencies (which now can safely use FirebaseAuth.instance)
    debugPrint('📍 Step 2/3: Initializing Injectable dependencies...');
    await getIt.init();
    debugPrint('✅ Step 2/3: Injectable dependencies registered');
    
    // STEP 3: Initialize Gemini and AI models
    debugPrint('📍 Step 3/3: Initializing AI Models...');
    await _initAIModels();
    debugPrint('✅ Step 3/3: AI Models initialization completed');
    
    debugPrint('🎉 ===== DEPENDENCY CONFIGURATION COMPLETE =====');
  } catch (e, stackTrace) {
    debugPrint('❌ ===== DEPENDENCY CONFIGURATION FAILED =====');
    debugPrint('Error: $e');
    debugPrint('Stack trace: $stackTrace');
    rethrow;
  }
}

// ============================================================================
// Firebase Initialization (Must happen FIRST)
// ============================================================================
Future<void> _initFirebase() async {
  debugPrint('  🔧 Initializing Firebase with platform options...');
  
  try {
    final firebase = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    
    debugPrint('  📦 Registering Firebase instance in GetIt...');
    getIt.registerLazySingleton(() => firebase);
    
    debugPrint('  ✅ Firebase initialized successfully');
    debugPrint('     - App name: ${firebase.name}');
    debugPrint('     - Platform: ${DefaultFirebaseOptions.currentPlatform.projectId}');
  } catch (e) {
    debugPrint('  ❌ Firebase initialization error: $e');
    rethrow;
  }
}

// ============================================================================
// AI Models Initialization (After Firebase and Injectable)
// ============================================================================
Future<void> _initAIModels() async {
  try {
    // Sub-step 3.1: Initialize Gemini Tools
    debugPrint('  📍 Step 3.1: Initializing Gemini Tools...');
    _initGeminiTool();
    debugPrint('  ✅ Step 3.1: Gemini Tools initialized');
    
    // Sub-step 3.2: Initialize Chat Model
    debugPrint('  📍 Step 3.2: Initializing Chat Model...');
    await _initChatModel();
    debugPrint('  ✅ Step 3.2: Chat Model initialized');
    
    // Sub-step 3.3: Initialize Image Model
    debugPrint('  📍 Step 3.3: Initializing Image Model...');
    await _initImageModel();
    debugPrint('  ✅ Step 3.3: Image Model initialized');
    
    debugPrint('  ✅ All AI Models initialized successfully');
  } catch (e) {
    debugPrint('  ❌ AI Models initialization error: $e');
    rethrow;
  }
}

// Initialize Gemini tools
void _initGeminiTool() {
  if (!getIt.isRegistered<GeminiTools>()) {
    debugPrint('     - Registering GeminiTools...');
    getIt.registerLazySingleton<GeminiTools>(() => GeminiTools());
    debugPrint('     - GeminiTools registered');
  } else {
    debugPrint('     ⚠️  GeminiTools already registered, skipping');
  }
}

// Initialize chat model
Future<void> _initChatModel() async {
  if (!getIt.isRegistered<ChatSession>()) {
    try {
      debugPrint('     - Loading system prompt from assets...');
      final systemPrompt = await rootBundle.loadString('assets/system_prompt.md');
      debugPrint('     - System prompt loaded (${systemPrompt.length} characters)');
      
      debugPrint('     - Getting FirebaseAuth instance...');
      final firebaseAuth = getIt<FirebaseAuth>();
      debugPrint('     - FirebaseAuth instance retrieved');
      
      debugPrint('     - Creating generative model (gemini-2.5-flash)...');
      final model = FirebaseAI.googleAI(auth: firebaseAuth).generativeModel(
        model: 'gemini-2.5-flash',
        systemInstruction: Content.system(systemPrompt),
        tools: getIt<GeminiTools>().tools,
      );
      debugPrint('     - Generative model created');
      
      debugPrint('     - Starting chat session...');
      getIt.registerLazySingleton<ChatSession>(() => model.startChat());
      debugPrint('     - ChatSession registered');
    } catch (e) {
      debugPrint('     ❌ Error initializing chat model: $e');
      rethrow;
    }
  } else {
    debugPrint('     ⚠️  ChatSession already registered, skipping');
  }
}

// Initialize image model
Future<void> _initImageModel() async {
  if (!getIt.isRegistered<ImagenModel>()) {
    try {
      debugPrint('     - Creating Imagen model (imagen-3.0-generate-002)...');
      final model = FirebaseAI.googleAI().imagenModel(
        model: 'imagen-3.0-generate-002',
      );
      debugPrint('     - Imagen model created');
      
      debugPrint('     - Registering ImagenModel...');
      getIt.registerLazySingleton<ImagenModel>(() => model);
      debugPrint('     - ImagenModel registered');
    } catch (e) {
      debugPrint('     ❌ Error initializing image model: $e');
      rethrow;
    }
  } else {
    debugPrint('     ⚠️  ImagenModel already registered, skipping');
  }
}