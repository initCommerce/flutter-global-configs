# Global Configs

![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)

A flutter package to manage application configurations via singleton pattern.

**Show some ❤️ and star the repo to support the project**

## Installation

Add `global_configs: ^1.0.0` to your `pubspec.yaml` dependencies. And import it:

```dart
import 'package:global_configs/global_configs.dart';
```

## How to use

Simply load your configurations and use them everywhere in your application.

### Load configurations

Before usgin configurations you need to load them from a `Map` or a `JSON` file.

#### Load from Map
If you consider to keep your configs in a `dart` file, create a file in project's directory like this:

`/configs/dev.dart`
```dart
final Map<String, dynamic> dev = {
  "appearance": {
    "defaultTheme": "Dark",
    "templateScale": 1,
  }
};
```

Then import the file at the top level of the project, and use `loadFromMap` function to simply load the configs.

```dart
import 'configs/dev.dart' as configs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load configs from map
  GlobalConfigs().loadFromMap(configs.dev);

  runApp(MyApp());
}
```

Use `path`option to load configs into a specific path.

```dart
// Load configs from map
GlobalConfigs().loadFromMap(configs.dev, path: 'appearance.theme');
```

#### Load from JSON file
Create your JSON configuration file in your `assets` folder. for example: `configs/dev.json`

```json
{
    "config1": "test",
    "config2": 1
}
```

Don't forget to update your `pubspec.yaml` file

```yaml
flutter:
  assets:
    - configs/dev.json
```

Then use `loadJsonFromdir` function to load your `JSON` file

```dart
import 'package:global_configs/global_configs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load configs from json
  await GlobalConfigs().loadJsonFromdir('configs/dev.json');

  runApp(MyApp());
}
```

Use `path`option to load configs into a specific path.

```dart
// Load configs from json
await GlobalConfigs().loadJsonFromdir('configs/dev.json', path: 'appearance.theme');
```

### Get configuration
After loading configurations use `get` function to simply access to a configuration.
You can use `.` notation to access to a nested configuration.

```dart
Map<String, dynamic> configs = {
  'appearance': {
    'defaultTheme': 'Dark',
    'color': 'red',
  },
  'size': 100,
};

// Load configs from map
GlobalConfigs().loadFromMap(configs.dev);

var size = GlobalConfigs().get('size'); // 100
var defaultTheme = GlobalConfigs().get('appearance.defaultTheme'); // Dark
```

### Set configuration
Use `set` function to update or add a new configuration, You can use `.` notation to access to a nested configuration.

```dart
Map<String, dynamic> configs = {
  'appearance': {
    'defaultTheme': 'Dark',
    'color': 'red',
  },
  'size': 100,
};

// Load configs from map
GlobalConfigs().loadFromMap(configs.dev);

var defaultTheme = GlobalConfigs().set('appearance.defaultTheme', 'Light'); // Light
```

### Unset configuration
Use `unset` function to remove a configuration, , You can use `.` notation to access to a nested configuration.

```dart
Map<String, dynamic> configs = {
  'appearance': {
    'defaultTheme': 'Dark',
    'color': 'red',
  },
  'size': 100,
};

// Load configs from map
GlobalConfigs().loadFromMap(configs.dev);

var defaultTheme = GlobalConfigs().unset('appearance.defaultTheme'); // {'appearance': {'color': 'red'}, 'size': 100}
```


**For more information see [examples](https://github.com/mehdizarepour/flutter-global-configs/blob/master/example/lib/main.dart)**

# MIT License

```
Copyright (c) 2021 Mehdi Zarepour

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
