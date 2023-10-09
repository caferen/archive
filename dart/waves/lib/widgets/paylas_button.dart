import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:liner_waves/main.dart';
import 'package:provider/provider.dart';
import 'package:liner_waves/providers/wave_state_provider.dart';

class PaylasButton extends StatelessWidget {
  final GlobalKey screen;
  PaylasButton(this.screen);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: Provider.of<Wave>(context).isPaylasVisible,
      child: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        onPressed: () async {
          // unfocus the current focus so that the
          // cursor won't be in the screenshot
          FocusScope.of(context).unfocus();
          Provider.of<Wave>(context, listen: false).toggleSlideBarVisibility();
          // set the opacity of the FAB to zero
          Provider.of<Wave>(context, listen: false).opacity = 0.0;
          await Future.delayed(Duration(milliseconds: 20));
          // take the screenshot and save it to a File
          File wave = await Provider.of<Wave>(context, listen: false)
              .createWave(context, screen);
          // navigate to main screen and send the wave with it
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => LinerScreen(wave: wave),
              ),
              (route) => false);
        },
        label: Text(
          'Paylaş',
          style: TextStyle(color: Colors.blue, fontSize: 20),
        ),
        icon: Icon(
          Icons.arrow_right,
          size: 40,
          color: Colors.blue,
        ),
      ),
    );
  }
}
