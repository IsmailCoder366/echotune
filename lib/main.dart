import 'package:echotune/modules/landing/view/landing_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'core/services/auth_services.dart';

void main() async{
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  // Register AuthService globally
  Get.put(AuthService(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 822),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'EchoTune',
          initialRoute: Routes.authCheck,
          getPages: AppPages.pages,

          /// --------------------------
          /// Theme + Two Google Fonts
          /// --------------------------
          theme: ThemeData(
            // Default app font → Poppins
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            )
          ),

          home: child,
        );
      },

      child: const LandingView(),
    );
  }
}
