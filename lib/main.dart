// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WeatherApp(),
  ));
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  State<WeatherApp> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<WeatherApp> {
  int temp = 30;
  String weather = "Clear";
  int humidity = 10;
  int pressure = 1010;
  double wind_speed = 5;
  String city = "Sample City";
  String app_id = '0f18418e5cb305bf3d9d678fb49c5e26';
  String icon_url = "http://openweathermap.org/img/w/03n.png";
  String city_api_url = 'https://api.openweathermap.org/data/2.5/weather?q=';

  void fetch_location() async {
    var location_result = await http.get(Uri.parse('$city_api_url$city&appid=$app_id'));
    var result = json.decode(location_result.body);

    setState(() {
      weather = result["weather"][0]["main"];
      temp = (result["main"]["temp"] - 273.15).round();
      pressure = result["main"]["pressure"].round();
      humidity = result["main"]["humidity"].round();
      wind_speed = ((result["wind"]["speed"])*(18/5)).round();
      icon_url = "${"http://openweathermap.org/img/w/" + result["weather"][0]["icon"]}.png";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1E32),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD83457),
        title: const Text(
          "Weather", style: TextStyle(color: Color(0xFFD5E4F7),fontSize: 30,fontWeight: FontWeight.bold,),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              color : Colors.black87,
              child: TextField(
                textAlign: TextAlign.left,
                onSubmitted: (String input)
                {
                  city = input;
                  fetch_location();
                },
                style: const TextStyle(color: Colors.yellow, fontSize: 35),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left : 40,top: 20 , bottom: 20),
                  hintText: "Enter City Name",
                  hintStyle: const TextStyle(
                    color: Colors.purpleAccent,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                    size: 40,
                    color: Colors.amber[900],
                  ),
                ),
              ),
            ),
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color : Colors.blue[900],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              //Icon(_icons[index],size: 100, color: Colors.yellow,),
                ImageIcon(
                  NetworkImage(icon_url),
                  color: Colors.yellow,
                  size: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    style: const TextStyle(
                      fontSize: 65,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    city.toUpperCase(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "$temp" "°C",
                    style: const TextStyle(
                      fontSize: 45,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Icon(
                    Icons.thermostat_sharp,
                    size: 40,
                    color: Colors.orange[900],
                  ),
                  title: const Text(
                    "Temperature",
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    "$temp" " °C",
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Icon(
                    Icons.speed_sharp,
                    size: 40,
                    color: Colors.yellow[700],
                  ),
                  title: const Text(
                    "Wind Speed",
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    "$wind_speed km/h",
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Icon(
                    Icons.cloud,
                    size: 40,
                    color: Colors.blue[100],
                  ),
                  title: const Text(
                    "Weather",
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    weather,
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.water_drop_outlined,
                    size: 40,
                    color: Colors.blue,
                  ),
                  title: const Text(
                    "Humidity",
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    "$humidity %",
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Icon(
                    Icons.air_rounded,
                    size: 40,
                    color: Colors.blue[100],
                  ),
                  title: const Text(
                    "Pressure",
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    "$pressure mbar",
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

//final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=Bengaluru&appid=0f18418e5cb305bf3d9d678fb49c5e26');

/*
//print(jsonDecode(response.body)["weather"][0]["description"]
{coord: {lon: 77.6033, lat: 12.9762},
weather: [{id: 802, main: Clouds, description: scattered clouds, icon: 03n}],
base: stations,
main: {temp: 292.95, feels_like: 293.6, temp_min: 292.95, temp_max: 296.05, pressure: 1012, humidity: 100},
visibility: 6000,
wind: {speed: 1.03, deg: 250}, clouds: {all: 40},
dt: 1654540502,
sys: {type: 1, id: 9205, country: IN, sunrise: 1654561359, sunset: 1654607664},
timezone: 19800, id: 1277333, name: Bengaluru, cod: 200}*/
