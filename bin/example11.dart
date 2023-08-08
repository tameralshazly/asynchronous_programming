void main(List<String> args) async {
  final list = await getNames().toList();
  print(list);
}

Stream<String> getNames() async* {
  yield 'John';
  yield 'Jane';
  yield 'Jack';
}
