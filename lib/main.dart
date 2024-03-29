import 'package:elssit/core/utils/color_constant.dart';
import 'package:elssit/presentation/account_screen/account_screen.dart';
import 'package:elssit/presentation/achievement_screen/achievement_detail_screen.dart';
import 'package:elssit/presentation/achievement_screen/achievement_screen.dart';
import 'package:elssit/presentation/achievement_screen/add_new_achievement_screen.dart';
import 'package:elssit/presentation/bottom_bar_navigation/bottom_bar_navigation.dart';

import 'package:elssit/presentation/certification_screen/widgets/add_new_certification_screen.dart';
import 'package:elssit/presentation/certification_screen/widgets/certification_detail_screen.dart';
import 'package:elssit/presentation/certification_screen/certification_screen.dart';

import 'package:elssit/presentation/contact_detail_screen/contact_detail_screen.dart';
import 'package:elssit/presentation/education_screen/education_screen.dart';
import 'package:elssit/presentation/education_screen/widgets/add_new_education_screen.dart';
import 'package:elssit/presentation/forgot_password_screen/forgot_password_screen.dart';
import 'package:elssit/presentation/indentification_information_screen/indentification_information_screen.dart';
import 'package:elssit/presentation/loading_screen/loading_screen.dart';
import 'package:elssit/presentation/onboarding_screen/onboarding_screen.dart';
import 'package:elssit/presentation/package_screen.dart/package_screen.dart';
import 'package:elssit/presentation/schedule_screen/schedule_screen.dart';
import 'package:elssit/presentation/service_screen/service_detail_screen.dart';
import 'package:elssit/presentation/sign_up_screen/sign_up_screen.dart';
import 'package:elssit/presentation/widget/dialog/custom_checkbox.dart';
import 'package:elssit/presentation/work_experience_screen/widgets/add_new_work_experience_screen.dart';
import 'package:elssit/presentation/work_experience_screen/widgets/work_experience_detail_screen.dart';
import 'package:elssit/presentation/work_experience_screen/work_experience_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'core/utils/globals.dart' as globals;
import 'fire_base/login_with_google_nav.dart';
import 'fire_base/provider/google_sign_in_provider.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

void showFlutterNotificationForgeround(RemoteMessage message) {
  // print(message.data);
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title!,
      notification.body!,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  var box = await Hive.openBox('elsBox');
  await Firebase.initializeApp();
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  String? token = await FirebaseMessaging.instance.getToken();
  globals.deviceID = token.toString();
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _elsBox = Hive.box('elsBox');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.onMessage.listen(showFlutterNotificationForgeround);
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          initialRoute: '/',
          routes: <String, WidgetBuilder>{
            '/': (context) => (_elsBox.get('isOpened') == null)
                ? const OnboardingScreen()
                : const LoginWithGoogleNav(),
            '/loginWithGoogleNav': (context) => const LoginWithGoogleNav(),
            '/forgotPasswordScreen': (context) => const ForgotPasswordScreen(),
            '/signUpScreen': (context) => const SignupScreen(),
            '/homeScreen': (context) =>
                BottomBarNavigation(selectedIndex: 0, isBottomNav: true),
            '/scheduleScreen': (context) =>
                BottomBarNavigation(selectedIndex: 2, isBottomNav: true),
            '/accountScreen': (context) =>
                BottomBarNavigation(selectedIndex: 3, isBottomNav: true),
            '/contactDetailScreen': (context) => const ContactDetailScreen(),
            '/indentificationInformationScreen': (context) =>
                const IndentificationInformationScreen(),
            '/educationScreen': (context) => const EducationScreen(),
            '/addNewEducationScreen': (context) =>
                const AddNewEducationScreen(),
            '/certificationScreen': (context) => const CertificationScreen(),
            '/addNewCertificationScreen': (context) =>
                const AddNewCertificationScreen(),
            // '/addNewAchievementScreen': (context) =>
            //     const AddNewAchievementScreen(),
            // '/achievementScreen': (context) => const AchievementScreen(),
            '/addNewWorkExperienceScreen': (context) =>
                const AddNewWorkExperienceScreen(),
            '/workExperienceScreen': (context) => const WorkExperienceSreen(),

            '/packageScreen': (context) => const PackageScreen(),
            '/serviceDetailScreen': (context) => const ServiceDetailScreen(),
          },
        ),
      );
}
