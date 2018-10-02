import 'package:json_api_document/json_api_document.dart';
import 'package:test/test.dart';

void main() {
  group('Attributes', () {
    test('enforce general naming rules', () {
      expect(() => Attributes({'-': true}), throwsArgumentError);
    });
    test('can not contain certain names', () {
      ['relationships', 'links', 'type', 'id'].forEach((attr) =>
          expect(() => Attributes({attr: true}), throwsArgumentError));
    });
  });
}
