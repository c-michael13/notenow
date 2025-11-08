import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_now/firebase_options.dart';
import 'package:note_now/view/onboarding/screens/splash_screen.dart';
import 'package:note_now/view_model/constants/app_color.dart';
import 'package:note_now/view_model/core/router/router_configuration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProviver);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'App Colors Demo',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        
      ),
      routerConfig: router,
    );
  }
}