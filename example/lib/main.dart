import 'package:flutter/material.dart';
import 'package:global_configs/global_configs.dart';

import 'configs/dev.dart' as configs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load configs from map
  GlobalConfigs().loadFromMap(configs.dev);

  // Load configs from json
  await GlobalConfigs().loadJsonFromPath('configs/dev.json');

  print(GlobalConfigs().get('config1'));

  // Set new config
  GlobalConfigs().set('appearance.defaultTheme', 'Light');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Global config example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Global config example'),
        ),
        body: Center(
          child: Text(
              'appearance.defaultTheme = ${GlobalConfigs().get("appearance.defaultTheme")}'),
        ),
      ),
    );
  }
}
