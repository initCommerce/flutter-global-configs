library global_configs;

import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

/// A singleton class to set and get global configs.
///
/// Use GlobalConfigs() to access the singleton.
class GlobalConfigs {
  static GlobalConfigs _singleton = GlobalConfigs._internal();

  /// The current configs
  Map<String, dynamic> configs = Map<String, dynamic>();

  /// Returns the singleton object
  factory GlobalConfigs() => _singleton;

  GlobalConfigs._internal();

  /// Load your [GlobalConfigs] from a [map] into the current configs
  ///
  /// Load your configs into a specific path by [path]
  /// It will create new path if the [path] doesn't exist
  ///
  /// ```dart
  /// Map<String, dynamic> map = { 'a': 1, 'b': {'c': 2}};
  /// GlobalConfigs.loadFromMap(map, path: 'b.c');
  /// ```
  GlobalConfigs loadFromMap(Map<String, dynamic> map, {String? path}) {
    path == null ? configs.addAll(map) : set(path, map);

    return _singleton;
  }

  /// Load your [GlobalConfigs] from a `JSON` file into the current configs
  ///
  /// Load your configs into a specific path by [path]
  /// It will create new key if the [path] doesn't exist
  ///
  /// ```dart
  /// await GlobalConfigs().loadJsonFromDir(dir, 'assets/cofig.json');
  /// ```
  Future<GlobalConfigs> loadJsonFromdir(String dir, {String? path}) async {
    String content = await rootBundle.loadString(dir);
    Map<String, dynamic> res = json.decode(content);
    path == null ? configs.addAll(res) : set(path, res);

    return _singleton;
  }

  /// Reads from the configs
  ///
  /// Use [path] to access to a specific key
  ///
  /// ```dart
  /// Map<String, dynamic> map = { 'a': 1, 'b': {'c': 2}};
  /// GlobalConfigs.loadFromMap(map);
  ///
  /// GlobalConfigs().get('a'); // 1
  /// GlobalConfigs().get('b.c'); // 2
  /// ```dart
  T get<T>(String path) => _baseGet(configs, path);

  T _baseGet<T>(map, String path) {
    List<String> keys = path.split('.');

    if (keys.length == 1) {
      return map[keys.removeAt(0)];
    }

    return _baseGet(map[keys.removeAt(0)], keys.join('.'));
  }

  /// Sets new data to the configs
  ///
  /// Use [path] to access to a specific key
  /// and pass your new value to [value].
  /// It will create new key if the [path] doesn't exist.
  ///
  /// ```dart
  /// Map<String, dynamic> map = { 'a': 1, 'b': {'c': 2}};
  /// GlobalConfigs.loadFromMap(map);
  ///
  /// GlobalConfigs().set('a', 3); // { 'a': 3, 'b': {'c': 2}}
  /// GlobalConfigs().set('b.d', 4); // { 'a': 3, 'b': {'c': 2, 'd': 4}}
  /// ```dart
  void set<T>(String path, T value) => configs = _baseSet(configs, path, value);

  Map<String, dynamic> _baseSet<T>(map, String path, value) {
    List<String> keys = path.split('.');

    if (keys.length == 1) {
      return {
        ...(map is Map ? map : {}),
        keys[0]: value as T,
      };
    }

    return {
      ...(map is Map ? map : {}),
      keys[0]: _baseSet(map[keys.removeAt(0)], keys.join('.'), value),
    };
  }

  /// Removes data to the configs
  ///
  /// Use [path] to access to a specific key
  ///
  /// ```dart
  /// Map<String, dynamic> map = { 'a': 1, 'b': {'c': 2}};
  /// GlobalConfigs.loadFromMap(map);
  ///
  /// GlobalConfigs().unset('b'); // { 'a': 3}
  /// ```dart
  void unset(String path) => configs = _baseUnset(configs, path);

  Map<String, dynamic> _baseUnset(map, String path) {
    List<String> keys = path.split('.');

    if (keys.length == 1) {
      map.remove(keys.removeAt(0));

      return map;
    }

    return {
      ...(map is Map ? map : {}),
      keys[0]: _baseUnset(map[keys.removeAt(0)], keys.join('.')),
    };
  }

  /// Clear the current configs
  void clear() => configs.clear();
}
