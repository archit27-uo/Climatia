import 'package:flutter/material.dart';
import 'package:climatica/service/location.dart';


class LoadingScreen extends StatefulWidget {

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }
 void getLocation() async {
   Location L = Location();
   await L.getCurrentLocation();
   print(L.latitude);
   print(L.longitude);
   print('initstate initiated');
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //Get the current location
            //getPermission();

          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}