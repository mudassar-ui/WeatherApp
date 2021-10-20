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
            if (data.isNotEmpty)
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'City:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      data['name'],
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            SizedBox(
              height: 20,
            ),
            //description

            if (data.isNotEmpty)
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Description:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      data['weather'][0]['description'],
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            SizedBox(
              height: 20,
            ),

            //Temprature

            if (data.isNotEmpty)
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Temprature:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      data['main']['temp'].toString(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            SizedBox(
              height: 20,
            ),
            //Perceived

            if (data.isNotEmpty)
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Perceived:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      data['coord']['lon'].toStringAsFixed(2),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            SizedBox(
              height: 20,
            ),
            //Pressure
            if (data.isNotEmpty)
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Pressure:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      data['main']['pressure'].toString(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            SizedBox(
              height: 20,
            ),
            //Humidity
            if (data.isNotEmpty)
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Humidity:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      data['main']['humidity'].toString(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Future getWeatherDetails(String city) async {
    //print(city);

    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=9008f007aec2e5db70ff7893b5f62042");
    final response = await http.get(url);
    data = jsonDecode(response.body);
    print(data);
    print(data['name']);
    print(data['weather'][0]['description']);
    print(data['main']['temp'].toDouble());
    print(data['coord']['lon'].toDouble());
    print(data['main']['pressure'].toDouble());
    print(data['main']['humidity'].toDouble());
    setState(() {});
  }
}
