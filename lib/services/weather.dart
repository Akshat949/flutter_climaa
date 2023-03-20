import 'package:climaa/services/location.dart';
import 'package:climaa/services/networking.dart';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName)async{
    NetworkHelpher networkHelpher = NetworkHelpher('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=74882db80353a2125fa90e5838b07a76&units=metric');
    var weatherData=await networkHelpher.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather()async{
    Location location=Location();
    await location.getCurrentLocation();

    NetworkHelpher networkHelpher = NetworkHelpher('https://api.openweathermap.org/data/2.5/weather?lat=${location
    .latitude}&lon=${location.longitude}&appid=74882db80353a2125fa90e5838b07a76&units=metric');
    var weatherData=await networkHelpher.getData();

    return weatherData;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
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
