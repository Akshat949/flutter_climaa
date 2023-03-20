import 'package:geolocator/geolocator.dart';
class Location{
  Position? position;

  double? latitude;
  double? longitude;

  Future<void>getCurrentLocation()async{
    Position position=await determineposition();
    latitude=position.latitude;
    longitude=position.longitude;
  }
  Future<Position>determineposition()async{
    LocationPermission permission;
    permission=await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission=await Geolocator.requestPermission();
      if(permission==LocationPermission.denied){
        return Future.error('permission denied');
      }
    }
    return await Geolocator.getCurrentPosition();
  }
}