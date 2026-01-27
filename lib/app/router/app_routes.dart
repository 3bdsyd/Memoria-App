import 'package:flutter/material.dart';
import 'package:memoria/features/restoration/presentation/pages/choose_photo_page.dart';
import 'package:memoria/features/restoration/presentation/pages/home_page.dart';
import 'package:memoria/features/restoration/presentation/pages/onboarding_page.dart';
import 'package:memoria/features/restoration/presentation/pages/processing_page.dart';
import 'package:memoria/features/restoration/presentation/pages/splash_page.dart';

import '../../features/restoration/presentation/pages/preview_page.dart';
import '../../features/restoration/presentation/pages/result_page.dart';
import '../../features/restoration/presentation/pages/comparison_page.dart';

class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const choosePhoto = '/choose';
  static const preview = '/preview';
  static const processing = '/processing';
  static const result = '/result';
  static const compare = '/compare';
  static const historyDetail = '/history-detail';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case choosePhoto:
        return MaterialPageRoute(builder: (_) => const ChoosePhotoPage());
      case preview:
        final args = settings.arguments as PreviewArgs;
        return MaterialPageRoute(builder: (_) => PreviewPage(imagePath: args.imagePath,));
      case processing:
        return MaterialPageRoute(builder: (_) => const ProcessingPage());
      case result:
        return MaterialPageRoute(builder: (_) => const ResultPage());
      case compare:
        return MaterialPageRoute(builder: (_) => const ComparisonPage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}

class PreviewArgs {
  const PreviewArgs({required this.imagePath});
  final String imagePath;
}
