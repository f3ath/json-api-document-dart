import 'dart:convert';

class FriendlyToString {
  @override
  String toString() => 'JAON:API ${this.runtimeType}: ${json.encode(this)}';
}