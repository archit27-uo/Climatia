import 'package:climatica/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:climatica/service/location.dart';
import 'package:climatica/service/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }
  late double lat;
  late double lon;
 void getLocationData() async {
   Location L = Location();
   await L.getCurrentLocation();
   lat = L.latitude;
   lon = L.longitude;
   // print(lat);
   // print(lon);
   print('initstate initiated');

   NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=6b60eeea441d8f7768e627144409cf08&units=metric');

   var weatherData =  await networkHelper.getData();

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(locationWeatherData: weatherData,);
    }));

   // print(temperature);
   // print(id);
   // print(cityName);
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitThreeBounce(
            color: Colors.white,
            size: 50.0,
          ),
      ),
    );
  }
}