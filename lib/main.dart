import 'package:flutter/material.dart';
import 'package:web_api_call/Widgets/daySelector.dart';
import 'package:web_api_call/Widgets/weatherSlice.dart';
import 'package:web_api_call/weather_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var data;
  var isLoading = false;
  var selectedData = 0;
  var fetchedData;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    setState(() {
      isLoading = true;
    });
    data = await WeatherServices.getWeather();
    setState(() {
      isLoading = false;
    });
  }

  getSelectedData(dt) {
    setState(() {
      selectedData = dt;
      fetchedData = data["daily"][selectedData];
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Container(
                child: Column(
                  children: [
                    WeatherSlice(fetchedData),
                    DaySelector(data, getSelectedData)
                  ],
                ),
              ),
            ),
    );
  }
}
