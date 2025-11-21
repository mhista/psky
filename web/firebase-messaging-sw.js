// ============================================================================
// FIREBASE MESSAGING SERVICE WORKER (web/firebase-messaging-sw.js)
// ============================================================================
// Place this file in your web/ directory (NOT in web/js)

importScripts(
  "https://www.gstatic.com/firebasejs/9.0.0/firebase-app-compat.js"
);
importScripts(
  "https://www.gstatic.com/firebasejs/9.0.0/firebase-messaging-compat.js"
);

// ============================================================================
// FIREBASE CONFIGURATION
// ============================================================================
// Replace with your actual Firebase config
const firebaseConfig = {
  apiKey: "AIzaSyD56CO2l1nBBGJgeeL_cuto7x00e-UuSrU",
  authDomain: "psky-40ba3.firebaseapp.com",
  projectId: "psky-40ba3",
  storageBucket: "psky-40ba3.firebasestorage.app",
  messagingSenderId: "34018864068",
  appId: "1:34018864068:web:ad4689645c1d8c390c5291",
  measurementId: "G-91747X0BJW",
};
// Initialize Firebase
firebase.initializeApp(firebaseConfig);

// Initialize Firebase Messaging
const messaging = firebase.messaging();

// ============================================================================
// BACKGROUND MESSAGE HANDLER
// ============================================================================

/**
 * Handle background messages (when app is not in focus)
 */
messaging.onBackgroundMessage((payload) => {
  console.log("[Service Worker] Received background message:", payload);

  // Extract notification data
  const notificationTitle = payload.notification?.title || "New Notification";
  const notificationOptions = {
    body: payload.notification?.body || "",
    icon: payload.notification?.icon || "/icons/Icon-192.png",
    badge: "/icons/Icon-192.png",
    tag: payload.data?.sessionId || "default",
    requireInteraction: payload.data?.priority === "high",
    data: payload.data || {},
    actions: getNotificationActions(payload.data?.type),
    timestamp: Date.now(),
  };

  // Show notification
  return self.registration.showNotification(
    notificationTitle,
    notificationOptions
  );
});

/**
 * Get notification actions based on type
 */
function getNotificationActions(type) {
  switch (type) {
    case "session_start":
    case "session_expiring":
    case "session_reminder":
      return [
        {
          action: "open_session",
          title: "Open Exam",
          icon: "/icons/Icon-192.png",
        },
        { action: "dismiss", title: "Dismiss", icon: "/icons/Icon-192.png" },
      ];

    case "achievement":
      return [
        {
          action: "view_achievements",
          title: "View",
          icon: "/icons/Icon-192.png",
        },
        { action: "dismiss", title: "Later", icon: "/icons/Icon-192.png" },
      ];

    case "leaderboard":
      return [
        {
          action: "view_leaderboard",
          title: "View Leaderboard",
          icon: "/icons/Icon-192.png",
        },
        { action: "dismiss", title: "Dismiss", icon: "/icons/Icon-192.png" },
      ];

    case "streak_reminder":
    case "daily_goal":
      return [
        {
          action: "open_practice",
          title: "Start Session",
          icon: "/icons/Icon-192.png",
        },
        { action: "dismiss", title: "Later", icon: "/icons/Icon-192.png" },
      ];

    default:
      return [
        { action: "open", title: "Open", icon: "/icons/Icon-192.png" },
        { action: "dismiss", title: "Dismiss", icon: "/icons/Icon-192.png" },
      ];
  }
}

// ============================================================================
// NOTIFICATION CLICK HANDLER
// ============================================================================

/**
 * Handle notification clicks
 */
self.addEventListener("notificationclick", (event) => {
  console.log("[Service Worker] Notification clicked:", event);

  event.notification.close();

  const action = event.action;
  const data = event.notification.data || {};

  // Handle different actions
  if (action === "dismiss") {
    return;
  }

  // Determine URL to open based on action
  const url = getUrlForAction(action, data);

  // Open or focus window
  event.waitUntil(
    clients
      .matchAll({ type: "window", includeUncontrolled: true })
      .then((clientList) => {
        // Check if app is already open
        for (const client of clientList) {
          if (
            client.url.includes(self.registration.scope) &&
            "focus" in client
          ) {
            // Send message to client
            client.postMessage({
              type: "notification-click",
              action: action || "open",
              data: data,
            });
            return client.focus();
          }
        }

        // Open new window if app is not open
        if (clients.openWindow) {
          return clients.openWindow(url);
        }
      })
  );
});

/**
 * Get URL to navigate to based on action
 */
function getUrlForAction(action, data) {
  const baseUrl = self.registration.scope;

  switch (action) {
    case "open_session":
      return `${baseUrl}#/exam/${data.sessionId}`;

    case "view_results":
      return `${baseUrl}#/results/${data.sessionId}`;

    case "view_achievements":
      return `${baseUrl}#/achievements`;

    case "view_leaderboard":
      return `${baseUrl}#/leaderboard`;

    case "open_practice":
      return `${baseUrl}#/practice`;

    case "view_analytics":
      return `${baseUrl}#/analytics`;

    default:
      return baseUrl;
  }
}

// ============================================================================
// NOTIFICATION CLOSE HANDLER
// ============================================================================

/**
 * Handle notification close events
 */
self.addEventListener("notificationclose", (event) => {
  console.log("[Service Worker] Notification closed:", event);

  // Optional: Send analytics about dismissed notifications
  const data = event.notification.data || {};

  // Send to analytics if available
  if (data.type) {
    console.log(`Notification dismissed: ${data.type}`);
  }
});

// ============================================================================
// SERVICE WORKER LIFECYCLE
// ============================================================================

/**
 * Service worker installation
 */
self.addEventListener("install", (event) => {
  console.log("[Service Worker] Installing...");
  self.skipWaiting();
});

/**
 * Service worker activation
 */
self.addEventListener("activate", (event) => {
  console.log("[Service Worker] Activating...");
  event.waitUntil(clients.claim());
});

/**
 * Handle messages from clients
 */
self.addEventListener("message", (event) => {
  console.log("[Service Worker] Message received:", event.data);

  if (event.data && event.data.type === "SKIP_WAITING") {
    self.skipWaiting();
  }
});

// ============================================================================
// PUSH EVENT HANDLER (Alternative to onBackgroundMessage)
// ============================================================================

/**
 * Handle push events directly (if onBackgroundMessage doesn't work)
 */
self.addEventListener("push", (event) => {
  console.log("[Service Worker] Push event received");

  if (!event.data) {
    console.log("[Service Worker] Push event had no data");
    return;
  }

  try {
    const payload = event.data.json();
    console.log("[Service Worker] Push payload:", payload);

    const notificationTitle = payload.notification?.title || "New Notification";
    const notificationOptions = {
      body: payload.notification?.body || "",
      icon: payload.notification?.icon || "/icons/Icon-192.png",
      badge: "/icons/Icon-192.png",
      tag: payload.data?.sessionId || "default",
      data: payload.data || {},
      actions: getNotificationActions(payload.data?.type),
    };

    event.waitUntil(
      self.registration.showNotification(notificationTitle, notificationOptions)
    );
  } catch (error) {
    console.error("[Service Worker] Error handling push event:", error);
  }
});

console.log("[Service Worker] Firebase Messaging Service Worker loaded");
