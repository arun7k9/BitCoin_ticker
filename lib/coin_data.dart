import 'network_helper.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'INR',
  'JPY',
  'RUB',
  'USD'
];
const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<double> getCoinPrice(
      String fromCoinConvert, String toCoinConvert) async {
    var url =
        'https://rest.coinapi.io/v1/exchangerate/$fromCoinConvert/$toCoinConvert?apikey=88C86558-C4D5-4254-B27D-F818052C33FE';
    NetworkHelper networkHelper = NetworkHelper(url);
    var coinData = await networkHelper.getData();
    print('${double.parse((coinData['rate']).toStringAsFixed(2)).toString()}');
    return coinData['rate'];
  }
}
