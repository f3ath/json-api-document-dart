part of '../json_api_document.dart';

class ErrorObject<N extends Naming> {
  final String id;
  final Link<N> about;
  final String status;
  final String code;
  final String title;
  final String detail;
  final String pointer;
  final String parameter;
  final Meta<N> meta;
  final _json = Map<String, dynamic>();

  ErrorObject(
      {String this.id,
      Link<N> this.about,
      String this.status,
      String this.code,
      String this.title,
      String this.detail,
      String this.pointer,
      String this.parameter,
      Meta<N> this.meta}) {
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
