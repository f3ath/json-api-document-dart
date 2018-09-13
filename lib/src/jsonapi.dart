import 'meta.dart';

class JsonApi {
  String version;
  final Meta meta;

  JsonApi(String this.version, [Meta this.meta]);

  toJson() {
    final Map<String, dynamic> j = {'version': version};
    if (meta != null) j['meta'] = meta;
    return j;
  }
}
