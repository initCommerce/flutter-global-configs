library global_configs;

import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

///
/// Class for managing different configuration.
///
/// Use it with GlobalConfigs() to access the singleton.
///
class GlobalConfigs {
  static GlobalConfigs _singleton = GlobalConfigs._internal();
  Map<String, dynamic> configs = Map<String, dynamic>();

  factory GlobalConfigs() => _singleton;

  GlobalConfigs._internal();

  ///
  /// Loading a configuration [map] into the current app config.
  ///
  GlobalConfigs loadFromMap(Map<String, dynamic> map, {String? key}) {
    key == null ? configs.addAll(map) : set(key, map);

    return _singleton;
  }

  ///
  /// Loading a json configuration file from a custom [path] into the current app config.
  ///
  Future<GlobalConfigs> loadJsonFromPath(String path, {String? key}) async {
    String content = await rootBundle.loadString(path);
    Map<String, dynamic> res = json.decode(content);
    key == null ? configs.addAll(res) : set(key, res);

    return _singleton;
  }

  ///
  /// Reads a value of T type from persistent storage for the given [key].
  ///
  T get<T>(String path) => _baseGet(configs, path);

  T _baseGet<T>(map, String path) {
    List<String> keys = path.split('.');

    if (keys.length == 1) {
      return map[keys.removeAt(0)];
    }

    return _baseGet(map[keys.removeAt(0)], keys.join('.'));
  }

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

  ///
  /// Clear the persistent storage. Only for Unit testing!
  ///
  void clear() => configs.clear();
}
