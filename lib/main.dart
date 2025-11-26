import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_care_application/constants/string_constants.dart';
import 'package:health_care_application/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:health_care_application/features/auth/data/repository/auth_repository_impl.dart';
import 'package:health_care_application/features/auth/presentation/providers/authentication_provider.dart';
import 'package:health_care_application/features/auth/presentation/screens/auth_gate.dart';
import 'package:health_care_application/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:health_care_application/features/chatbot/data/data_source/chat_data_source.dart';
import 'package:health_care_application/features/chatbot/data/repository/chat_repository_impl.dart';
import 'package:health_care_application/features/disease_detector/data/data_source/remote/diabetes_disease_remote_data_source.dart';
import 'package:health_care_application/features/disease_detector/data/data_source/remote/heart_disease_remote_data_source.dart';
import 'package:health_care_application/features/disease_detector/data/data_source/remote/neurological_disease_data_source.dart';
import 'package:health_care_application/features/disease_detector/data/data_source/remote/symptom_to_disease_remote_data_source.dart';
import 'package:health_care_application/features/disease_detector/data/repository/diabetes_disease_repository_impl.dart';
import 'package:health_care_application/features/disease_detector/presentation/providers/disease_detector_provider.dart';
import 'package:health_care_application/features/doctor/data/data_source/remote/doctor_remote_data_source.dart';
import 'package:health_care_application/features/doctor/data/respository/doctor_repository_impl.dart';
import 'package:health_care_application/features/doctor/presentation/providers/doctor_provider.dart';
import 'package:health_care_application/features/ocr/presentation/providers/picked_image_provider.dart';
import 'package:health_care_application/features/profile/data/data_source/remote/profile_remote_data_source.dart';
import 'package:health_care_application/features/profile/data/repository/profile_repository_impl.dart';
import 'package:health_care_application/features/profile/presentation/providers/profile_provider.dart';
import 'package:health_care_application/features/splash/presentation/screens/splash_screen.dart';
import 'package:health_care_application/firebase_options.dart';
import 'package:health_care_application/theme/theme.dart';
import 'package:provider/provider.dart';

import 'features/chatbot/presentation/providers/chat_provider.dart';
import 'features/disease_detector/data/repository/heart_disease_repository_impl.dart';
import 'features/disease_detector/data/repository/neurological_disease_repository_impl.dart';
import 'features/disease_detector/data/repository/symptom_to_disease_repository_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // ✅ Prevent duplicate init
  if (Firebase.apps.isEmpty) {
    // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  final profileRemoteDataSource = ProfileRemoteDataSource();
  final profileRepository = ProfileRepositoryImpl(
    profileRemoteDataSource: profileRemoteDataSource,
  );
  final authRemoteDataSource = AuthRemoteDataSource(
    profileRepository: profileRepository,
  );
  final authRepository = AuthRepositoryImpl(
    authRemoteDataSource: authRemoteDataSource,
  );
  final chatDataSource = ChatDataSource(apiKey: geminiAPIKey);
  final chatRepository = ChatRepositoryImpl(chatBotDataSource: chatDataSource);
  final doctorRemoteDataSource = DoctorRemoteDataSource();
  final doctorRepository = DoctorRepositoryImpl(
    doctorRemoteDataSource: doctorRemoteDataSource,
  );
  final heartDiseaseRemoteDataSource = HeartDiseaseRemoteDataSource();
  final heartDiseaseRepository = HeartDiseaseRepositoryImpl(
    heartDiseaseRemoteDataSource: heartDiseaseRemoteDataSource,
  );
  final neurologicalDiseaseRemoteDataSource = NeurologicalDiseaseDataSource();
  final neurologicalDiseaseRepository = NeurologicalDiseaseRepositoryImpl(
    neurologicalDiseaseDataSource: neurologicalDiseaseRemoteDataSource,
  );

  final diabetesDiseaseRemoteDataSource = DiabetesDiseaseRemoteDataSource();
  final diabetesDiseaseRepository = DiabetesDiseaseRemoteRepositoryImpl(
    diabetesDiseaseRemoteDataSource: diabetesDiseaseRemoteDataSource,
  );

  final symptomToDiseaseRemoteDataSource = SymptomToDiseaseRemoteDataSource();
  final symptomToDiseaseRepository = SymptomToDiseaseRepositoryImpl(
    symptomToDiseaseRemoteDataSource: symptomToDiseaseRemoteDataSource,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:
              (context) =>
                  AuthenticationProvider(authRepository: authRepository),
        ),
        ChangeNotifierProvider(create: (context) => PickedImageProvider()),
        ChangeNotifierProvider(
          create:
              (context) =>
                  ProfileProvider(profileRepository: profileRepository),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatProvider(chatRepository: chatRepository),
        ),
        ChangeNotifierProvider(
          create:
              (context) => DoctorProvider(doctorRepository: doctorRepository),
        ),
        ChangeNotifierProvider(
          create:
              (context) => DiseaseDetectorProvider(
                heartDiseaseRepository: heartDiseaseRepository,
                neurologicalDiseaseRepository: neurologicalDiseaseRepository,
                diabetesDiseaseRepository: diabetesDiseaseRepository,
                symptomToDiseaseRepository: symptomToDiseaseRepository,
              ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

final messengerKey = GlobalKey<ScaffoldMessengerState>();
final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: _routes,
        theme: MaterialTheme(TextTheme()).light(),
        darkTheme: MaterialTheme(TextTheme()).dark(),
        scaffoldMessengerKey: messengerKey,
        navigatorKey: navigatorKey,
        home: SplashScreen(),
      ),
    );
  }

  Map<String, Widget Function(BuildContext)> get _routes => {
    '/authGate': (context) => AuthGate(),
    '/forgotPassword': (context) => ForgotPasswordScreen(),
  };
}
