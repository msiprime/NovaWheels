import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/core/routes/error_screen.dart';
import 'package:nova_wheels/core/routes/navbar.dart';
import 'package:nova_wheels/core/routes/place_holder_screen.dart';
import 'package:nova_wheels/core/routes/routes.dart';
import 'package:nova_wheels/features/home/presentation/pages/home_screen.dart';
import 'package:nova_wheels/features/landing/presentation/pages/landing_screen.dart';
import 'package:nova_wheels/features/nova_wheels_ai/pages/ai_prompt_screen.dart';
import 'package:nova_wheels/features/onboarding/presentation/pages/onboarding_view.dart';
import 'package:nova_wheels/features/settings/presentation/pages/settings_screen.dart';
import 'package:nova_wheels/features/sign_in/presentation/pages/request_otp_page.dart';
import 'package:nova_wheels/features/sign_in/presentation/pages/reset_password_page.dart';
import 'package:nova_wheels/features/sign_in/presentation/pages/sign_in_screen.dart';
import 'package:nova_wheels/features/sign_in/presentation/pages/verify_otp_page.dart';
import 'package:nova_wheels/features/sign_up/presentation/pages/sign_up_screen.dart';
import 'package:nova_wheels/features/sign_up/presentation/widgets/otp_verification_widget.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/presentation/public/public_store/view/public_store_screen.dart';
import 'package:nova_wheels/features/store/presentation/user/user_store_create/view/create_store_screen.dart';
import 'package:nova_wheels/features/store/presentation/user/user_store_fetch/view/user_stores_screen.dart';
import 'package:nova_wheels/features/store/presentation/user/user_store_fetch/widget/user_store_details_widget.dart';
import 'package:nova_wheels/features/store/presentation/user/user_store_update/view/user_store_update_page.dart';
import 'package:nova_wheels/features/store/shared/widget/general_store_details_widget.dart';

import '../../features/vehicle/presentation/post_vehicle_ad/view/add_vehicle_screen.dart';

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
                  routes: [
                    GoRoute(
                      path: AiPromptScreen.routeName,
                      name: AiPromptScreen.routeName,
                      builder: (context, state) => const AiPromptScreen(),
                    ),
                  ]),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                  path: Routes.store,
                  name: Routes.store,
                  builder: (context, state) => const PublicStoreScreen(),
                  routes: [
                    GoRoute(
                      path: Routes.userStores,
                      name: Routes.userStores,
                      builder: (context, state) => const UserStoresScreen(),
                      routes: [
                        GoRoute(
                          path: Routes.userStoreDetails,
                          name: Routes.userStoreDetails,
                          builder: (context, state) => UserStoreDetails(
                            store: state.extra as StoreEntity,
                          ),
                          routes: [
                            GoRoute(
                              path: UserStoreUpdatePage.routeName,
                              name: UserStoreUpdatePage.routeName,
                              builder: (context, state) => UserStoreUpdatePage(
                                storeId: state.extra as String,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                name: PostVehicleAdScreen.routeName,
                path: PostVehicleAdScreen.routeName,
                builder: (context, state) => const PostVehicleAdScreen(),
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
