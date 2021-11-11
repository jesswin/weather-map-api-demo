import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DaySelector extends StatefulWidget {
  var data;
  var getSelectedData;
  DaySelector(this.data, this.getSelectedData);
  @override
  _DaySelectorState createState() => _DaySelectorState();
}

class _DaySelectorState extends State<DaySelector> {
  var selected;
  convertDate(dateInMicroseconds) {
    var date = DateTime.fromMillisecondsSinceEpoch(dateInMicroseconds * 1000);
    var converted = DateFormat.yMMMMEEEEd().format(date);
    return converted;
  }

  convertTime(time) {
    var date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    var converted = DateFormat.Hms().format(date);
    return converted;
  }

  getDays() {
    return Expanded(
      child: ListView.builder(
          itemCount: widget.data["daily"].length - 1,
          itemBuilder: (context, index) => Container(
                child: GestureDetector(
                  onTap: () => {
                    setState(() {
                      selected = widget.data["daily"][index]["dt"];
                    }),
                    widget.getSelectedData(index)
                  },
                  child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                convertDate(widget.data["daily"][index]["dt"]),
                                style: TextStyle(
                                    fontSize: selected ==
                                            widget.data["daily"][index]["dt"]
                                        ? 20
                                        : 15),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Sunset: " +
                                convertTime(
                                    widget.data["daily"][index]["sunrise"]),
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Sunrise: " +
                                convertTime(
                                    widget.data["daily"][index]["sunset"]),
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.data["daily"][index]["weather"][0]["main"] +
                                ", " +
                                widget.data["daily"][index]["weather"][0]
                                    ["description"],
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      )),
                ),
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: getDays(),
    );
  }
}
