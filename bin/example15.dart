import 'dart:async';

void main(List<String> args) async {
  await nonBroadcastStreamExample();
  print('_________');
  await broadcastStreamExample();
}

Future<void> nonBroadcastStreamExample() async {
  final controller = StreamController<String>();
  controller.sink.add('Brad');
  controller.sink.add('Tamer');
  controller.sink.add('Hue');

  try {
    await for (var name in controller.stream) {
      print(name);
      await for (var name in controller.stream) {
        print(name);
      }
    }
  } catch (e) {
    print(e);
  }
}

Future<void> broadcastStreamExample() async {
  late final StreamController<String> controller;
  controller = StreamController<String>.broadcast();

  final sub1 = controller.stream.listen((name) {
    print('Sub1: $name');
  });
  final sub2 = controller.stream.listen((name) {
    print('Sub2: $name');
  });

  controller.sink.add('Brad');
  controller.sink.add('Tamer');
  controller.sink.add('Hue');

  controller.close();
  controller.onCancel = () {
    print('onCancel');
    sub1.cancel();
    sub2.cancel();
  };
}
