void main(List<String> args) async {
  final results = getNames().asyncExpand(
    (name) => times3(name),
  );
  await for (var element in results) {
    print(element);
  }
}

Stream<String> getNames() async* {
  yield 'Bob';
  yield 'Alice';
  yield 'Joe';
}

Stream<String> times3(String value) => Stream.fromIterable(
      Iterable.generate(
        3,
        (_) => value,
      ),
    );
