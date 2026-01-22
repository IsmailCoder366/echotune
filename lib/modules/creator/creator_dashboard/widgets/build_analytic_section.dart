import 'package:flutter/material.dart';

import 'helper_ui.dart';
import 'line_chart_sample.dart';

Widget buildAnalyticsSection() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
    child: Column(
      children: [
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Statements", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(8)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('All'),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('2024'),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
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