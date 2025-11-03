class KRoutes {
  // CORE & NAVIGATION ROUTES (These constants use the 'name' from AppRouter)
  static const landing = 'landing';
  static const onboarding = 'onboarding';
  static const auth = 'auth';


  static const home = 'home';
  static const dashboard = 'dashboard';

  static const myTests = 'my_tests';
  static const practiceExam = 'practice_exam';
  static const examInstruct = 'examInstruction';
  static const result = 'result';

  static const mainExamScreen = 'mainExamScreen';

  static const analytics = 'analytics';
  static const subscriptions = 'subscriptions';
  static const notifications = 'notifications';
  static const settings = 'settings';
  static const help = 'help';
  static const loading = 'loading';

  // AUTHENTICATION ROUTES (These constants use the 'name' from AppRouter)
  // static const auth = 'auth'; // The container screen for auth flows
  static const login = 'login';
  static const register = 'register';
  static const forgotPassword = 'forgot_password'; // Replaces old 'forgetPassword'

  // LIST OF SIDEBAR MENU ITEMS 
  // (Using the GoRouter names for navigation in the UI, assuming these are the main menu links)
  static List sidebarMenuItems = [
    home,
    myTests,
    practiceExam,
    analytics,
    subscriptions,
    notifications,
    settings,
    help,
  ];
}
