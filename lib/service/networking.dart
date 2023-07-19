import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode==200) {
      String weatherData = response.body;
      print(weatherData);
      var decodedData = jsonDecode(weatherData);

      return decodedData;
    }
    else{
      print(response.statusCode);
    }
  }
}