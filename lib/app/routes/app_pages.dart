import 'package:echotune/modules/auth/reset_password/view/reset_password_view.dart';
import 'package:echotune/modules/auth/create_account/view/create_account.dart';
import 'package:echotune/modules/auth/forgot_password/view/forgot_password_screen.dart';
import 'package:echotune/modules/auth/otp_verification/view/otp_verification_view.dart';

import 'package:echotune/modules/creator/Bottom_navigation_screen/view/creator_main_view.dart';
import 'package:echotune/modules/creator/complain/view/complain_view.dart';
import 'package:echotune/modules/creator/content_upload_view/view/content_upload_view.dart';
import 'package:echotune/modules/creator/music_upload/view/music_upload_view.dart';
import 'package:echotune/modules/user/purchases/view/purchases_view.dart';
import 'package:get/get.dart';
import '../../modules/auth/password_changed/view/password_changed_view.dart';

import '../../modules/user/explore/views/explore_view.dart';
import '../../modules/user/home_screen/view/home_screen.dart';
import 'app_routes.dart';
import '../../modules/landing/view/landing_view.dart';
import '../../modules/auth/login/view/login_view.dart';

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


    /// USER FLOW
    GetPage(name: Routes.userHome, page: () =>  UserHomeScreen()),
    GetPage(name: Routes.userPurchases, page: () => PurchasesView()),
    /// CREATOR FLOW
    GetPage(
      name: Routes.explore,
      page: () =>  ExploreView(),
    ),
    //

    //
    // CREATOR FLOW
    GetPage(
      name: Routes.creatorMainScreen,
      page: () =>  CreatorMainScreen(),
    ),
    //
    GetPage(
      name: Routes.uploadMusic,
      page: () => const MusicUploadView(),
    ),
    GetPage(
      name: Routes.uploadContent,
      page: () => const ContentUploadView(),
    ),
    GetPage(
      name: Routes.complainScreen,
      page: () => const ComplainView(),
    ),
  ];
}
