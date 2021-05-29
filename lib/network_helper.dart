import 'package:http/http.dart';
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  String url;
  var decodedData;
  String data;
  Future getData() async {
    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      data = response.body;
    } else {
      print('${response.statusCode}');
    }
    decodedData = jsonDecode(data);
    return decodedData;
  }
}
