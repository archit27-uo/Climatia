import 'package:climatica/service/weather.dart';
import 'package:flutter/material.dart';
import 'package:climatica/utilities/constant.dart';
import 'package:climatica/screens/city_screen.dart';
//import 'package:climatica/service/weather.dart';


class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeatherData, this.timeZoneData});
  final timeZoneData;
  final locationWeatherData;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUiData(widget.locationWeatherData, widget.timeZoneData);
    if (widget.locationWeatherData != null) {
      print('here');
     imageLink = weatherModel.getWeatherIcon(widget.locationWeatherData['weather'][0]['id']);
    }
    print('init complete');
  }
  var cardRow = <Widget>[];
  WeatherModel weatherModel = WeatherModel();
  late double timelat;
  late double timelon;
  late int temperature;
  late double temp;
  late int id;
  late String cityName;
  late String imageLink;
  late String dateTime;
  late String sunrise;
  late String sunset;
  late String pressure;
  late String humidity;
  late String windSpeed;
  late String cloud;
  late String temp_min;
  late String temp_max;
  int temp_val = 38;
 // print(dDay.timeZoneOffset);
  void updateUiData(dynamic weatherData, dynamic timeDateData){
    setState(() {
      if(weatherData==null){
        return;
      }
      if(timeDateData==null){
        return;
      }

      temp = weatherData['list'][0]['main']['temp'];
      temperature = temp.toInt();
      id = weatherData['list'][0]['weather'][0]['id'];
      cityName = weatherData['city']['name'];
      int tempsunrise = weatherData['city']['sunrise'];
      sunrise = DateTime.fromMillisecondsSinceEpoch(tempsunrise * 1000).toString().substring(10,16);
      int tempsunset = weatherData['city']['sunset'];
      sunset = DateTime.fromMillisecondsSinceEpoch(tempsunset * 1000).toString().substring(10,16);
      pressure = weatherData['list'][0]['main']['pressure'].toString();
      humidity = weatherData['list'][0]['main']['humidity'].toString();
          imageLink = weatherModel.getWeatherIcon(id);
      windSpeed = weatherData['list'][0]['wind']['speed'].toString();
      cloud = weatherData['list'][0]['clouds']['all'].toString();
      temp_max = weatherData['list'][0]['main']['temp_max'].toString();
      temp_min = weatherData['list'][0]['main']['temp_min'].toString();
      //timeZoneOffset = weatherData['timezone'];
      dateTime = timeDateData['formatted'];

      print("updateui");

      cardRow.add(cardtile(temp_val: temp_val));
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Material(
          elevation: 100,
          child: Container(

            decoration: BoxDecoration(
              
              image: DecorationImage(
                image: AssetImage(imageLink),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.8), BlendMode.dstATop),
              ),
            ),
            constraints: BoxConstraints.expand(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text(
                      '$cityName',
                      style: kConditionTextStyle,

                    ),
                    TextButton(
                      onPressed: () async {
                        var typedCityName = await Navigator.push(context, MaterialPageRoute(builder: (context){
                          return CityScreen();
                        }));
                        if(typedCityName!=null) {
                          var weatherData = await WeatherModel().getWeatherByCItyName(typedCityName);
                          timelat = weatherData['coord']['lat'];
                          timelon = weatherData['coord']['lon'];
                          var timeData = await WeatherModel().getDataTimeByCItyName(timelat, timelon);
                         updateUiData(weatherData,timeData);
                          print(typedCityName);
                          print(id);
                        }

                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                          color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                         // margin: EdgeInsets.only(top: 110),
                          child: Text(
                            "${dateTime.substring(10,16)}",
                            style: kMessageTextStyle,
                          ),

                        ),
                        Text(
                          '$temperature°',
                          style: kTempTextStyle,
                        ),
                        Text(
                          'Feels like 16°'
                        ),
                        Divider(
                          color: Colors.white60,
                          thickness: 1.4,
                          indent: 0,
                          endIndent: 0,
                        ),
                        Container(
                         child :Row(
                           children: cardRow,
                         )
                        ),
                        Container(

                          child: Column(
                           crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              CardRowTiles(fieldName1:'SUNRISE',fieldValue1: sunrise,fieldName2: 'SUNSET',fieldValue2: sunset,),
                              Divider(
                                color: Colors.black45,
                                thickness: 2,
                                indent: 12,
                                endIndent: 12,
                              ),
                              CardRowTiles(fieldName1:'PRESSURE',fieldValue1: pressure,fieldName2: 'HUMIDITY',fieldValue2: humidity,),
                              Divider(
                                color: Colors.black45,
                                thickness: 2,
                                indent: 12,
                                endIndent: 12,
                              ),
                              CardRowTiles(fieldName1:'WIND SPEED',fieldValue1: windSpeed,fieldName2: 'CLOUD',fieldValue2: cloud,),
                              Divider(
                                color: Colors.black45,
                                thickness: 2,
                                indent: 12,
                                endIndent: 12,
                              ),
                              CardRowTiles(fieldName1:'MIN TEMP',fieldValue1: temp_min,fieldName2: 'MAX TEMP',fieldValue2: temp_max,)
                            ],
                          ),

                          decoration: BoxDecoration(
                              color: Color(0xFFEEEDED),
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25) )
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class cardtile extends StatelessWidget {
  const cardtile({
    super.key,
    required this.temp_val,
  });

  final int temp_val;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      child: Container(

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20 , horizontal: 8),
          child: Text(
            "$temp_val°",
            style: TextStyle(
                color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),

        ),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.white70,
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(25), bottom: Radius.circular(25) ),

        ),
      ),
    );
  }
}

class CardRowTiles extends StatelessWidget {
  const CardRowTiles({
    super.key,
    required this.fieldValue1,
    required this.fieldName1,
    required this.fieldValue2,
    required this.fieldName2,
  });

  final String fieldValue1;
  final String fieldName1;
  final String fieldValue2;
  final String fieldName2;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(

        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              margin: EdgeInsets.only(top: 3, left: 30 ),
              child: Column(
                children: [
                  Text(
                      '$fieldName1',
                    style: kCardTextStyle,
                  ),
                  Text(
                      '$fieldValue1',
                    style: kCardValueStyle,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 110,
          ),
          Container(
            child: Column(

              children: [
                Text(
                  '$fieldName2',
                  style: kCardTextStyle,
                ),

                Text(
                  '$fieldValue2',
                  style: kCardValueStyle,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}