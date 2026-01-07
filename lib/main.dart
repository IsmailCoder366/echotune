import 'package:echotune/modules/landing/view/landing_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 822), // change based on your base design
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'EchoTune',

          /// --------------------------
          /// Named Routing with GetX
          /// --------------------------
          initialRoute: '/landing',

          getPages: [
            GetPage(
              name: '/landing',
              page: () => const LandingView(),
            ),
            // add more routes here
            // GetPage(name: '/login', page: () => const LoginView()),
          ],

          /// --------------------------
          /// Theme + Font Family
          /// --------------------------
            theme: ThemeData(
              textTheme: GoogleFonts.poppinsTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
          home: child,
        );
      },

      child: const LandingView(),
    );
  }
}
