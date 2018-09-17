import 'package:json_api_document/json_api_document.dart';

class Api<N extends Naming> {
  final String version;
  final Meta<N> meta;

  Api(String this.version, {Meta<N> this.meta});

  toJson() {
    final Map<String, dynamic> j = {'version': version};
    if (meta != null) j['meta'] = meta;
    return j;
  }
}
