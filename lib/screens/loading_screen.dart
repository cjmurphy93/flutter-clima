import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
  }

  void getData() async {
    var uriExample = Uri.parse(
        'https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=439d4b804bc8187953eb36d2a8c26a02');

    http.Response response = await http.get(uriExample);

    if (response.statusCode == 200) {
      String data = response.body;

      var decodedData = convert.jsonDecode(data);

      double temperature = decodedData['main']['temp'];
      int condition = decodedData['weather'][0]['id'];
      String cityName = decodedData['name'];
    } else {
      print(response.statusCode);
    }

    //  another method without parsing:
    // Uri url = Uri.https(
    //   'samples.openweathermap.org',
    //   'data/2.5/weather',
    //   {
    //     'lat': '35',
    //     'lon': '139',
    //     'appid': '439d4b804bc8187953eb36d2a8c26a02',
    //   },
    // );
    // http.Response response = await http.get(url);
    // print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }
}
