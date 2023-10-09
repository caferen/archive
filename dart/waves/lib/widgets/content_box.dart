import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/wave_state_provider.dart';

class ContentBox extends StatelessWidget {
  final double horizontal;
  final double vertical;
  ContentBox(this.horizontal, this.vertical);
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: Provider.of<Wave>(context).isEditing,
      child: InteractiveViewer(
        maxScale: 10,
        minScale: 0.1,
        boundaryMargin: EdgeInsets.symmetric(
          horizontal: horizontal / 3,
          vertical: vertical / 3,
        ),
        child: Align(
          child: Transform.rotate(
            // the rotation is controlled by the slidebar
            angle: Provider.of<Wave>(context).rotation,
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: TextField(
                textAlign: TextAlign.center,
                minLines: 1,
                maxLines: 300,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
