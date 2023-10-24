import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherApp(),
    );
  }
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String cityName = "";
  String temperature = "";
  String condition = "";
  String errorMessage = "";

  Future<void> fetchWeather(String city) async {
    final apiUrl = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid="821384b8313707653ad10607109cad13"';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          temperature = (data['main']['temp'] - 273.15).toStringAsFixed(1);
          condition = data['weather'][0]['description'];
          errorMessage = "";
        });
      } else {
        setState(() {
          errorMessage = "Ciudad no encontrada. Inténtalo de nuevo.";
          temperature = "";
          condition = "";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error de conexión. Comprueba tu conexión a Internet.";
        temperature = "";
        condition = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima Simplificado'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                cityName = value;
              },
              decoration: InputDecoration(
                hintText: 'Ingresa el nombre de la ciudad',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (cityName.isNotEmpty) {
                  fetchWeather(cityName);
                }
              },
              child: Text('Obtener Clima'),
            ),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            if (temperature.isNotEmpty)
              Column(
                children: [
                  Text('Temperatura: $temperature °C'),
                  Text('Condición: $condition'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
