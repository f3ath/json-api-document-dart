import 'meta.dart';

class Link {
  final String url;
  final isObject = false;
  final Meta meta = null;

  Link(String this.url);

  toJson() => url;
}

class LinkObject extends Link {
  final isObject = true;
  final Meta meta;

  LinkObject(String url, {Meta this.meta}) : super(url);

  toJson() => {'href': url, 'meta': meta};
}
