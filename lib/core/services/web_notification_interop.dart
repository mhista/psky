// ============================================================================
// DART JS INTEROP FOR WEB NOTIFICATIONS (REWRITTEN WITH JS_INTEROP)
// ============================================================================
// Create this file: lib/core/services/web_notification_interop.dart

import 'dart:async';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';
import 'package:ahiaa_web/core/utils/logging/logger.dart';
import 'package:web/web.dart' as web;

// --- Interop Definitions (JS Facades) ---

// --- Interop Definitions (JS Facades) ---

/// Extension for accessing standard properties on the global `window` object.
extension GlobalWindowProperties on web.Window {
  /// Accesses the global `Notification` constructor/object.
  external JSObject? get Notification;
  
  // Custom property to register the callback from Dart
  external set flutter_notification_callback(JSFunction callback);
}

/// A JS facade for the global `Notification` object (constructor).
@JS('Notification')
extension type NotificationJS._(JSObject _) implements JSObject {
  external static JSAny get permission;
  external static JSPromise requestPermission();
}

/// A JS facade for the JavaScript functions exposed by the accompanying JS file.
/// IMPORTANT FIX: We define this as an extension type on web.Window, 
/// so we can correctly cast and use it on the global web.window instance.
extension type WebNotificationHelper._(JSObject _) implements JSObject {
  external JSPromise requestNotificationPermission();
  external JSPromise closeNotification(String tag);
  external JSPromise initializeFCM(JSObject firebaseConfig, String vapidKey);
  external void showNotification(String title, String body, JSAny? data);
}

// --- Dart Interop Class ---

/// Web Notification Interop
/// Provides Dart bindings to JavaScript notification functions
class WebNotificationInterop {
  // Access to the global scope
  static final web.Window _window = web.window;
  
  // FIX: Cast the web.window instance to the WebNotificationHelper extension type.
  // This explicitly links the methods to the window object.
  static final WebNotificationHelper _helper = unsafeCast<WebNotificationHelper>(web.window);

  /// Check if notifications are supported
  static bool get isSupported {
    // Check for both 'Notification' and 'serviceWorker'
    return _window.Notification != null && _window.navigator.serviceWorker != null;
  }

  /// Get current notification permission status
  static String get permissionStatus {
    try {
      final permission = NotificationJS.permission;
      return (permission as JSString).toDart;
    } catch (e) {
      return 'default';
    }
  }

  /// Request notification permission
  static Future<bool> requestPermission() async {
    try {
      if (!isSupported) {
        pskyLog('Notifications not supported');
        return false;
      }
      final result = await NotificationJS.requestPermission().toDart;
      return result.toString() == 'granted';
    } catch (e) {
      pskyLog('Error requesting permission: $e');
      return false;
    }
  }

  /// Show a web notification
  static Future<void> showNotification({
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      if (!isSupported || permissionStatus != 'granted') {
        pskyLog('Notifications not supported or permission not granted');
        return;
      }
      
      final dataJs = data?.jsify() as JSObject?;
      
      _helper.showNotification(title, body, dataJs);
    } catch (e) {
      pskyLog('Error showing notification: $e');
    }
  }

  /// Close notification by tag
  static Future<void> closeNotification(String tag) async {
    try {
      if (!isSupported) return;
      await _helper.closeNotification(tag).toDart;
    } catch (e) {
      pskyLog('Error closing notification: $e');
    }
  }

  /// Initialize FCM for web
  static Future<String?> initializeFCM({
    required Map<String, dynamic> firebaseConfig,
    required String vapidKey,
  }) async {
    try {
      if (!isSupported) {
        pskyLog('FCM not supported');
        return null;
      }

      final configJs = firebaseConfig.jsify() as JSObject;
      final token = await _helper.initializeFCM(configJs, vapidKey).toDart;

      return (token as JSString?)?.toDart;
    } catch (e) {
      pskyLog('Error initializing FCM: $e');
      return null;
    }
  }

  /// Register notification click callback
  static void registerNotificationCallback(Function(Map<String, dynamic>) callback) {
    try {
      // Assign the JS interop function to a global property on the window object
      _window.flutter_notification_callback = ((JSObject data) {
          try {
            final dataMap = data.dartify() as Map<String, dynamic>;
            callback(dataMap);
          } catch (e) {
            pskyLog('Error in notification callback: $e');
          }
        }).toJS;
    } catch (e) {
      pskyLog('Error registering callback: $e');
    }
  }
}

// ... (WebNotificationManager remains the same) ...
// ============================================================================
// ENHANCED WEB NOTIFICATION MANAGER (NO CHANGE NEEDED)
// ============================================================================

class WebNotificationManager {
  static bool _initialized = false;
  static bool _permissionGranted = false;
  static Function(Map<String, dynamic>)? _onNotificationClick;

  /// Initialize web notifications
  static Future<void> initialize({
    Function(Map<String, dynamic>)? onNotificationClick,
  }) async {
    if (_initialized) return;

    try {
      _onNotificationClick = onNotificationClick;

      // Register callback
      if (_onNotificationClick != null) {
        WebNotificationInterop.registerNotificationCallback(_onNotificationClick!);
      }

      // Request permission
      _permissionGranted = await requestPermission();

      _initialized = true;
      pskyLog('WebNotificationManager initialized');
    } catch (e) {
      pskyLog('Error initializing WebNotificationManager: $e');
    }
  }

  /// Request permission
  static Future<bool> requestPermission() async {
    try {
      if (!WebNotificationInterop.isSupported) {
        pskyLog('Notifications not supported on this browser');
        return false;
      }

      _permissionGranted = await WebNotificationInterop.requestPermission();
      return _permissionGranted;
    } catch (e) {
      pskyLog('Error requesting permission: $e');
      return false;
    }
  }

  /// Check if permission is granted
  static bool get hasPermission => _permissionGranted;

  /// Show notification
  static Future<void> showNotification({
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      if (!_permissionGranted) {
        pskyLog('Notification permission not granted');
        return;
      }

      await WebNotificationInterop.showNotification(
        title: title,
        body: body,
        data: data,
      );
    } catch (e) {
      pskyLog('Error showing notification: $e');
    }
  }

  /// Close notification
  static Future<void> closeNotification(String tag) async {
    try {
      await WebNotificationInterop.closeNotification(tag);
    } catch (e) {
      pskyLog('Error closing notification: $e');
    }
  }

  /// Initialize FCM
  static Future<String?> initializeFCM({
    required Map<String, dynamic> firebaseConfig,
    required String vapidKey,
  }) async {
    try {
      return await WebNotificationInterop.initializeFCM(
        firebaseConfig: firebaseConfig,
        vapidKey: vapidKey,
      );
    } catch (e) {
      pskyLog('Error initializing FCM: $e');
      return null;
    }
  }
}