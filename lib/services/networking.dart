import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const openWeatherMapsApiKey = '540b7cfee5bdc9fdeb509bf037b0cc18';

class NetworkHelper {
  NetworkHelper({
    this.latitude,
    this.longitude,
    this.cityName,
  });

  final double latitude;
  final double longitude;
  final String cityName;

  Future getData() async {
    // var uriExample = Uri.parse(
    //   'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey',
    // );
    Uri url;
    if (cityName == null) {
      url = Uri.https(
        'api.openweathermap.org',
        'data/2.5/weather',
        {
          'lat': '$latitude',
          'lon': '$longitude',
          'appid': '$openWeatherMapsApiKey',
          'units': 'imperial',
        },
      );
    } else {
      url = Uri.https(
        'api.openweathermap.org',
        'data/2.5/weather',
        {
          'q': '$cityName',
          'appid': '$openWeatherMapsApiKey',
          'units': 'imperial',
        },
      );
    }

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;

      return convert.jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
