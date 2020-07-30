import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timekeeper/UIwidgets/Calender.dart';

class CalenderScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CalenderScreenState();
  }
}

class CalenderScreenState extends State<CalenderScreen> {
  DateTime timeOfNow;
  PageController pageController;
  double currentPageValue;
  int currentPage;
  Widget prevCalenderDays, currentCalenderDays, nextCalenderDays;
  DateTime nextMonth(DateTime time) {
    if (time.month == 12)
    {
      return DateTime.utc(time.year + 1, 1, 1);
    }
    else
    {
      return DateTime.utc(time.year, time.month + 1, 1);
    }

  }
  DateTime prevMonth(DateTime time) {
    if (time.month == 1)
    {
      return DateTime.utc(time.year - 1, 12, 1);
    }
    else
    {
      return DateTime.utc(time.year, time.month - 1, 1);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      pageController = PageController(
        keepPage: true,
        initialPage: 100,
      );
      pageController.addListener(() {
        setState(() {
          currentPageValue = pageController.page;
        });
      });
      timeOfNow = DateTime.now();
      prevCalenderDays = Calender(date: prevMonth(timeOfNow));
      currentCalenderDays = Calender(date: timeOfNow,);
      nextCalenderDays = Calender(date: nextMonth(timeOfNow));
    });
    currentPageValue = pageController.initialPage * 1.0;
    currentPage = pageController.initialPage;
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: SafeArea(
            child: PageView.builder(

      controller: pageController,
      onPageChanged: (int ind) {
        setState(() {
          if (currentPage < ind)
          {
            timeOfNow = nextMonth(timeOfNow);
          }
          else if(currentPage > ind)
          {
            timeOfNow = prevMonth(timeOfNow);
          }

          prevCalenderDays = Calender(date: prevMonth(timeOfNow));
          currentCalenderDays = Calender(date: timeOfNow,);
          nextCalenderDays = Calender(date: nextMonth(timeOfNow));
          currentPage = ind;
        });

      },
      itemBuilder: (context, position) {
        if (position == currentPageValue.floor()) {
          return Transform(
            transform: Matrix4.identity()..rotateX(currentPageValue - position),
            child: Container(
              child: position == currentPage ? currentCalenderDays : prevCalenderDays
            ),
          );
        } else {
          return Transform(
            transform: Matrix4.identity()..rotateX(currentPageValue - position),
            child: Container(
                child: (position + 1 == currentPage) ? currentCalenderDays : nextCalenderDays
            ),
          );
        }
      },
    )));
  }
}
