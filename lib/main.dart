import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_app_clean_architeture_and_tdd/app_widget.dart';

import 'app_modular.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
