import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:pkg_jackmeng/pkg_jackmeng.dart';

void main() {
  test('general tests', () async {
    expect(true, true);
  });

    group('ColorExtensions', () {
    test('darker returns a darker color', () {
      const originalColor = Color.fromRGBO(255, 255, 255, 1.0);
      final darkerColor = originalColor.darker(50);
      expect(darkerColor.red, equals(127));
      expect(darkerColor.green, equals(127));
      expect(darkerColor.blue, equals(127));
    });

    test('lighter returns a lighter color', () {
      const originalColor = Color.fromRGBO(0, 0, 0, 1.0);
      final lighterColor = originalColor.lighter(50);
      expect(lighterColor.red, equals(127));
      expect(lighterColor.green, equals(127));
      expect(lighterColor.blue, equals(127));
    });
  });
}
