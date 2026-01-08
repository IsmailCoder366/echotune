
import 'package:echotune/modules/landing/view/widgets/custom_appbar.dart';
import 'package:echotune/modules/landing/view/widgets/custom_footer.dart';
import 'package:echotune/modules/landing/view/widgets/features_section.dart';
import 'package:echotune/modules/landing/view/widgets/header_section.dart';
import 'package:echotune/modules/landing/view/widgets/manage_feature_section.dart';
import 'package:echotune/modules/landing/view/widgets/testimonial_section.dart';
import 'package:echotune/modules/landing/view/widgets/trusted_logo_grid.dart';
import 'package:flutter/material.dart';


class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Key property for hero backgrounds
      appBar: const CustomAppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeroHeader(),
            const FeaturedSection(),
            const TrustLogoGrid(),
            const ManagementFeatureSection(),
            const TestimonialSection(),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }
}
