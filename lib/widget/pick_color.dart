import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

AlertDialog pickColor(Color curColor, Function(Color) pickCallback) {
  return AlertDialog(
    title: const Text('Pick a color'),
    content: Container(
      constraints: const BoxConstraints(
        maxHeight: 500
      ),
      child: ColorPicker(
        pickerColor: curColor,
        paletteType: PaletteType.hueWheel,
        onColorChanged: (color) {
          curColor = color;
        },
      ),
    ),
    actions: [
      TextButton(
          onPressed: () {
            pickCallback(curColor);
          },
          child: const Text('Got it'))
    ],
  );
}
