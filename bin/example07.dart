void main(List<String> args) async {
  await for (var value in numbers()) {
    print(value);
  }
  print('___________________');
  await for (var value in numbers(end: 10, f: evenNumbersOnly)) {
    print(value);
  }
}

Stream<int> numbers({
  int start = 0,
  int end = 4,
  IsIncluded? f,
}) async* {
  for (var i = start; i < end; i++) {
    if (f == null || f(i)) {
      yield i;
    }
  }
}

typedef IsIncluded = bool Function(int value);

bool evenNumbersOnly(int value) => value % 2 == 0;
bool oddNumbersOnly(int value) => value % 2 != 0;
