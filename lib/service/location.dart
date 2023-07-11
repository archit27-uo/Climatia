import 'package:geolocator/geolocator.dart';


class Location {
  late double latitude;
  late double longitude;

  Future<void> getCurrentLocation() async {
    int c =1;

      // try{
      //   LocationPermission permission;
      //   permission = await Geolocator.requestPermission();
      // }
      // catch (e){
      //   print(e);
      // }

//late final Position position;
// //     void getL async{
//       if(c==1){
//         getPermission();
//         print("pass2");
//         c++;
//       }
      bool servicestatus = await Geolocator.isLocationServiceEnabled();

      if(servicestatus){
        print("GPS service is enabled");
      }else{
        print("GPS service is disabled.");
      }

      try{
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        latitude = position.latitude;
        longitude = position.longitude;
      }
      catch(e){
        print(e);
      }
    }
  }
