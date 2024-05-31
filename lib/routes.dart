// import 'package:bizda_bor/fuatures/auth/presentation/pages/login_page.dart';
// import 'package:bizda_bor/fuatures/auth/presentation/pages/register_page.dart';
// import 'package:bizda_bor/fuatures/main/presentation/pages/main_page.dart';
// import 'package:bizda_bor/fuatures/onboarding/presenatation/pages/second_onboarding_page.dart';
// import 'package:bizda_bor/fuatures/onboarding/presenatation/pages/onboarding_page.dart';
// import 'package:flutter/material.dart';

// class Routes {
//   static const onboardingPage = '/';
//   static const secondOnboardingPage = '/secondOnboardingPage';
//   static const homePage = '/homePage';
//   static const mainPage = '/mainPage';
//   static const loginPage = '/loginPage';


//   static Route<dynamic> generateRoute(RouteSettings routeSettings) {
//     try {
//       final Map<String, dynamic>? args =
//           routeSettings.arguments as Map<String, dynamic>?;
//       args ?? <String, dynamic>{};
//       switch (routeSettings.name) {
//         case onboardingPage:
//           return MaterialPageRoute(
//             settings: routeSettings,
//             builder: (_) => const OnboardingPage(),
//           );
//         case secondOnboardingPage:
//           return MaterialPageRoute(
//             settings: routeSettings,
//             builder: (_) => const SecondOnboaringPage(),
//           );
//         case mainPage:
//           return MaterialPageRoute(
//             settings: routeSettings,
//             builder: (_) => const MainPage(),
//           );
//         // case loginPage:
//         //   return MaterialPageRoute(
//         //     settings: routeSettings,
//         //     builder: (_) => const LoginPage(),
//         //   );
//         default:
//           return MaterialPageRoute(
//             settings: routeSettings,
//             builder: (_) => const OnboardingPage(),
//           );
//       }
//     } catch (e) {
//       return MaterialPageRoute(
//         settings: routeSettings,
//         builder: (_) => const OnboardingPage(),
//       );
//     }
//   }
// }
