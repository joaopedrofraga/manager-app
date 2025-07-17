import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/core/config/app.dart';

void main() {
  runApp(const App());
  doWhenWindowReady(() {
    appWindow.title = 'Manager App - $versao';
  });
}

const String versao = 'ALFA 1.4.4';
