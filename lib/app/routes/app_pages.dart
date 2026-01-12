import 'package:echotune/modules/auth/reset_password/view/reset_password_view.dart';
import 'package:echotune/modules/auth/view/create_account.dart';
import 'package:echotune/modules/auth/view/forgot_password_screen.dart';
import 'package:echotune/modules/auth/view/otp_verification_view.dart';
import 'package:echotune/modules/auth_check/view/auth_check_view.dart';
import 'package:echotune/modules/user/view/user_home_screen.dart';
import 'package:get/get.dart';
import '../../modules/auth/password_changed/view/password_changed_view.dart';
import 'app_routes.dart';
import '../../modules/landing/view/landing_view.dart';
import '../../modules/auth/view/login_view.dart';
import '../../modules/creator/view/creator_dashboard_view.dart';

class AppPages {
  static final pages = [

    /// LANDING PAGE FLOW
    GetPage(name: Routes.landing, page: () => const LandingView()),

    /// AUTH FLOW
    GetPage(name: Routes.login, page: () => const LoginScreen()),
    GetPage(name: Routes.createAccount, page: () => const CreateAccountScreen()),
    GetPage(name: Routes.forgotPassword, page: () => const ForgotPasswordView()),
    GetPage(name: Routes.otpScreen, page: () => const OtpVerificationView()),
    GetPage(name: Routes.resetPasswordScreen, page: () => const ResetPasswordView()),
    GetPage(name: Routes.passwordChanged, page: () => const PasswordChangedView()),

    /// AUTH CHECK VIEW FLOW
    GetPage(name: Routes.authCheck, page: () => const AuthCheckView()),

    /// USER FLOW
    GetPage(name: Routes.userHome, page: () => const UserHomeScreen()),
    GetPage(name: Routes.creatorHome, page: () => const CreatorDashboardView()),
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
