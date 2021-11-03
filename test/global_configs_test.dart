import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:global_configs/global_configs.dart';

void main() {
  group('Load config', () {
    test('from Map', () {
      GlobalConfigs().clear();
      Map<String, dynamic> map = {
        'a': 1,
        'b': {'c': 2}
      };
      GlobalConfigs().loadFromMap(map);
      expect(GlobalConfigs().configs['a'], 1);
    });

    test('from Map to path', () {
      GlobalConfigs().clear();
      Map<String, dynamic> map = {
        'a': 1,
        'b': {'c': 2}
      };
      GlobalConfigs().loadFromMap(map, path: 'c');
      expect(GlobalConfigs().configs['c']['a'], 1);
    });
  });

  group('Read value', () {
    test('from configs', () {
      GlobalConfigs().clear();
      GlobalConfigs().loadFromMap({
        'a': 1,
        'b': {'c': 2},
      });

      expect(GlobalConfigs().get('a'), 1);
    });
    test('from nested configs', () {
      GlobalConfigs().clear();
      GlobalConfigs().loadFromMap({
        'a': 1,
        'b': {'c': 2},
      });

      expect(GlobalConfigs().get('b.c'), 2);
    });

    test('use converter', () {
      GlobalConfigs().clear();
      GlobalConfigs().loadFromMap({'color': '0xFFB74093'});

      Color? color = GlobalConfigs().get<Color>(
        'color',
        converter: (value) => Color(int.parse(value)),
      );
      expect(color is Color, true);
    });
  });

  group('Set value', () {
    test('to configs', () {
      GlobalConfigs().clear();
      GlobalConfigs().loadFromMap({
        'a': 1,
        'b': {'c': 2},
      });
      GlobalConfigs().set('a', 2);
      expect(GlobalConfigs().configs['a'], 2);
    });
    test('to nested configs', () {
      GlobalConfigs().clear();
      GlobalConfigs().loadFromMap({
        'a': 1,
        'b': {'c': 2},
      });
      GlobalConfigs().set('b.c', 2);
      expect(GlobalConfigs().configs['b']['c'], 2);
    });
    test('to configs even if key not exists', () {
      GlobalConfigs().clear();
      GlobalConfigs().loadFromMap({
        'a': 1,
        'b': {'c': 2},
      });
      GlobalConfigs().set('b.d', 2);
      expect(GlobalConfigs().configs['b']['d'], 2);
    });
  });

  group('Unset value', () {
    test('from configs', () {
      GlobalConfigs().clear();
      GlobalConfigs().loadFromMap({
        'a': 1,
        'b': {'c': 2},
      });
      GlobalConfigs().unset('b.c');

      expect(GlobalConfigs().configs['b.c'], null);
    });
  });
}
