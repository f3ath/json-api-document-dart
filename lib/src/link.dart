import 'utils.dart';

class Link {
  final json;

  Link(String url) : json = url;

  Link.object(String href, Map<String, dynamic> meta)
      : json = new Map.unmodifiable({'href': href, 'meta': createMeta(meta)});
}
