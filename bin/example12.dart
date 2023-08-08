import 'dart:async';

void main(List<String> args) async {
  await for (var name in getNames().absorbErrorsUsingHandleError()) {
    print(name);
  }

  print('__________');
  await for (var name in getNames().absorbErrorsUsingHandlers()) {
    print(name);
  }
  print('__________');
  await for (var name in getNames().absorbErrorsUsingTransformer()) {
    print(name);
  }
}

Stream<String> getNames() async* {
  yield 'John';
  yield 'Jane';
  throw 'All out of names';
}

extension AbsorbErrors<T> on Stream<T> {
  Stream<T> absorbErrorsUsingHandleError() =>
      handleError((error, stackTrace) {});

  Stream<T> absorbErrorsUsingHandlers() => transform(
        StreamTransformer.fromHandlers(
          handleError: (_, __, sink) => sink.close(),
        ),
      );

  Stream<T> absorbErrorsUsingTransformer() => transform(
        StreamErrorAbsorber(),
      );
}

class StreamErrorAbsorber<T> extends StreamTransformerBase<T, T> {
  @override
  Stream<T> bind(Stream<T> stream) {
    final controller = StreamController<T>();
    stream.listen(
      controller.sink.add,
      onError: (_) {},
      onDone: controller.close,
    );

    return controller.stream;
  }
}
