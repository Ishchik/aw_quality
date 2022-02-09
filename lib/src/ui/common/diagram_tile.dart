import 'package:flutter/material.dart';

import 'diagram.dart';

class DiagramTile extends StatelessWidget {
  const DiagramTile({
    Key? key,
    required this.list,
    required this.title,
    required this.maxY,
    required this.type,
  }) : super(key: key);

  final List<num> list;
  final String title;
  final double maxY;
  final DiagramType type;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 120.0,
        maxHeight: 150.0,
      ),
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              height: 100.0,
              padding: const EdgeInsets.symmetric(
                horizontal: 4.0,
              ),
              child: VerticalDivider(
                width: 2.0,
                color: Colors.grey[400],
              ),
            ),
            Expanded(
              flex: 6,
              child: Diagram(
                list: list,
                maxY: maxY,
                type: type,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
