import 'package:json_api_document/json_api_document.dart';

import 'meta.dart';

class Link<N extends Naming> {
  final String href;
  final Meta<N> meta;

  Link(String this.href, {Meta<N> this.meta});

  toJson() => {'href': href, 'meta': meta};
}
