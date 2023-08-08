// ignore_for_file: unnecessary_this

import 'dart:async';

void main(List<String> args) async {
  await for (var name in names.map((name) => name.toUpperCase())) {
    print(name);
  }

  print('__________________');
  await for (var capitalizedName in names.capitalized) {
    print(capitalizedName);
  }
  print('__________________');
  await for (var capitalizedName in names.capitalizedUsingMap) {
    print(capitalizedName);
  }
}

Stream<String> names = Stream.fromIterable(
  [
    'Seth',
    'Kathy',
    'Lars',
  ],
);

extension on Stream<String> {
  Stream<String> get capitalized => this.transform(ToUpperCase());
  Stream<String> get capitalizedUsingMap =>
      this.map((name) => name.toUpperCase());
}

class ToUpperCase extends StreamTransformerBase<String, String> {
  @override
  Stream<String> bind(Stream<String> stream) {
    return stream.map((name) => name.toLowerCase());
  }
}
