# Global Configs

![gc-logo](https://user-images.githubusercontent.com/8446770/113515900-825c9e00-958c-11eb-9252-9f1a0c66b2ea.png)

![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)

A flutter package to manage application configurations via singleton pattern.

**Show some ❤️ and star the repo to support the project**

## Installation

Add `global_configs: ^1.1.1` to your `pubspec.yaml` dependencies. And import it:

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
```dart
T get<T>(String path, {T Function(dynamic)? converter})
```

**Arguments**

- path *(`String`)*: The path of the config to get.
- converter *(`T Function(dynamic)?`)*: The function to cast the value to a custom type

**Returns**

- *`<T>|null`*: Returns the resolved value or `null` if the config is not found.

**Example**
```dart
Map<String, dynamic> configs = {
  'appearance': {
    'defaultTheme': 'Dark',
    'color': '0xFFB74093',
  },
  'size': 100,
};

// Load configs from map
GlobalConfigs().loadFromMap(configs.dev);

var size = GlobalConfigs().get('size'); // 100
var defaultTheme = GlobalConfigs().get('appearance.defaultTheme'); // Dark
Color color = GlobalConfigs().get<Color>(
  'appearance.color',
  converter: (value) => Color(int.parse(value)),
);
```

### Set configuration
Use `set` function to update or add a new configuration.
```dart
void set<T>(String path, T value)
```
**Arguments**

- path *(`String`)*: The path of the config to set.
- value *(`T`)*: The value to set.

**Example**
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

GlobalConfigs().set('appearance.defaultTheme', 'Light'); // Light
```

### Unset configuration
Use `unset` function to remove a configuration.
```dart
void unset(String path)
```

**Arguments**

- path *(`String`)*: The path of the property to remove.


**Example**
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

