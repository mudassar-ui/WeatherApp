import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherDetails extends StatefulWidget {
  @override
  _WeatherDetailsState createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {
  TextEditingController cityInput = TextEditingController();
  Map weatherData = {};
  final _form = GlobalKey<FormState>();
  final validCharacters = RegExp(r'^[0-9_\=@,\;*]+$');
  final specialChar = RegExp(r'^[_\-=@,\.;+*]+$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: (AppBar(
        centerTitle: true,
        title: Text(
          'Weather Application',
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
            // Search field
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _form,
                child: TextFormField(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  controller: cityInput,
                  validator: (cityInput) {
                    if (cityInput!.isEmpty) {
                      return 'Please provide city name.';
                    }
                    if (cityInput.contains(validCharacters)) {
                      return 'dont enter numbers .';
                    }
                    if (cityInput.contains(specialChar)) {
                      return 'dont enter special characters .';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter City name',
                    suffixIcon: InkWell(
                        onTap: () {
                          final isValid = _form.currentState!.validate();

                          if (!isValid) {
                            return;
                          }
                          getWeatherDetails(cityInput.text);
                        },
                        child: Icon(Icons.search)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            //Weather Details

            if (weatherData.isNotEmpty) getWidget('City', weatherData['name']),
            SizedBox(
              height: 10,
            ),
            if (weatherData.isNotEmpty)
              getWidget(
                  'Description', weatherData['weather'][0]['description']),
            SizedBox(
              height: 10,
            ),
            if (weatherData.isNotEmpty)
              getWidget('Temprature', weatherData['main']['temp'].toString()),
            SizedBox(
              height: 10,
            ),
            if (weatherData.isNotEmpty)
              getWidget(
                  'Perceived', weatherData['coord']['lon'].toStringAsFixed(2)),
            SizedBox(
              height: 10,
            ),
            if (weatherData.isNotEmpty)
              getWidget('Pressure', weatherData['main']['pressure'].toString()),
            SizedBox(
              height: 10,
            ),
            if (weatherData.isNotEmpty)
              getWidget('Humidity', weatherData['main']['humidity'].toString()),
          ],
        ),
      ),
    );
  }

  Widget getWidget(String title, String weatherData) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800]),
            ),
          ),
        ),
        Expanded(
          child: Text(
            weatherData,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800]),
          ),
        ),
      ],
    );
  }

  Future getWeatherDetails(String city) async {
    var url;
    if (city.isNotEmpty)
      url = Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=9008f007aec2e5db70ff7893b5f62042");
    final response = await http.get(url);
    weatherData = jsonDecode(response.body);

    setState(() {});
  }
}
