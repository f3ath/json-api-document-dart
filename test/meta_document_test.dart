import 'package:json_api_document/json_api_document.dart';
import 'package:json_api_document/src/jsonapi.dart';
import 'package:json_api_document/src/link.dart';
import 'package:json_api_document/src/meta.dart';
import 'package:test/test.dart';
import 'package:json_matcher/json_matcher.dart';
import 'dart:mirrors';

void main() {
  group('Meta Document', () {
    MetaDocument d;

    setUp(() {
      d = MetaDocument({'foo': 'bar'});
    });

    test('is empty upon creation', () {
      expect(
          d,
          encodesToJson({
            "meta": {"foo": "bar"}
          }));
    });

    test('has strict naming by default', () {
      expect(d.naming, TypeMatcher<StrictNaming>());
    });

    group('jsonapi member', () {
      test('is null by default', () {
        expect(d.jsonapi, equals(null));
      });

      test('can be included', () {
        d.includeJsonApi('1.0');
        expect(d.jsonapi, TypeMatcher<JsonApi>());
        expect(d.jsonapi.version, equals('1.0'));
        expect(
            d,
            encodesToJson({
              "meta": {"foo": "bar"},
              "jsonapi": {"version": "1.0"}
            }));
      });
      test('can be removed', () {
        d.includeJsonApi('1.0');
        d.removeJsonApi();
        expect(d.jsonapi, equals(null));
        expect(
            d,
            encodesToJson({
              "meta": {"foo": "bar"}
            }));
      });
      test('can include meta', () {
        d.includeJsonApi('1.0', {'a': 'b'});
        expect(
            d,
            encodesToJson({
              "meta": {"foo": "bar"},
              "jsonapi": {
                "version": "1.0",
                "meta": {"a": "b"}
              }
            }));
      });
    });

    group('meta member', () {
      test('exists', () {
        expect(d.meta, TypeMatcher<Meta>());
      });
      test('has the same naming', () {
        expect(d.meta.naming, equals(d.naming));
      });
    });

    ['self'].forEach((linkName) {
      group('${linkName} member', () {
        String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
        var settingMethod = Symbol('set${capitalize(linkName)}Link');
        var fieldName = Symbol('${linkName}Link');
        var removingMethod = Symbol('remove${capitalize(linkName)}Link');

        test('can set plain URL', () {
          reflect(d).invoke(settingMethod, ['http://example.com']);
          expect(reflect(d).getField(fieldName).reflectee,
              equals('http://example.com'));
          expect(
              d,
              encodesToJson({
                "meta": {"foo": "bar"},
                "links": {linkName: "http://example.com"}
              }));
        });
        test('can set link object', () {
          reflect(d).invoke(settingMethod, [
            'http://example.com',
            {'a': 'b'}
          ]);
          expect(reflect(d).getField(fieldName).reflectee, TypeMatcher<Link>());
          expect(
              d,
              encodesToJson({
                "meta": {"foo": "bar"},
                "links": {
                  linkName: {
                    "href": "http://example.com",
                    "meta": {"a": "b"}
                  }
                }
              }));
        });
        test('can remove link', () {
          reflect(d).invoke(settingMethod, ['http://example.com']);
          reflect(d).invoke(removingMethod, []);
          expect(reflect(d).getField(fieldName).reflectee, equals(null));
          expect(
              d,
              encodesToJson({
                "meta": {"foo": "bar"}
              }));
        });
      });
    });
  });
}
