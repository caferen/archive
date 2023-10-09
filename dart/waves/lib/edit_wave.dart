import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:liner_waves/providers/wave_state_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/content_box.dart';
import 'widgets/paylas_button.dart';
import 'widgets/rotation_bar.dart';
import 'widgets/title.dart';
import 'widgets/wave_button.dart';

class EditWave extends StatelessWidget {
  final File wavePhoto;

  const EditWave(this.wavePhoto);

  static GlobalKey screen = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    bool isEditing = Provider.of<Wave>(context).isEditing;
    return RepaintBoundary(
      key: screen,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(wavePhoto),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: PaylasButton(screen),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            centerTitle: !isEditing,
            title: !isEditing ? WaveButton() : WaveTitle(),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: Container(
                height: constraints.maxHeight,
                child: Stack(
                  children: [
                    ContentBox(constraints.maxWidth, constraints.maxHeight),
                    Positioned(
                      bottom: constraints.maxHeight / 6,
                      child: RotationBar(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
