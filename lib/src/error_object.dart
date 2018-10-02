import 'link.dart';
import 'meta.dart';

class ErrorObject {
  final String id;
  final Link about;
  final String status;
  final String code;
  final String title;
  final String detail;
  final String pointer;
  final String parameter;
  final Meta meta;
  final _json = Map<String, dynamic>();

  ErrorObject(
      {String this.id,
      Link this.about,
      String this.status,
      String this.code,
      String this.title,
      String this.detail,
      String this.pointer,
      String this.parameter,
      Map<String, dynamic> meta}) : meta = Meta.fromMap(meta) {
    if (id != null) _json['id'] = id;
    if (status != null) _json['status'] = status;
    if (code != null) _json['code'] = code;
    if (title != null) _json['title'] = title;
    if (detail != null) _json['detail'] = detail;
    if (meta != null) _json['meta'] = meta;
    if (about != null) _json['links'] = {'about': about};
    final source = Map<String, String>();
    if (pointer != null) source['pointer'] = pointer;
    if (parameter != null) source['parameter'] = parameter;
    if (source.length > 0) _json['source'] = source;
  }

  Map<String, dynamic> toJson() {
    return Map.from(_json);
  }
}
