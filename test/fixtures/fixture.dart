import 'dart:io';

String fixture(String filename) {
  return File("test/fixtures/$filename").readAsStringSync();
}
