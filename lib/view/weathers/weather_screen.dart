import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math' as math;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  bool isLoading = true;
  String errorMessage = '';
  WeatherForecast? forecast;
  String cityName = '';

  @override
  void initState() {
    super.initState();
    _getLocationAndWeather();
  }

  Future<void> _getLocationAndWeather() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      // Get location permission
      var status = await Permission.location.request();
      if (status.isGranted) {
        // Get current position
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low,
        );

        // Get weather data based on location
        await _getWeatherData(position.latitude, position.longitude);
      } else {
        setState(() {
          errorMessage = 'Location permission is required to get local weather.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to get location: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _getWeatherData(double lat, double lon) async {
    // Replace API_KEY with your actual API key
    const apiKey = '5f1078fa7a857cee87b12f1c2c44894f';
    final url = 'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&exclude=minutely,hourly&units=metric&appid=$apiKey';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Get city name from coordinates
        await _getCityName(lat, lon);

        setState(() {
          forecast = WeatherForecast.fromJson(data);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load weather data: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching weather data: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _getCityName(double lat, double lon) async {
    const apiKey = '5f1078fa7a857cee87b12f1c2c44894f';
    final url = 'https://api.openweathermap.org/geo/1.0/reverse?lat=$lat&lon=$lon&limit=1&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.isNotEmpty) {
          setState(() {
            cityName = '${data[0]['name']}, ${data[0]['country']}';
          });
        }
      }
    } catch (e) {
      print('Error getting city name: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bike Ride Weather Forecast'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _getLocationAndWeather,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _getLocationAndWeather,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      )
          : _buildForecastView(),
    );
  }

  Widget _buildForecastView() {
    if (forecast == null) {
      return const Center(child: Text('No data available'));
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                cityName.isNotEmpty ? cityName : 'Current Location',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Today: ${forecast!.daily[0].weather[0].description.toCapitalized()}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _getWeatherIcon(forecast!.daily[0].weather[0].icon, size: 64),
                  const SizedBox(width: 16),
                  Column(
                    children: [
                      Text(
                        '${forecast!.daily[0].temp.day.round()}°C',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Feels like: ${forecast!.daily[0].feelsLike.day.round()}°C',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildInfoColumn(
                    Icons.water_drop,
                    '${forecast!.daily[0].humidity}%',
                    'Humidity',
                  ),
                  _buildInfoColumn(
                    Icons.air,
                    '${forecast!.daily[0].windSpeed} m/s',
                    'Wind',
                  ),
                  _buildInfoColumn(
                    Icons.wb_sunny_outlined,
                    '${forecast!.daily[0].uvi.round()}',
                    'UV Index',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildBikeScoreIndicator(
                calculateBikeRideScore(forecast!.daily[0]),
                large: true,
              ),
            ],
          ),
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            '7-Day Bike Ride Forecast',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: forecast!.daily.length,
            itemBuilder: (context, index) {
              final day = forecast!.daily[index];
              final date = DateTime.fromMillisecondsSinceEpoch(day.dt * 1000);
              final dateText = index == 0
                  ? 'Today'
                  : index == 1
                  ? 'Tomorrow'
                  : DateFormat('EEEE').format(date);
              final bikeScore = calculateBikeRideScore(day);

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          dateText,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _getWeatherIcon(day.weather[0].icon),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${day.temp.day.round()}°C',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Rain: ${(day.pop * 100).round()}%',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).brightness == Brightness.light
                                    ? Colors.blue[700]
                                    : Colors.blue[300],
                              ),
                            ),
                            Text(
                              'Wind: ${day.windSpeed.toStringAsFixed(1)} m/s',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: _buildBikeScoreIndicator(bikeScore),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBikeScoreIndicator(int score, {bool large = false}) {
    Color scoreColor;
    String scoreText;

    if (score >= 80) {
      scoreColor = Colors.green;
      scoreText = 'Perfect';
    } else if (score >= 60) {
      scoreColor = Colors.lightGreen;
      scoreText = 'Great';
    } else if (score >= 40) {
      scoreColor = Colors.amber;
      scoreText = 'Good';
    } else if (score >= 20) {
      scoreColor = Colors.orange;
      scoreText = 'Fair';
    } else {
      scoreColor = Colors.red;
      scoreText = 'Rubbish';
    }

    return Column(
      children: [
        Text(
          large ? 'Bike Ride Conditions' : 'Bike Score',
          style: TextStyle(
            fontSize: large ? 16 : 12,
            fontWeight: large ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: large ? 200 : 100,
          height: large ? 24 : 16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(large ? 12 : 8),
            color: Colors.grey[300],
          ),
          child: Row(
            children: [
              Expanded(
                flex: score,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(large ? 12 : 8),
                    color: scoreColor,
                  ),
                ),
              ),
              Expanded(
                flex: 100 - score,
                child: Container(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$score% - $scoreText',
          style: TextStyle(
            fontSize: large ? 16 : 12,
            fontWeight: FontWeight.bold,
            color: scoreColor,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoColumn(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _getWeatherIcon(String iconCode, {double size = 40}) {
    return Image.network(
      'https://openweathermap.org/img/wn/$iconCode@2x.png',
      width: size,
      height: size,
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          Icons.cloud,
          size: size,
        );
      },
    );
  }

  // Bike Ride Score Algorithm
  int calculateBikeRideScore(DailyForecast day) {
    // 1. Temperature Component (0-100)
    // Ideal temperature for cycling: 15-25°C
    int tempScore;
    final temp = day.temp.day;

    if (temp >= 15 && temp <= 25) {
      tempScore = 100;  // Ideal temperature range
    } else if (temp >= 10 && temp < 15) {
      tempScore = 80;   // Slightly cool but good
    } else if (temp > 25 && temp <= 30) {
      tempScore = 70;   // Slightly warm but good
    } else if (temp >= 5 && temp < 10) {
      tempScore = 50;   // Cool
    } else if (temp > 30 && temp <= 35) {
      tempScore = 40;   // Hot
    } else if (temp >= 0 && temp < 5) {
      tempScore = 20;   // Very cold
    } else if (temp > 35) {
      tempScore = 10;   // Very hot
    } else {
      tempScore = 0;    // Below freezing
    }

    // 2. Rain Probability Component (0-100)
    // pop = Probability of Precipitation (0-1)
    int rainScore = 100 - (day.pop * 100).round();

    // 3. Wind Speed Component (0-100)
    // Ideal wind speed for cycling: 0-3 m/s
    int windScore;
    final windSpeed = day.windSpeed;

    if (windSpeed < 3) {
      windScore = 100;                      // Ideal conditions
    } else if (windSpeed >= 3 && windSpeed < 5) {
      windScore = 90;                       // Light breeze
    } else if (windSpeed >= 5 && windSpeed < 8) {
      windScore = 70;                       // Moderate wind
    } else if (windSpeed >= 8 && windSpeed < 11) {
      windScore = 40;                       // Strong wind
    } else {
      windScore = math.max(0, 100 - (windSpeed * 10).round());  // Very windy
    }

    // Additional factors
    // Weather condition penalty
    int weatherPenalty = 0;
    final weatherId = day.weather[0].id;

    // Weather condition codes: https://openweathermap.org/weather-conditions
    if (weatherId >= 200 && weatherId < 300) {
      weatherPenalty = 70;  // Thunderstorm
    } else if (weatherId >= 300 && weatherId < 400) {
      weatherPenalty = 40;  // Drizzle
    } else if (weatherId >= 500 && weatherId < 600) {
      weatherPenalty = 60;  // Rain
    } else if (weatherId >= 600 && weatherId < 700) {
      weatherPenalty = 80;  // Snow
    } else if (weatherId >= 700 && weatherId < 800) {
      weatherPenalty = 30;  // Atmosphere (fog, haze)
    }

    // Combine all factors
    // Temperature: 40%, Rain: 35%, Wind: 25%
    final combinedScore = (tempScore * 0.4) + (rainScore * 0.35) + (windScore * 0.25);

    // Apply weather condition penalty
    final finalScore = math.max(0, combinedScore * (1 - (weatherPenalty / 100)));

    return finalScore.round();
  }
}

// Models for Weather Data

class WeatherForecast {
  final List<DailyForecast> daily;

  WeatherForecast({required this.daily});

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    List<DailyForecast> dailyList = [];
    for (var item in json['daily']) {
      dailyList.add(DailyForecast.fromJson(item));
    }

    return WeatherForecast(daily: dailyList);
  }
}

class DailyForecast {
  final int dt;
  final Temp temp;
  final FeelsLike feelsLike;
  final int humidity;
  final double windSpeed;
  final double uvi;
  final List<Weather> weather;
  final double pop;  // Probability of precipitation

  DailyForecast({
    required this.dt,
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.uvi,
    required this.weather,
    required this.pop,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    List<Weather> weatherList = [];
    for (var item in json['weather']) {
      weatherList.add(Weather.fromJson(item));
    }

    return DailyForecast(
      dt: json['dt'],
      temp: Temp.fromJson(json['temp']),
      feelsLike: FeelsLike.fromJson(json['feels_like']),
      humidity: json['humidity'],
      windSpeed: json['wind_speed'].toDouble(),
      uvi: json['uvi'].toDouble(),
      weather: weatherList,
      pop: json['pop'].toDouble(),
    );
  }
}

class Temp {
  final double day;
  final double min;
  final double max;
  final double night;
  final double eve;
  final double morn;

  Temp({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  factory Temp.fromJson(Map<String, dynamic> json) {
    return Temp(
      day: json['day'].toDouble(),
      min: json['min'].toDouble(),
      max: json['max'].toDouble(),
      night: json['night'].toDouble(),
      eve: json['eve'].toDouble(),
      morn: json['morn'].toDouble(),
    );
  }
}

class FeelsLike {
  final double day;
  final double night;
  final double eve;
  final double morn;

  FeelsLike({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  factory FeelsLike.fromJson(Map<String, dynamic> json) {
    return FeelsLike(
      day: json['day'].toDouble(),
      night: json['night'].toDouble(),
      eve: json['eve'].toDouble(),
      morn: json['morn'].toDouble(),
    );
  }
}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

// Extension to capitalize first letter
extension StringExtension on String {
  String toCapitalized() => this.length > 0
      ? '${this[0].toUpperCase()}${this.substring(1)}'
      : '';
}