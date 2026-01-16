import 'package:flutter/material.dart';

class CategorySelectionTile extends StatelessWidget {
  final String title;
  final String groupValue;
  final ValueChanged<String?> onChanged;
  final VoidCallback? onActionPressed;

  const CategorySelectionTile({
    super.key,
    required this.title,
    required this.groupValue,
    required this.onChanged,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = title == groupValue;
    return GestureDetector(
      onTap: () => onChanged(title),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? Colors.black : Colors.grey,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 14, height: 1.3),
              ),
            ),
            const SizedBox(width: 8),
            // Action Icon (Checkmark for selected, Pencil/Edit for others)
            GestureDetector(
              onTap: onActionPressed,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: isSelected ? Colors.green : Colors.blue),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  isSelected ? Icons.check : Icons.edit_outlined,
                  size: 16,
                  color: isSelected ? Colors.green : Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}