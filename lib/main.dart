import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ui/home.dart';
import 'ui/palette.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(const [
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const EcoNodesApp());
}

class EcoNodesApp extends StatelessWidget {
  const EcoNodesApp({super.key});

  ThemeData _theme(Brightness b) {
    final pal = b == Brightness.dark ? Pal.dark : Pal.light;
    return ThemeData(
      useMaterial3: true,
      brightness: b,
      scaffoldBackgroundColor: pal.paper,
      colorScheme: ColorScheme.fromSeed(seedColor: pal.accent, brightness: b).copyWith(primary: pal.accent, surface: pal.sheet),
      dividerColor: pal.rule,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ÉcoNodes',
      debugShowCheckedModeBanner: false,
      theme: _theme(Brightness.light),
      darkTheme: _theme(Brightness.dark),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}
