// ============================================================================
// WEB NOTIFICATION HELPER (web/js/notifications.js)
// ============================================================================
// Place this file in your web/js directory and reference it in web/index.html

/**
 * Web Notification Manager for Flutter Web
 * Handles browser notification permissions and display
 */
class WebNotificationManager {
  constructor() {
    this.permission = Notification.permission;
    this.serviceWorkerReady = false;
    this.initServiceWorker();
  }

  /**
   * Initialize service worker for FCM
   */
  async initServiceWorker() {
    if ('serviceWorker' in navigator) {
      try {
        const registration = await navigator.serviceWorker.register(
          '/firebase-messaging-sw.js'
        );
        console.log('Service Worker registered:', registration);
        this.serviceWorkerReady = true;
      } catch (error) {
        console.error('Service Worker registration failed:', error);
      }
    }
  }

  /**
   * Request notification permission from browser
   */
  async requestPermission() {
    try {
      if (!('Notification' in window)) {
        console.warn('This browser does not support notifications');
        return false;
      }

      if (this.permission === 'granted') {
        return true;
      }

      if (this.permission !== 'denied') {
        const permission = await Notification.requestPermission();
        this.permission = permission;
        return permission === 'granted';
      }

      return false;
    } catch (error) {
      console.error('Error requesting notification permission:', error);
      return false;
    }
  }

  /**
   * Show a browser notification
   */
  async showNotification(title, options = {}) {
    try {
      // Check permission
      if (this.permission !== 'granted') {
        const granted = await this.requestPermission();
        if (!granted) {
          console.warn('Notification permission not granted');
          return null;
        }
      }

      // Default options
      const notificationOptions = {
        body: options.body || '',
        icon: options.icon || '/icons/Icon-192.png',
        badge: options.badge || '/icons/Icon-192.png',
        image: options.image,
        tag: options.tag || 'default',
        requireInteraction: options.requireInteraction || false,
        silent: options.silent || false,
        vibrate: options.vibrate || [200, 100, 200],
        data: options.data || {},
        actions: options.actions || [],
        timestamp: Date.now(),
      };

      // Try to use service worker notification first
      if (this.serviceWorkerReady && 'serviceWorker' in navigator) {
        const registration = await navigator.serviceWorker.ready;
        return await registration.showNotification(title, notificationOptions);
      }

      // Fallback to regular notification
      return new Notification(title, notificationOptions);
    } catch (error) {
      console.error('Error showing notification:', error);
      return null;
    }
  }

  /**
   * Close all notifications with a specific tag
   */
  async closeNotifications(tag) {
    try {
      if ('serviceWorker' in navigator) {
        const registration = await navigator.serviceWorker.ready;
        const notifications = await registration.getNotifications({ tag });
        notifications.forEach(notification => notification.close());
      }
    } catch (error) {
      console.error('Error closing notifications:', error);
    }
  }

  /**
   * Get active notifications
   */
  async getActiveNotifications(tag = null) {
    try {
      if ('serviceWorker' in navigator) {
        const registration = await navigator.serviceWorker.ready;
        const options = tag ? { tag } : {};
        return await registration.getNotifications(options);
      }
      return [];
    } catch (error) {
      console.error('Error getting notifications:', error);
      return [];
    }
  }
}

// ============================================================================
// GLOBAL INSTANCE AND FLUTTER INTEGRATION
// ============================================================================

// Create global instance
window.webNotificationManager = new WebNotificationManager();

/**
 * Flutter-callable functions
 * These are called from Dart via js interop
 */

/**
 * Request notification permission
 * Called from Dart: js.context.callMethod('requestNotificationPermission')
 */
window.requestNotificationPermission = async function() {
  return await window.webNotificationManager.requestPermission();
};

/**
 * Show notification
 * Called from Dart: js.context.callMethod('showNotification', [title, body, data])
 */
