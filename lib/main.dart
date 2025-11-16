import 'package:ahiaa_web/bloc_providers.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:flutter/foundation.dart';
// import 'package:ahiaa_web/firebase_options.dart';
// import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:timezone/browser.dart' as tz;
import 'app.dart';


Future<void> main() async {
  // ensure that widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    usePathUrlStrategy();
  }
  // Initialize dependency injection
  await configureDependencies();

  // Iniitialize Getx local storage
  GetStorage.init();
  // remove the # sign from url
  // setPathUrlStrategy();.

  // Initialize timezone for scheduled notifications
  await tz.initializeTimeZone();
  tz.setLocalLocation(tz.getLocation('Africa/Lagos')); 

  // initialize firebase & authentication repository
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
  //     .then((value) => );
// Get.put(AuthenticationRepository());
  // run app
  // runApp(DevicePreview(builder: (context) => const App()));
  runApp(MultiBlocProvider(
    providers: AppBlocProviders.blocProviders,
    child: const App(),
  ));
}

// alright,  a major part of the app is using the agentic capability. below is the system prompt and gemini tools. going deep you will understand its functionality. but i want you to create one and tailor it to our current app built. this time the AI's name is coach kai. while tailoring it, and rewriting the 2 files to follow the projects use case take note of this things 

// coachkai will be the one setting the questions, and will follow the guidelines of the exam body, and should set question at there standard, and if need be, use data from previous years, to set this questions, and try to avoid repition of questions. all exam paper will come with there questions and answer, andwill be used to grade the student, to avoid calling the agent for every questions. e.g if the esam paper is math, the agent fetches the question in the format you have been working with so far. you will use the files you've created earlier as point of refernce. the Ai won't have to grade the exams, but the answers it provided will be used to grade it. 

// also, all questions will be stored in the db as soon as they are fetched and in the local storage for 5 days, this is to provide backup incase students choose to revisit the questions later.

// for the exam, the exam result, will be sent back to the AI to analyse performance, and provide insights, weak areas etc, so it will be saved in the user data, these will be used as apoint of reference in future exams.

// Also the AI is not just for exams, but as a coach, serves a teacher, educator and guide to any student using the platform. the coach can provide fullnotes, answers to question, guidelines, timetable, personalised tutorial, etc that will assist students preparing for the exam.

// also add instructions and suggestions you deem fit for the success of this project. and then note that, the exam progress, is by exampaper, and the number of questions answered, unanswered, and skipped is saved. update that later in the model, firebase, supabase services too.



// look at this system_md and gemini tools files, the are files for AI agents for my WAEC projects. I want you to update somethings in them using the reference files I will give. now remove the Ids since the agent is not making any direct call to the DB to update anything.  an instance is in the generate_exam_questions, the subject_id, should be replaced with subject(actual subject name), topic_ids, should be topics, same with the other tools, user id should be user(string, thats the users name). 