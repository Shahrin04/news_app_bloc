import 'package:flutter/material.dart';

class UniversalVariables{
  static final Color mainColor = Color(0xFFF6511D);
  static final Color titleColor = const Color(0xFF061857);
  static final primaryGradient = const LinearGradient(
    colors: const [ Color(0xFFf6501c), Color(0xFFff7e00)],
    stops: const [0.0, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}