import 'link.dart';
import 'utils.dart';

class ErrorObject {
  Map<String, dynamic> _json;

  ErrorObject(
      {String id,
      Link about,
      String status,
      String code,
      String title,
      String detail,
      String pointer,
      String parameter,
      Map<String, dynamic> meta}) {
    _json = removeNulls({
      'id': id,
      'status': status,
      'code': code,
      'title': title,
      'detail': detail,
    });
    if (about != null) {
      _json['links'] = {'about': about};
    }
    if (meta != null) {
      _json['meta'] = createMeta(meta);
    }
    final source = removeNulls({
      'pointer': pointer,
      'parameter': parameter,
    });

    if (source.isNotEmpty) {
      _json['source'] = new Map.unmodifiable(source);
    }
    _json = new Map.unmodifiable(_json);
  }

  toJson() => _json;
}
