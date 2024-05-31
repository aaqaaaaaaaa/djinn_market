import 'package:bizda_bor/fuatures/auth/data/models/user_model.dart';
import 'package:bizda_bor/fuatures/auth/presentation/pages/login_page.dart';
import 'package:bizda_bor/fuatures/auth/presentation/pages/onboarding_page.dart';
import 'package:bizda_bor/fuatures/auth/presentation/pages/otp_page.dart';
import 'package:bizda_bor/fuatures/auth/presentation/pages/register_page.dart';
import 'package:bizda_bor/fuatures/auth/presentation/pages/splash_screen.dart';
import 'package:bizda_bor/fuatures/bottom_nav_bar.dart';
import 'package:bizda_bor/fuatures/cart/data/models/card_model.dart';
import 'package:bizda_bor/fuatures/cart/presentation/pages/cart_page.dart';
import 'package:bizda_bor/fuatures/cart/presentation/pages/checkout_page.dart';
import 'package:bizda_bor/fuatures/cart/presentation/pages/search_and_pick_map.dart';
import 'package:bizda_bor/fuatures/favourites/presentation/pages/favourites_page.dart';
import 'package:bizda_bor/fuatures/main/presentation/pages/main_page.dart';
import 'package:bizda_bor/fuatures/profile/data/models/order_model.dart';
import 'package:bizda_bor/fuatures/profile/presentation/edit_profile.dart';
import 'package:bizda_bor/fuatures/profile/presentation/order_detail.dart';
import 'package:bizda_bor/fuatures/profile/presentation/order_story.dart';
import 'package:bizda_bor/fuatures/profile/presentation/profile_page.dart';
import 'package:bizda_bor/fuatures/search/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static String get splashScreen => '/splashScreen';

  static String get onboardingPage => '/onboardingPage';

  static String get loginPage => '/loginPage';

  static String get registerPage => '/registerPage';

  static String get otpPage => '/otpPage';

  static String get mainPage => '/mainPage';

  static String get favoritesPage => '/favoritesPage';

  static String get searchPage => '/searchPage';

  static String get chartPage => '/chartPage';

  static String get checkoutPage => '/checkoutPage';

  static String get profilePage => '/profilePage';

  static String get editProfile => 'editProfile';

  static String get orderHistory => 'orderHistory';

  static String get orderDetail => 'orderDetail';

  static String get searchAndPick => 'searchAndPick';
}

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');
final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.splashScreen,
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Routes.splashScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Routes.onboardingPage,
      builder: (BuildContext context, GoRouterState state) {
        return const OnboaringPage();
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Routes.loginPage,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Routes.otpPage,
      builder: (BuildContext context, GoRouterState state) {
        return const OtpPage();
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '${Routes.checkoutPage}/:totalPrice',
      name: Routes.checkoutPage,
      builder: (BuildContext context, GoRouterState state) {
        return CheckOutPage.screen(
          state.extra as List<GetCardModel>,
          num.parse(state.pathParameters['totalPrice'] ?? '0'),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      name: Routes.registerPage,
      path: "${Routes.registerPage}/:userId",
      builder: (BuildContext context, GoRouterState state) {
        return RegisterPage(
          userId: int.parse(state.pathParameters['userId'] ?? '0'),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Routes.otpPage,
      builder: (BuildContext context, GoRouterState state) {
        return const OtpPage();
      },
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return BottomNavBar(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: Routes.mainPage,
          builder: (BuildContext context, GoRouterState state) {
            return MainPage.screen();
          },
          routes: const <RouteBase>[
            // GoRoute(
            //   path: 'brendData',
            //   builder: (BuildContext context, GoRouterState state) {
            //     return BrendDataPage(
            //       brand: state.extra as BrendModel,
            //     );
            //   },
            // ),
          ],
        ),
        GoRoute(
            path: Routes.favoritesPage,
            builder: (BuildContext context, GoRouterState state) {
              return FavouritesPage.screen();
            },
            routes: const [
              // GoRoute(
              //   name: 'searchAndPick',
              //   path: 'searchAndPick',
              //   builder: (BuildContext context, GoRouterState state) {
              //     return const SearchAndPickMap();
              //   },
              // ),
            ]),
        GoRoute(
          path: Routes.searchPage,
          builder: (BuildContext context, GoRouterState state) {
            return const SearchPage();
          },
          routes: const <RouteBase>[
            // GoRoute(
            //   path: 'clientHistory',
            //   builder: (BuildContext context, GoRouterState state) {
            //     return const ClientHistory();
            //   },
            // ),
          ],
        ),
        GoRoute(
          path: Routes.chartPage,
          builder: (BuildContext context, GoRouterState state) {
            return CartPage.screen();
          },
          routes: <RouteBase>[
            GoRoute(
              name: Routes.searchAndPick,
              path: Routes.searchAndPick,
              builder: (BuildContext context, GoRouterState state) {
                return const SearchAndPickMap();
              },
            ),
          ],
        ),
        GoRoute(
          path: Routes.profilePage,
          builder: (BuildContext context, GoRouterState state) {
            return const ProfilePage();
          },
          routes: <RouteBase>[
            GoRoute(
              name: Routes.editProfile,
              path: Routes.editProfile,
              builder: (BuildContext context, GoRouterState state) {
                return EditProfilePage.screen(
                    userModel: state.extra as UserData);
              },
            ),
            GoRoute(
              name: Routes.orderHistory,
              path: Routes.orderHistory,
              builder: (BuildContext context, GoRouterState state) {
                return OrderStoryPage.screen();
              },
            ),
            GoRoute(
              name: Routes.orderDetail,
              path: Routes.orderDetail,
              builder: (BuildContext context, GoRouterState state) {
                return OrderDetailPage(
                  orderModel: state.extra as OrderModel,
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);

int calculateSelectedIndex(BuildContext context) {
  final String location = GoRouterState.of(context).uri.toString();
  if (location.startsWith(Routes.mainPage)) {
    return 0;
  }
  if (location.startsWith(Routes.favoritesPage)) {
    return 1;
  }
  if (location.startsWith(Routes.searchPage)) {
    return 2;
  }
  if (location.startsWith(Routes.chartPage)) {
    return 3;
  }
  if (location.startsWith(Routes.profilePage)) {
    return 4;
  }
  return 0;
}

void onItemTapped(int index, BuildContext context) {
  switch (index) {
    case 0:
      GoRouter.of(context).go(Routes.mainPage);
      break;
    case 1:
      GoRouter.of(context).go(Routes.favoritesPage);
      break;
    case 2:
      GoRouter.of(context).go(Routes.searchPage);
      break;
    case 3:
      GoRouter.of(context).go(Routes.chartPage);
      break;
    case 4:
      GoRouter.of(context).go(Routes.profilePage);
      break;
  }
}
