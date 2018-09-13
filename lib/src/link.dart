import 'meta.dart';

class Link {
  final String href;
  final Meta meta;

  Link(String this.href, Meta this.meta);

  toJson() => {'href': href, 'meta': meta};
}
