import 'package:test/test.dart';
import 'package:json_api_document/json_api_document.dart';
void main() {
  test('Type is validated', () {
    expect(() => new ResourceIdentifier('invalid type', '1'), throwsArgumentError);
  });
}