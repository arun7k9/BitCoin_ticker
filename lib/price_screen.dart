import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();
  bool isLoading = false;
  String selectedCurrency = 'USD';
  String selectedCryptoCurrency = 'BTC';
  String valueInConvertedCurrency = '';
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
      appBar: AppBar(
        title: Text('coin ticker'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0.0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 150.0,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(bottom: 30.0),
                      color: Colors.blue[700],
                      child: DropdownButton<String>(
                        dropdownColor: Colors.deepPurple[200],
                        iconSize: 60.0,
                        iconEnabledColor: Colors.green[200],
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
                      height: 150.0,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(bottom: 30.0),
                      color: Colors.blue[700],
                      child: DropdownButton<String>(
                        dropdownColor: Colors.deepPurple[200],
                        iconSize: 60.0,
                        iconEnabledColor: Colors.green[200],
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
    );
  }
}
