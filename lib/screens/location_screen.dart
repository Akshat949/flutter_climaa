import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:climaa/utilities/constants.dart';
import 'package:climaa/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen({this.locationWeather});


  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int? temp;
  String? weatherIcon;
  String? name;
  String? weatherMessage;
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData){
    if(weatherData==null){
      temp=0;
      weatherIcon='error';
      weatherMessage='unable to display';
      name='';
      return;
    }
     double temperature = jsonDecode(weatherData)['main']['temp'];
     temp=temperature.toInt();
     var id = jsonDecode(weatherData)['weather'][0]['id'];
     weatherIcon=weatherModel.getWeatherIcon(id);
     weatherMessage=weatherModel.getMessage(temp!);
     name = jsonDecode(weatherData)['name'];

     print(temp);
     print(id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                 ElevatedButton(
                    onPressed: () async {
                      var weatherData=await weatherModel.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async{
                      var typedName=await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      },
                      ),
                      );
                      if(typedName!=null){
                        var weatherData=await weatherModel.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon!,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $name",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}