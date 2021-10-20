import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherDetails extends StatefulWidget {
  @override
  _WeatherDetailsState createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {
  TextEditingController cityInput = TextEditingController();
  Map data = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: (AppBar(
        centerTitle: true,
        title: Text(
          'Weather Screen',
        ),
        backgroundColor: Color(0xFF151026),
      )),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                'https://scied.ucar.edu/sites/default/files/images/large_image_for_image_content/weather_0.jpg'),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                style: TextStyle(fontWeight: FontWeight.bold),
                controller: cityInput,
                decoration: InputDecoration(
                  labelText: 'City',
                  suffixIcon: InkWell(
                      onTap: () {
                        getWeatherDetails(cityInput.text);
                      },
                      child: Icon(Icons.search)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            if (data.isNotEmpty) getWidget('City', data['name']),
            SizedBox(
              height: 20,
            ),
            if (data.isNotEmpty)
              getWidget('Description', data['weather'][0]['description']),
            SizedBox(
              height: 20,
            ),
            if (data.isNotEmpty)
              getWidget('Temprature', data['main']['temp'].toString()),
            SizedBox(
              height: 20,
            ),
            if (data.isNotEmpty)
              getWidget('Perceived', data['coord']['lon'].toStringAsFixed(2)),
            SizedBox(
              height: 20,
            ),
            if (data.isNotEmpty)
              getWidget('Pressure', data['main']['pressure'].toString()),
            SizedBox(
              height: 20,
            ),
            if (data.isNotEmpty)
              getWidget('Humidity', data['main']['humidity'].toString()),
          ],
        ),
      ),
    );
  }

  Widget getWidget(String title, String data) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: Text(
            data,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ],
    );
  }

  Future getWeatherDetails(String city) async {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=9008f007aec2e5db70ff7893b5f62042");
    final response = await http.get(url);
    data = jsonDecode(response.body);

    setState(() {});
  }
}
