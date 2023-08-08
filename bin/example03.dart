void main(List<String> args) async {
  final length = await calculateLength(await getFullName());
  print(length);

  final length2 = await getFullName().then((value) => calculateLength(value));
  print(length2);
}

Future<String> getFullName() => Future.delayed(
      Duration(seconds: 1),
      () => 'John Doe',
    );

Future<int> calculateLength(String value) => Future.delayed(
      Duration(seconds: 1),
      () => value.length,
    );
