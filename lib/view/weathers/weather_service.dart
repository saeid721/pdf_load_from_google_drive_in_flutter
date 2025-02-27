// lib/services/weather_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

import 'weather_model.dart';

class WeatherService {
  final String apiKey = '5f1078fa7a857cee87b12f1c2c44894f'; // Replace with your API key
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/onecall';

  Future<List<DailyWeather>> getWeatherData() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final lat = position.latitude;
      final lon = position.longitude;

      final response = await http.get(Uri.parse(
          '$baseUrl?lat=$lat&lon=$lon&exclude=minutely,hourly,alerts&appid=$apiKey&units=metric'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final dailyData = data['daily'] as List;
        List<DailyWeather> weatherList =
        dailyData.map((item) => DailyWeather.fromJson(item)).toList();

        // Calculate bike ride scores for each day
        for (var weather in weatherList) {
          weather.bikeRideScore = calculateBikeRideScore(
              weather.tempDay, weather.pop, weather.windSpeed);
        }

        return weatherList;
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  double calculateBikeRideScore(
      double temperature, double rainChance, double windSpeed) {
    // Ideal ranges
    const double idealTempMin = 15.0;
    const double idealTempMax = 25.0;
    const double maxRainChance = 0.2; // 20%
    const double maxWindSpeed = 20.0; // km/h

    // Temperature score
    double tempScore;
    if (temperature >= idealTempMin && temperature <= idealTempMax) {
      tempScore = 1.0;
    } else if (temperature < idealTempMin) {
      tempScore = (temperature - (idealTempMin - 10)) / 10; // Linearly decrease
      tempScore = tempScore < 0 ? 0 : tempScore;
    } else {
      tempScore = (idealTempMax + 10 - temperature) / 10; // Linearly decrease
      tempScore = tempScore < 0 ? 0 : tempScore;
    }

    // Rain score
    double rainScore;
    if (rainChance <= maxRainChance) {
      rainScore = 1 - (rainChance / maxRainChance) * 0.5; // Decrease to 50%
    } else {
      rainScore = 0.5 - ((rainChance - maxRainChance) / (1 - maxRainChance)) * 0.5; // Decrease to 0%
      rainScore = rainScore < 0 ? 0 : rainScore;
    }

    // Wind score
    double windScore;
    if (windSpeed <= maxWindSpeed) {
      windScore = 1 - (windSpeed / maxWindSpeed) * 0.5; // Decrease to 50%
    } else {
      windScore = 0.5 - ((windSpeed - maxWindSpeed) / (maxWindSpeed * 2)) * 0.5; // Decrease to 0%
      windScore = windScore < 0 ? 0 : windScore;
    }

    // Average the scores
    double finalScore = (tempScore + rainScore + windScore) / 3;
    return finalScore * 100; // Convert to percentage
  }
}