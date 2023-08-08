import 'dart:async';

void main(List<String> args) async {
  final controller = StreamController();
  controller.sink.add('Hello');
  print(controller);
  await for (var element in controller.stream) {
    print(element);
  }
  print(controller);

  controller.close();
}
