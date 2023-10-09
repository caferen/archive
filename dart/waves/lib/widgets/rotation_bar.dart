import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/wave_state_provider.dart';

class RotationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isEditing = Provider.of<Wave>(context).isEditing;
    bool isSlideBarVisible = Provider.of<Wave>(context).isSlideBarVisible;
    return Visibility(
      visible: isEditing && isSlideBarVisible,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Slider(
          value: Provider.of<Wave>(context).rotation,
          min: -pi / 2,
          max: pi / 2,
          onChanged: (newValue) =>
              Provider.of<Wave>(context, listen: false).setRotation = newValue,
        ),
      ),
    );
  }
}
