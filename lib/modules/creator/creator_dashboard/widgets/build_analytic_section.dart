import 'package:flutter/material.dart';

import 'helper_ui.dart';
import 'line_chart_sample.dart';

Widget buildAnalyticsSection() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
    child: Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Statements", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("Explore", style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            // Integration of your Line Chart
            Expanded(flex: 2, child: LineChartSample()),
            const SizedBox(width: 12),
            const Expanded(
              flex: 1,
              child: Column(
                children: [
                  SmallStatTile(label: "Music & Content", value: "24", color: Colors.black),
                  SmallStatTile(label: "Music", value: "14", color: Colors.blue),
                  SmallStatTile(label: "Content", value: "10", color: Colors.orange),
                ],
              ),
            )
          ],
        )
      ],
    ),
  );
}