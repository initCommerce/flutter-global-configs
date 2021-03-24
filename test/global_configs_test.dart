import 'package:flutter_test/flutter_test.dart';

import 'package:global_configs/global_configs.dart';

void main() {
  group('Load config', () {
    Map<String, dynamic> map = {
      'a': 1,
      'b': {'c': 2}
    };

    test('from Map', () {
      GlobalConfigs().clear();
      GlobalConfigs().loadFromMap(map);
      expect(GlobalConfigs().configs['a'], 1);
    });

    test('from Map to key', () {
      GlobalConfigs().clear();
      GlobalConfigs().loadFromMap(map, key: 'c');
      expect(GlobalConfigs().configs['c']['a'], 1);
    });
  });

  group('Read value', () {
    GlobalConfigs().clear();
    GlobalConfigs().loadFromMap({
      'a': 1,
      'b': {'c': 2},
    });

    test('from configs', () => expect(GlobalConfigs().get('a'), 1));
    test('from nested configs', () => expect(GlobalConfigs().get('b.c'), 2));
  });

  group('Set value', () {
    GlobalConfigs().clear();
    GlobalConfigs().loadFromMap({
      'a': 1,
      'b': {'c': 2},
    });

    test('to configs', () {
      GlobalConfigs().set('a', 2);
      expect(GlobalConfigs().configs['a'], 2);
    });
    test('to nested configs', () {
      GlobalConfigs().set('b.c', 2);
      expect(GlobalConfigs().configs['b']['c'], 2);
    });
    test('to configs even if key not exists', () {
      GlobalConfigs().set('b.d', 2);
      expect(GlobalConfigs().configs['b']['d'], 2);
    });
  });

  group('Unset value', () {
    GlobalConfigs().clear();
    GlobalConfigs().loadFromMap({
      'a': 1,
      'b': {'c': 2},
    });

    test('from configs', () {
      GlobalConfigs().unset('b.c');

      expect(GlobalConfigs().configs['b.c'], null);
    });
  });
}
