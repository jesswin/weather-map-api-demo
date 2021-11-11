import 'package:flutter/material.dart';

class WeatherSlice extends StatefulWidget {
  var fetchedData;
  WeatherSlice(this.fetchedData);
  @override
  _WeatherSliceState createState() => _WeatherSliceState();
}

class _WeatherSliceState extends State<WeatherSlice> {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: widget.fetchedData != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.fetchedData["weather"][0]["main"] +
                        ", " +
                        widget?.fetchedData["weather"][0]["description"],
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Min temp:" + widget.fetchedData["temp"]["min"].toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Max temp:" + widget.fetchedData["temp"]["max"].toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Wind Speed:" + widget.fetchedData["wind_speed"].toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              )
            : Container(),
      ),
    );
  }
}
