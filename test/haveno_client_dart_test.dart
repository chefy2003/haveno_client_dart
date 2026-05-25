import 'package:test/test.dart';
import 'package:haveno_client_dart/haveno_client_dart.dart';

void main() {
  group('Haveno Client Тестове', () {
    test('Инициализация', () {
      final client = HavenoClient();
      expect(client.host, equals('localhost'));
    });
  });
}
