void main(List<String> args) async {
  print(await getName());
  print(await getAddress());
  print(await getPhoneNo());
  print(await getCity());
  print(getCountry());
}

Future<String> getName() async {
  return 'Foo Bar';
}

Future<String> getAddress() => Future.value('123 Main Street');

Future<String> getPhoneNo() =>
    Future.delayed(Duration(seconds: 1), () => '555-555-5555');

Future<String> getCity() async {
  await Future.delayed(Duration(seconds: 1));
  return 'New York';
}

Future<String> getCountry() async => 'USA';
