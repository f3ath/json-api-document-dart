part of '../json_api_document.dart';

class Link<N extends Naming> {
  final String url;
  final isObject = false;
  final Meta<N> meta = null;

  Link(String this.url);

  toJson() => url;
}

class LinkObject<N extends Naming> extends Link<N> {
  final isObject = true;
  final Meta<N> meta;

  LinkObject(String url, {Meta<N> this.meta}) : super(url);

  toJson() => {'href': url, 'meta': meta};
}
