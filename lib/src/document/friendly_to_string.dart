abstract class FriendlyToString {
  Map<String, dynamic> toJson();

  @override
  String toString() => '${this.runtimeType}${this.toJson()}';
}
