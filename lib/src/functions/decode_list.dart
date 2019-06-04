import 'package:json_api_document/src/decoding_exception.dart';

List<T> decodeList<T>(Object json, T f(Object _)) {
  if (json == null) return [];
  if (json is List) return json.map(f).toList();
  throw DecodingException('Can not decode List<${T}> from $json');
}
