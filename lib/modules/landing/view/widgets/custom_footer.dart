
import 'package:flutter/material.dart';

import '../../../../common/constants/app_colors.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF121212),
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
      child: Column(
        children: [
          // 1. BRAND HEADER & SOCIAL ICONS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "ECHOTUNE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    "Your Sound Your World",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Row(
                children: const [
                  Icon(Icons.alternate_email, color: Colors.white, size: 22), // Twitter/X replacement
                  SizedBox(width: 15),
                  Icon(Icons.camera_alt_outlined, color: Colors.white, size: 22),
                  SizedBox(width: 15),
                  Icon(Icons.email_outlined, color: Colors.white, size: 22),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),

          // 2. PRIMARY NAVIGATION ROW
          const Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            children: [
              _FooterNavLink(title: "Register"),
              _FooterNavLink(title: "Request"),
              _FooterNavLink(title: "Login"),
              _FooterNavLink(title: "About us"),
              _FooterNavLink(title: "Contact"),
              _FooterNavLink(title: "Others"),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.white10),
          const SizedBox(height: 20),

          // 3. FIXED SEARCH BAR (Using BoxConstraints for maxWidth)
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

          const SizedBox(height: 30),

          // 4. SECONDARY LINKS ROW
          const Wrap(
alignment: .center,
            spacing: 10,

            children: [
              _PolicyLink(title: "Purchase Flow"),
              _PolicyLink(title: "Terms and Conditions"),
              _PolicyLink(title: "Privacy Policy"),
              _PolicyLink(title: "Refund and Cancellation"),
            ],
          ),

          const SizedBox(height: 40),

          // 5. COPYRIGHT SECTION
          const Divider(color: Colors.white10),
          const SizedBox(height: 20),
          const Text(
            "Copyright © 2024. All Rights Reserved. Design And Developed by webnox.in.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

// Helper Widgets to keep the code clean
class _FooterNavLink extends StatelessWidget {
  final String title;
  const _FooterNavLink({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
    );
  }
}

class _PolicyLink extends StatelessWidget {
  final String title;
  const _PolicyLink({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(color: Colors.white, fontSize: 10),
    );
  }
}