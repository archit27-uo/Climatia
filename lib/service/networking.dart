import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.urlWeather, this.urlTime);

  final String urlWeather;
  final String urlTime;
  Future getTimeData() async{
    http.Response response = await http.get(Uri.parse(urlTime));
    if(response.statusCode==200){
      String timeData = response.body;
      return jsonDecode(timeData);
    }
    else{
      print(response.statusCode);
    }
  }
  Future getData() async {
    http.Response response = await http.get(Uri.parse(urlWeather));
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