import 'package:grpc/grpc.dart';
// Импортираме суровите Google дефиниции за заявките и отговорите ни:
import 'src/generated/grpc.pb.dart';
import 'src/generated/grpc.pbgrpc.dart' as generated;

/// Главният команден пункт на кукловодската Dart библиотека за Haveno P2P.
class HavenoClient {
  final String host;
  final int port;
  late ClientChannel _channel;

  // Нашите високоспециализирани под-клиенти, уловени от сонара:
  late generated.GetVersionClient version;
  late generated.WalletsClient wallets;
  late generated.OffersClient offers;
  late generated.TradesClient trades;
  late generated.AccountClient account;
  late generated.PriceClient price;
  late generated.DisputesClient disputes;

  /// Инициализиране на клиента и вдигане на единния gRPC тунел.
  HavenoClient({this.host = 'localhost', this.port = 9092}) {
    _channel = ClientChannel(
      host,
      port: port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    // Заваряваме абсолютно всички под-клиенти към същия Свещен канал:
    version = generated.GetVersionClient(_channel);
    wallets = generated.WalletsClient(_channel);
    offers = generated.OffersClient(_channel);
    trades = generated.TradesClient(_channel);
    account = generated.AccountClient(_channel);
    price = generated.PriceClient(_channel);
    disputes = generated.DisputesClient(_channel);
  }

  /// 🎯 МЕТОД 1: Вземане на баланса на Monero портфейлите през WalletsClient
  Future<GetBalancesReply> getBalances() async {
    try {
      final request = GetBalancesRequest();
      return await wallets.getBalances(request);
    } catch (e) {
      throw Exception('Haveno Dart API [getBalances] Error: \$e');
    }
  }

  /// 🎯 МЕТОД 2: Вземане на текущата версия на демона през GetVersionClient
  Future<GetVersionReply> getVersion() async {
    try {
      final request = GetVersionRequest();
      return await version.getVersion(request);
    } catch (e) {
      throw Exception('Haveno Dart API [getVersion] Error: \$e');
    }
  }

  /// 🔌 Прочистване на ефира и пълно спиране на сокетите
  Future<void> disconnect() async {
    await _channel.shutdown();
  }
}
