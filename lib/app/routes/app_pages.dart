import 'package:get/get.dart';
import 'app_routes.dart';

import '../../modules/landing/view/landing_view.dart';
import '../../modules/auth/view/login_view.dart';

import '../../modules/user/view/explore_view.dart';
import '../../modules/user/view/profile_view.dart';
import '../../modules/creator/view/creator_dashboard_view.dart';
import '../../modules/creator/view/upload_view.dart';

class AppPages {
  static final pages = [

    GetPage(
      name: Routes.landing,
      page: () => const LandingView(),
    ),

    // GetPage(
    //   name: Routes.login,
    //   page: () => const LoginView(),
    // ),
    //
    // // USER FLOW
    // GetPage(
    //   name: Routes.userHome,
    //   page: () => const UserHomeView(),
    // ),
    //
    // GetPage(
    //   name: Routes.explore,
    //   page: () => const ExploreView(),
    // ),
    //
    // GetPage(
    //   name: Routes.profile,
    //   page: () => const ProfileView(),
    // ),
    //
    // // CREATOR FLOW
    // GetPage(
    //   name: Routes.creatorHome,
    //   page: () => const CreatorDashboardView(),
    // ),
    //
    // GetPage(
    //   name: Routes.upload,
    //   page: () => const UploadView(),
    // ),
  ];
}
