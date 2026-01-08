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
      designSize: const Size(375, 822),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'EchoTune',

          initialRoute: '/landing',

          getPages: [
            GetPage(
              name: '/landing',
              page: () => const LandingView(),
            ),
          ],

          /// --------------------------
          /// Theme + Two Google Fonts
          /// --------------------------
          theme: ThemeData(
            // Default app font → Poppins
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ).copyWith(
              // Headlines → Montserrat
              headlineLarge: GoogleFonts.montserrat(
                fontSize: 32.sp,
                fontWeight: FontWeight.w700,
              ),
              headlineMedium: GoogleFonts.montserrat(
                fontSize: 26.sp,
                fontWeight: FontWeight.w700,
              ),
              headlineSmall: GoogleFonts.montserrat(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),

              // Titles (cards, buttons, etc.)
              titleMedium: GoogleFonts.montserrat(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),

              // Body remains Poppins (already set above)
            ),
          ),

          home: child,
        );
      },

      child: const LandingView(),
    );
  }
}
