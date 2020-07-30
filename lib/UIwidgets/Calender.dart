import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Calender extends StatefulWidget {
  DateTime date;

  Calender({Key key, @required this.date}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CalenderState();
  }
}

class CalenderState extends State<Calender> {
  Map<int, int> daysInMonth = {
    1: 31,
    2: 28,
    3: 31,
    4: 30,
    5: 31,
    6: 30,
    7: 31,
    8: 31,
    9: 30,
    10: 31,
    11: 30,
    12: 31,
  };
  Map<int, String> monthByNumber = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December"
  };
  Map<int, String> weekday = {
    1: "Mon",
    2: "Tue",
    3: "Wed",
    4: "Thu",
    5: "Fri",
    6: "Sat",
    7: "Sun",
  };
  DateTime timeOfNow;
  List<List<int>> daysInWeek = [[], [], [], [], [], [], []];

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      timeOfNow = widget.date;
      print((timeOfNow.day.toString()) +
          ' ' +
          (timeOfNow.month.toString()) +
          ' ' +
          (timeOfNow.year.toString()));

      print((timeOfNow.weekday + 35 - timeOfNow.day) % 7);
      int beginweekday = (timeOfNow.weekday + 35 - timeOfNow.day) % 7;
      int last = 0;
      for (int i = 0; i < (timeOfNow.weekday + 35 - timeOfNow.day) % 7; i++) {
        daysInWeek[i % 7].add(0);
      }
      for (int i = 1; i <= daysInMonth[timeOfNow.month]; i++) {
        daysInWeek[(beginweekday + i - 1) % 7].add(i);
        last = (beginweekday + i - 1) % 7;
      }
      for (int i = last + 1; i < 7; i++) {
        daysInWeek[i % 7].add(0);
      }
    });

    super.initState();
  }

  Widget CalenderDays() {
    return Container(
      width: double.infinity,
      height: 600,
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(monthByNumber[timeOfNow.month],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black12
                  ),
                ),
                Text(timeOfNow.year.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black12
                  ),
                )
              ],
            ),

        Container(
          height: 420,
          child: ListView.builder(
            itemCount: 7,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int weekdayindex) {
              final size = MediaQuery.of(context).size;
              print(size.height.toString() + ' ' + size.width.toString());

              return Container(
                  decoration: BoxDecoration(
                    color: timeOfNow.weekday - 1 == weekdayindex
                        ? Colors.grey
                        : Colors.white,
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.width / 14)),
                  ),
                  width: size.width / 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(top: 20),
                          height: 50,
                          child: Text(
                            weekday[weekdayindex + 1],
                            style: TextStyle(fontSize: 14, color: Colors.black38),
                          )),
                      Container(
                          height: daysInWeek[weekdayindex].length * 60.0,
                          child: ListView.builder(
                              itemCount: daysInWeek[weekdayindex].length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                        timeOfNow = DateTime(
                                            timeOfNow.year,
                                            timeOfNow.month,
                                            daysInWeek[weekdayindex][index]);
                                    });
                                  },
                                  child: Container(
                                      height: 60,
                                      alignment: Alignment.center,
                                      decoration:
                                          timeOfNow.day != daysInWeek[weekdayindex][index]
                                              ? null
                                              : BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(30)),
                                                  color: Colors.deepPurple),
                                      child: Text(
                                          daysInWeek[weekdayindex][index] == 0
                                              ? ''
                                              : daysInWeek[weekdayindex][index]
                                                  .toString(),
                                          style: timeOfNow.day !=
                                                  daysInWeek[weekdayindex][index]
                                              ? TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black)
                                              : TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white))),
                                );
                              }))
                    ],
                  ));
            },
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(color: Colors.white), child: CalenderDays());
  }
}
