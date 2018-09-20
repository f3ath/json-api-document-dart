part of '../json_api_document.dart';

abstract class Document<N extends Naming> {
  final Meta<N> meta;
  final Api<N> api;
  final Link<N> self;

  Document({Meta<N> this.meta, Api<N> this.api, Link<N> this.self});

  toJson() {
    final j = Map<String, dynamic>();
    if (meta != null) j['meta'] = meta;
    if (api != null) j['jsonapi'] = api;
    if (self != null) j['links'] = {'self': self};
    return j;
  }
}
