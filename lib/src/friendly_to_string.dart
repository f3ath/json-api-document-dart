abstract class FriendlyToString {
  toJson();

  @override
  String toString() => '${this.runtimeType}${this.toJson()}';
}