window.showNotification = async function(title, body, data = {}) {
  const options = {
    body: body,
    data: data,
    tag: data.tag || 'exam-notification',
    requireInteraction: data.priority === 'high' || data.priority === 'urgent',
  };

  // Add action buttons based on notification type
  if (data.type === 'session_expiring') {
    options.actions = [
      { action: 'open', title: 'Open Exam', icon: '/icons/Icon-192.png' },
      { action: 'dismiss', title: 'Dismiss', icon: '/icons/Icon-192.png' },
    ];
  } else if (data.type === 'achievement') {
    options.actions = [
      { action: 'view', title: 'View', icon: '/icons/Icon-192.png' },
    ];
  }

  return await window.webNotificationManager.showNotification(title, options);
};

/**
 * Close notification by tag
 */
window.closeNotification = async function(tag) {
  return await window.webNotificationManager.closeNotifications(tag);
};

/**
 * Get notification permission status
 */
window.getNotificationPermission = function() {
  return Notification.permission;
};

/**
 * Check if notifications are supported
 */
window.notificationsSupported = function() {
  return 'Notification' in window && 'serviceWorker' in navigator;
};

// ============================================================================
// NOTIFICATION CLICK HANDLING
// ============================================================================

/**
 * Handle notification clicks
 */
if ('serviceWorker' in navigator) {
  navigator.serviceWorker.addEventListener('message', (event) => {
    if (event.data && event.data.type === 'notification-click') {
      console.log('Notification clicked:', event.data);
      
      // Send message to Flutter
      if (window.flutter_notification_callback) {
        window.flutter_notification_callback(event.data);
      }
    }
  });
}

// ============================================================================
// AUTOMATIC PERMISSION REQUEST (OPTIONAL)
// ============================================================================

/**
 * Automatically request permission on page load (optional)
 * Uncomment if you want to request permission immediately
 */

window.addEventListener('load', async () => {
  // Wait a bit before requesting (better UX)
  setTimeout(async () => {
    if (Notification.permission === 'default') {
      await window.webNotificationManager.requestPermission();
    }
  }, 5000); // Request after 5 seconds
});


// ============================================================================
// FIREBASE CLOUD MESSAGING (FCM) INTEGRATION
// ============================================================================

/**
 * Initialize FCM for web
 */
window.initializeFCM = async function(firebaseConfig, vapidKey) {
  try {
    // This assumes Firebase is already loaded in index.html
    if (typeof firebase === 'undefined') {
      console.error('Firebase is not loaded');
      return null;
    }

    // Initialize Firebase
    if (!firebase.apps.length) {
      firebase.initializeApp(firebaseConfig);
    }

    const messaging = firebase.messaging();

    // Request permission
    const permission = await window.webNotificationManager.requestPermission();
    if (!permission) {
      console.warn('Notification permission denied');
      return null;
    }

    // Get FCM token
    const token = await messaging.getToken({ vapidKey });
    console.log('FCM Token:', token);

    // Handle foreground messages
    messaging.onMessage((payload) => {
      console.log('Received foreground message:', payload);
      
      const notificationTitle = payload.notification?.title || 'New Notification';
      const notificationOptions = {
        body: payload.notification?.body || '',
        data: payload.data || {},
      };

      window.showNotification(notificationTitle, notificationOptions.body, notificationOptions.data);
    });

    return token;
  } catch (error) {
    console.error('Error initializing FCM:', error);
    return null;
  }
};

// ============================================================================
// UTILITY FUNCTIONS
// ============================================================================

/**
 * Format notification data for Flutter
 */
window.formatNotificationData = function(data) {
  return {
    type: data.type || 'default',
    action: data.action || '',
    sessionId: data.sessionId || '',
    userId: data.userId || '',
    timestamp: Date.now(),
  };
};

/**
 * Log notification analytics (optional)
 */
window.logNotificationEvent = function(eventType, data) {
  console.log(`Notification Event: ${eventType}`, data);
  
  // Send to analytics if available
  if (window.gtag) {
    window.gtag('event', 'notification', {
      event_category: 'Notification',
      event_label: eventType,
      value: data,
    });
  }
};

console.log('✅ Web Notification Manager initialized');