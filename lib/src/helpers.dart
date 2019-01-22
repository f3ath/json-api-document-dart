T nullOr<T, V>(V v, T f(V v)) => v == null ? null : f(v);
