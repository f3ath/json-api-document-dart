import 'dart:convert';

/// Strips types from a json object.
/// This way we can simulate real world use cases when JSON comes in a string
/// rather than a Dart object, thus not having all type information.
recodeJson(j) => json.decode(json.encode(j));
