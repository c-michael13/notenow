import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:note_now/view/authentication/screens/login.dart';
import 'package:note_now/view/authentication/screens/username.dart';
import 'package:note_now/view/onboarding/screens/onboarding.dart';
import 'package:note_now/view/onboarding/screens/splash_screen.dart';
import 'package:note_now/view/pages/home_page.dart';
import 'package:note_now/view/pages/note_taking.dart';

final routerProviver = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      // Define your routes here
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/username',
        builder:(context, state) => const UsernamePage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/note_taking',
        builder: (context, state) => const NoteDetailsScreen(),
      )
    ],
  );
}
);