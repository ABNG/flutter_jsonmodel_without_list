import 'package:flutter/material.dart';
import 'package:flutterjsonmodelwithoutlist/model/weather_model.dart';
import 'package:flutterjsonmodelwithoutlist/services/networking.dart';

const url =
    "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=439d4b804bc8187953eb36d2a8c26a02";
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String lat = "zero";
  void getDataFromServer() async {
    NetworkHelper helper = NetworkHelper(url);
	//if we have list<map<string,dynaic>> then we can return list<map<string,dynaic>> and use futurebuilder
    Map<String, dynamic> data = await helper
        .getData(); // i force the data to take map type not any other type because it is dynamic
    WeatherAPI weatherAPI = WeatherAPI.fromJson(data);
    setState(() {
      print(weatherAPI.name);
      lat = weatherAPI.sys.country;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromServer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Container(
        child: Center(
          child: Text(
            lat,
            textScaleFactor: 3.0,
          ),
        ),
      ),
    ));
  }
}
