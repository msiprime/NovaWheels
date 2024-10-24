import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/core/routes/error_screen.dart';
import 'package:nova_wheels/core/routes/navbar.dart';
import 'package:nova_wheels/core/routes/place_holder_screen.dart';
import 'package:nova_wheels/core/routes/routes.dart';
import 'package:nova_wheels/features/home/presentation/pages/home_screen.dart';
import 'package:nova_wheels/features/landing/presentation/pages/landing_screen.dart';
import 'package:nova_wheels/features/onboarding/presentation/pages/onboarding_view.dart';
import 'package:nova_wheels/features/settings/presentation/pages/settings_screen.dart';
import 'package:nova_wheels/features/sign_in/presentation/pages/request_otp_page.dart';
import 'package:nova_wheels/features/sign_in/presentation/pages/reset_password_page.dart';
import 'package:nova_wheels/features/sign_in/presentation/pages/sign_in_screen.dart';
import 'package:nova_wheels/features/sign_in/presentation/pages/verify_otp_page.dart';
import 'package:nova_wheels/features/sign_up/presentation/pages/sign_up_screen.dart';
import 'package:nova_wheels/features/sign_up/presentation/widgets/otp_verification_widget.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/presentation/pages/create_store_screen.dart';
import 'package:nova_wheels/features/store/presentation/pages/manage_your_store_screen.dart';
import 'package:nova_wheels/features/store/presentation/pages/store_screen.dart';
import 'package:nova_wheels/features/store/presentation/widgets/general_store_details_widget.dart';
import 'package:nova_wheels/features/store/presentation/widgets/user_store_details.dart';

class RouteGenerator {
  RouteGenerator._();

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    errorBuilder: (context, state) {
      return const ErrorPage();
    },
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => '/${Routes.landing}',
      ),
      GoRoute(
        name: Routes.landing,
        path: '/${Routes.landing}',
        builder: (context, state) => const LandingScreen(),
      ),
      GoRoute(
        name: Routes.onboarding,
        path: '/${Routes.onboarding}',
        builder: (context, state) => const OnBoardingView(),
      ),
      GoRoute(
        name: Routes.signIn,
        path: '/${Routes.signIn}',
        builder: (context, state) => const SignInScreen(),
        routes: [
          // Forget password / Reset password / password recovery
          GoRoute(
            name: Routes.requestOtpPage,
            path: Routes.requestOtpPage,
            builder: (context, state) => const RequestOtpPage(),
            routes: [
              GoRoute(
                name: Routes.verifyOtpPage,
                path: Routes.verifyOtpPage,
                builder: (context, state) => const VerifyOtpPage(),
                routes: [
                  GoRoute(
                    name: Routes.resetPasswordPage,
                    path: Routes.resetPasswordPage,
                    builder: (context, state) => const ResetPasswordPage(),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            name: Routes.signUp,
            path: Routes.signUp,
            builder: (context, state) => const SignUpScreen(),
          ),
          GoRoute(
            name: Routes.verifyOtp,
            path: Routes.verifyOtp,
            builder: (context, state) => const OTPVerificationView(),
          ),
          GoRoute(
            name: Routes.introduction,
            path: Routes.introduction,
            builder: (context, state) => const OnBoardingView(),
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: Routes.home,
                path: Routes.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                  path: Routes.store,
                  name: Routes.store,
                  builder: (context, state) => const StoreScreen(),
                  routes: [
                    GoRoute(
                        path: Routes.manageStore,
                        name: Routes.manageStore,
                        builder: (context, state) =>
                            const ManageOwnedStoreScreen(),
                        routes: [
                          GoRoute(
                            path: Routes.userStoreDetails,
                            name: Routes.userStoreDetails,
                            builder: (context, state) => UserStoreDetails(
                              store: state.extra as StoreEntity,
                            ),
                          ),
                        ]),
                    GoRoute(
                      path: Routes.generalStoreDetails,
                      name: Routes.generalStoreDetails,
                      builder: (context, state) => GeneralStoreDetails(
                        store: state.extra as StoreEntity,
                      ),
                    ),
                    GoRoute(
                      path: Routes.createStore,
                      name: Routes.createStore,
                      builder: (context, state) => const CreateStoreScreen(),
                    ),
                  ]),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: Routes.addPost,
                path: Routes.addPost,
                builder: (context, state) => const PlaceHolderScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: Routes.profile,
                path: Routes.profile,
                builder: (context, state) => const PlaceHolderScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: Routes.settings,
                path: Routes.settings,
                builder: (context, state) => const SettingsScreen(),
                // builder: (context, state) => DebugPanel(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
