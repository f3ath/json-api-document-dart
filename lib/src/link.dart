import 'utils.dart';

class Link {
  final _json;

  Link(String url) : _json = url;

  Link.object(String href, Map<String, dynamic> meta)
      : _json = new Map.unmodifiable({'href': href, 'meta': createMeta(meta)});

  toJson() => _json;
}
