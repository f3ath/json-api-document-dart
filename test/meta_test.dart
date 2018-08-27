import 'package:json_api_document/json_api_document.dart';
import 'package:test/test.dart';

void main() {
  group('Meta', () {
    test('checks member naming on assignment', () {
      final meta = Meta(StrictNaming());
      expect(() => meta[''] = 'empty string is not allowed', throwsArgumentError);
    });
  });
}

