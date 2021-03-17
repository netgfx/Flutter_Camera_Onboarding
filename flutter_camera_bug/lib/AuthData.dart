import 'dart:io';

class Auth {
  // singleton
  static final Auth _singleton = Auth._internal();
  factory Auth() => _singleton;
  Auth._internal();
  static Auth get shared => _singleton;

  // variables
  var camera;
}
