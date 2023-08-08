// ignore_for_file: unused_element

void main(List<String> args) async {
  int add(int a, int b) => a + b;
  final sum = await getAllAges().reduce((a, b) => a + b);
  print(sum);
}

Stream<int> getAllAges() async* {
  yield 10;
  yield 20;
  yield 30;
  yield 40;
  yield 50;
}
