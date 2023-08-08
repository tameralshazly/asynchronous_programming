// ignore_for_file: dead_code

import 'dart:async';

void main(List<String> args) async {
  try {
    await for (var name in getNames().WithTimeoutBetweenEvents(
      Duration(
        seconds: 3,
      ),
    )) {
      print(name);
    }
  } on TimeoutBetweenEventsException catch (e, stackTrace) {
    print('TimeoutBetweenEventsException: $e');
    print('Stack Trace: $stackTrace');
  }
}

Stream<String> getNames() async* {
  yield 'Bob';
  await Future.delayed(Duration(seconds: 1));
  yield 'Alice';
  await Future.delayed(Duration(seconds: 10));
  yield 'Joe';
}

class TimeoutBetweenEvents<E> extends StreamTransformerBase<E, E> {
  final Duration duration;

  const TimeoutBetweenEvents({required this.duration});
  @override
  Stream<E> bind(Stream<E> stream) {
    StreamController<E>? controller;
    StreamSubscription<E>? subscription;
    Timer? timer;

    controller = StreamController(
      onListen: () {
        subscription = stream.listen(
          (data) {
            timer?.cancel();
            timer = Timer.periodic(duration, (timer) {
              controller?.addError(
                TimeoutBetweenEventsException(
                  'No Event received for $duration',
                ),
              );
            });
            controller?.add(data);
          },
          onError: controller?.addError,
          onDone: controller?.close,
        );
      },
      onCancel: () {
        subscription?.cancel();
        timer?.cancel();
      },
    );
    return controller.stream;
  }
}

extension<T> on Stream<T> {
  Stream<T> WithTimeoutBetweenEvents(Duration duration) => transform(
        TimeoutBetweenEvents(
          duration: duration,
        ),
      );
}

class TimeoutBetweenEventsException implements Exception {
  final String message;

  TimeoutBetweenEventsException(this.message);
}
