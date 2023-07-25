import 'package:climatica/service/networking.dart';

class WeatherModel {

  Future<dynamic> getWeatherByCItyName(String cityName) async {

    NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=6b60eeea441d8f7768e627144409cf08&units=metric', 'http://api.timezonedb.com/v2.1/get-time-zone?key=T7C7DKXT66FT&format=json&by=position&lat=40.689247&lng=-74.044502');
    var weatherData =  await networkHelper.getData();
    return weatherData;
  }
  Future<dynamic> getDataTimeByCItyName(double lat, double lon) async {

    NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=6b60eeea441d8f7768e627144409cf08&units=metric', 'http://api.timezonedb.com/v2.1/get-time-zone?key=T7C7DKXT66FT&format=json&by=position&lat=$lat&lng=$lon');
    var timeData =  await networkHelper.getTimeData();
    return timeData;
  }



  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return 'images/Thunderstorm.jpg';
    } else if (condition < 400) {
      return 'images/rain.jpg';
    } else if (condition < 600) {
      return 'images/drizzle.jpg';
    } else if (condition < 700) {
      return 'images/snow.jpg';
    } else if (condition < 800) {
      return 'images/fog.jpg';
    } else if (condition == 800) {
      return 'images/clearDay.jpg';
    } else if (condition <= 804) {
      return 'images/cloud.jpg';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}