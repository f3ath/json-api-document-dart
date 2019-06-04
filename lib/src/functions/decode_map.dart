import 'package:json_api_document/src/decoding_exception.dart';

Map<String, T> decodeMap<T>(Object json, T f(Object _)) {
  if (json == null) return {};
  if (json is Map)
    return Map.fromIterables(
        json.keys.map((_) => _.toString()), json.values.map(f));
  throw DecodingException('Can not decode Map<String, ${T}> from $json');
}
