import 'package:haveno_client_dart/haveno_client_dart.dart';

void main() async {
  final client = HavenoClient(host: 'localhost', port: 9092);
  print('Haveno Client заварен за ефира на Бургас!');
  await client.disconnect();
}
