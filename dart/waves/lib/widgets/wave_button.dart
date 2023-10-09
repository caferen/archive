import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/wave_state_provider.dart';

class WaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.waves, size: 30),
      onPressed: () {
        // start editing
        Provider.of<Wave>(context, listen: false).toggleEditStatus();
        Provider.of<Wave>(context, listen: false).toggleSlideBarVisibility();
      },
    );
  }
}
