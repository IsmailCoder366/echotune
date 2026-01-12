import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../controller/hero_indicator_controller.dart';

class HeroHeader extends StatelessWidget {
  const HeroHeader({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(HeroIndicatorController());
    const double overlapOffset = 60.0;

    return Container(

      // This margin is the "Magic Fix".
      // It pushes the next widget down so it doesn't collide with the cards.
      margin: const EdgeInsets.only(bottom: overlapOffset + 40),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 1. BACKGROUND SECTION
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 80,
                bottom: overlapOffset + 20
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/colourfull_image.png'),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Essential: only take up needed space
              children: [
                const Text(
                  "Lorem ipsum dolor sit amet consectetur",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700
                  ),
                ),
                const SizedBox(height: 10),

                // THE MANUAL SCROLLABLE TEXT
                SizedBox(
                  height: 80, // Height to fit the 3 lines of text
                  child: PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: controller.onPageChanged,
                    itemCount: controller.totalSlides,
                    itemBuilder: (context, index) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Integer auctor cum urna malesuada. Venenatis magna sed tempor feugiat varius. Et tempus posuere consequat nulla convallis',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              height: 1.5,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 12),

                // MANUAL INDICATOR (Length 4)
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(controller.totalSlides, (index) {
                    bool isActive = controller.currentIndex.value == index;
                    return GestureDetector(
                      onTap: () => controller.jumpToPage(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: isActive ? 26 : 10, // Pill shape logic
                        decoration: BoxDecoration(
                          color: isActive ?  AppColors.primaryColor : Colors.white24,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    );
                  }),
                )),

                const SizedBox(height: 20),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Container(
                    height: 54,
                    padding: const EdgeInsets.only(left: 20, right: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: "Search Songs",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                        ),
                        Container(
                          width: 42,
                          height: 42,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.search, color: Colors.black, size: 22),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. OVERLAPPING CARDS
          Positioned(
            bottom: -overlapOffset,
            left: 16,
            right: 16,
            child: IntrinsicHeight(
              child: Row(
                children: const [
                  Expanded(
                    child: _UserTypeCard(
                      title: "Music/Content",
                      subtitle: 'Creator',
                      icon: Icons.mic_external_on,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _UserTypeCard(
                      title: "Music/Content",
                      subtitle: 'User',
                      icon: Icons.person_outline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserTypeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _UserTypeCard({
    super.key,
    required this.title,
    required this.icon,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // NO FIXED WIDTH HERE - Expanded parent handles it
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.orange, size: 28),
          const SizedBox(height: 12),
          // We wrap text in Flexible to ensure it wraps rather than overflows
          Flexible(
            child: Text(
              "$title\n$subtitle",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}