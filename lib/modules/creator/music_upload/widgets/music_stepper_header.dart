import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/upload_music_controller.dart';

class MusicStepperHeader extends StatelessWidget {
  final MusicUploadController controller = Get.find();

  MusicStepperHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      color: Colors.white,
      child: Row(
        children: [
          _buildStep(0, "Song information"),
          const SizedBox(width: 8),
          _buildStep(1, "Song links"),
          const SizedBox(width: 8),
          _buildStep(2, "Source"),
        ],
      ),
    ));
  }

  Widget _buildStep(int index, String title) {
    bool isCompleted = controller.completedSteps.contains(index);
    bool isActive = controller.currentStep.value == index;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        decoration: BoxDecoration(
          // Green background if completed, dark if active, light grey otherwise
          color: isCompleted ? const Color(0xFFE8F5E9) : (isActive ? Colors.black87 : Colors.grey.shade100),
          borderRadius: BorderRadius.circular(8),
          border: isCompleted ? Border.all(color: Colors.green.shade200) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isCompleted)
              const Icon(Icons.check_circle, color: Colors.green, size: 18)
            else
              CircleAvatar(
                radius: 10,
                backgroundColor: isActive ? Colors.orange : Colors.grey,
                child: Text("${index + 1}", style: const TextStyle(fontSize: 10, color: Colors.white)),
              ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isCompleted ? Colors.green : (isActive ? Colors.white : Colors.black54),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}