// lib/models/weather_model.dart
class WeatherInfo {
  final String main;
  final String description;
  final String icon;

  WeatherInfo({
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class DailyWeather {
  final int dt;
  final double tempDay;
  final double tempMin;
  final double tempMax;
  final double pop; // Probability of precipitation (rain)
  final double windSpeed;
  final WeatherInfo weatherInfo;
  double bikeRideScore; // Add this property

  DailyWeather({
    required this.dt,
    required this.tempDay,
    required this.tempMin,
    required this.tempMax,
    required this.pop,
    required this.windSpeed,
    required this.weatherInfo,
    this.bikeRideScore = 0.0, // Initialize to 0
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      dt: json['dt'],
      tempDay: json['temp']['day'].toDouble(),
      tempMin: json['temp']['min'].toDouble(),
      tempMax: json['temp']['max'].toDouble(),
      pop: json['pop'].toDouble(),
      windSpeed: json['wind_speed'].toDouble(),
      weatherInfo: WeatherInfo.fromJson(json['weather'][0]),
    );
  }
}