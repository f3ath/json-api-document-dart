import 'meta.dart';
import 'link.dart';
import 'jsonapi.dart';
import 'naming.dart';
import 'strict_naming.dart';

class MetaDocument {
  final Naming naming;
  final Meta meta;
  JsonApi _jsonapi;
  var _selfLink;

  MetaDocument(Map<String, dynamic> meta,
      {Naming this.naming = StrictNaming.instance})
      : meta = Meta(naming, meta) {}

  get jsonapi => _jsonapi;

  get selfLink => _selfLink;

  toJson() {
    final Map<String, dynamic> j = {'meta': meta};
    if (_jsonapi != null) j['jsonapi'] = _jsonapi;
    if (_selfLink != null) j['links'] = {'self': _selfLink};
    return j;
  }

  void includeJsonApi(String version, [Map<String, dynamic> meta]) {
    _jsonapi = JsonApi(version, meta != null ? Meta(this.naming, meta) : null);
  }

  void removeJsonApi() {
    _jsonapi = null;
  }

  void setSelfLink(String url, [Map<String, dynamic> meta]) {
    if (meta != null)
      _selfLink = new Link(url, Meta(naming, meta));
    else
      _selfLink = url;
  }

  void removeSelfLink() {
    _selfLink = null;
  }
}

