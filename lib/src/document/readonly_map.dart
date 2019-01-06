/// A read-only wrapper for a Map. Implements all read properties and methods.
class ReadonlyMap<K, V> {
  final Map<K, V> _data;

  ReadonlyMap(Map<K, V> data) : _data = Map.from(data);

  bool containsValue(V value) => _data.containsValue(value);

  bool containsKey(K key) => _data.containsKey(key);

  V operator [](K key) => _data[key];

  Iterable<MapEntry<K, V>> get entries => _data.entries;

  Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> f(K key, V value)) => _data.map(f);

  void forEach(void f(K key, V value)) => _data.forEach(f);

  Iterable<K> get keys => _data.keys;

  Iterable<V> get values => _data.values;

  int get length => _data.length;

  bool get isEmpty => _data.isEmpty;

  bool get isNotEmpty => _data.isNotEmpty;

  Map<K, V> toJson() => Map.unmodifiable(_data);
}
