import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();
  bool isLoading = false;
  String selectedCurrency = 'USD';
  String selectedCryptoCurrency = 'BTC';
  String selectedCryptoCurrency2 = 'ETH';
  String selectedCryptoCurrency3 = 'LTC';
  String valueInConvertedCurrency = '';
  String valueInConvertedCurrency2 = '';
  String valueInConvertedCurrency3 = '';

  List<DropdownMenuItem> getDropdownItems() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem(
        child: Text(
          currency,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return dropdownItems;
  }

  List<DropdownMenuItem> getDropdownItemsCryptocurrency() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (int i = 0; i < cryptoList.length; i++) {
      String currency = cryptoList[i];
      var newItem = DropdownMenuItem(
        child: Text(
          currency,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return dropdownItems;
  }

  Future<void> getInitialConversion() async {
    double accurateValue =
        await coinData.getCoinPrice(selectedCryptoCurrency, selectedCurrency);
    valueInConvertedCurrency =
        double.parse((accurateValue).toStringAsFixed(2)).toString();
    double accurateValue2 =
        await coinData.getCoinPrice(selectedCryptoCurrency2, selectedCurrency);
    valueInConvertedCurrency2 =
        double.parse((accurateValue2).toStringAsFixed(2)).toString();
    double accurateValue3 =
        await coinData.getCoinPrice(selectedCryptoCurrency3, selectedCurrency);
    valueInConvertedCurrency3 =
        double.parse((accurateValue3).toStringAsFixed(2)).toString();
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getInitialConversion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Color(0xFF00787A),
        title: Text(
          'Bitcoin Ticker',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Visibility(
            visible: isLoading,
            child: Center(
              child: SpinKitPouringHourglass(
                color: Colors.green,
                size: 50.0,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 20.0),
                child: Card(
                  color: Colors.green[500],
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    child: Text(
                      '1 $selectedCryptoCurrency = $valueInConvertedCurrency $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 20.0),
                child: Card(
                  color: Colors.green[500],
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    child: Text(
                      '1 $selectedCryptoCurrency2 = $valueInConvertedCurrency2 $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 20.0),
                child: Card(
                  color: Colors.green[500],
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    child: Text(
                      '1 $selectedCryptoCurrency3 = $valueInConvertedCurrency3 $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      20.0,
                      0.0,
                      10.0,
                      60.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF007939),
                          Color(0xFF94ebd8),
                        ],
                      ),
                    ),
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(vertical: 7.0, horizontal: 20.0),
                    child: DropdownButton<String>(
                      dropdownColor: Color(0xFF004344),
                      iconSize: 60.0,
                      iconEnabledColor: Colors.white,
                      value: selectedCryptoCurrency,
                      items: getDropdownItemsCryptocurrency(),
                      onChanged: (value) async {
                        selectedCryptoCurrency = value;
                        isLoading = true;
                        setState(() {});
                        double accurateValue = await coinData.getCoinPrice(
                            selectedCryptoCurrency, selectedCurrency);
                        valueInConvertedCurrency =
                            double.parse((accurateValue).toStringAsFixed(2))
                                .toString();
                        isLoading = false;
                        setState(() {});
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      10.0,
                      0.0,
                      20.0,
                      60.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF007939),
                          Color(0xFF94ebd8),
                        ],
                      ),
                    ),
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(vertical: 7.0, horizontal: 20.0),
                    child: DropdownButton<String>(
                      dropdownColor: Color(0xFF004344),
                      iconSize: 60.0,
                      iconEnabledColor: Colors.white,
                      value: selectedCurrency,
                      items: getDropdownItems(),
                      onChanged: (value) async {
                        selectedCurrency = value;
                        isLoading = true;
                        setState(() {});
                        double accurateValue = await coinData.getCoinPrice(
                            selectedCryptoCurrency, selectedCurrency);
                        valueInConvertedCurrency =
                            double.parse((accurateValue).toStringAsFixed(2))
                                .toString();

                        isLoading = false;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
