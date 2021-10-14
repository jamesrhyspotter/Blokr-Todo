import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'dart:math' as math;
import 'package:infinite_listview/infinite_listview.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tym Blockr',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}


class HomePage extends StatelessWidget {

  final InfiniteScrollController _infiniteController = InfiniteScrollController(
    initialScrollOffset: 0.0,
  );

  @override
  Widget build(BuildContext context) {

    int wakeUpTime = 0;

    List<Map> toDos = List.generate(48, (index) => {"id": index, "name": "Todo $index"});

    Iterable<TimeOfDay> getTimes(TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
      var hour = startTime.hour;
      var minute = startTime.minute;

      do {
        yield TimeOfDay(hour: hour, minute: minute);
        minute += step.inMinutes;
        while (minute >= 60) {
          minute -= 60;
          hour++;
        }
      } while (hour < endTime.hour ||
          (hour == endTime.hour && minute <= endTime.minute));
    }

    final startTime = TimeOfDay(hour: 9, minute: 0);
    final endTime = TimeOfDay(hour: 23, minute: 30);
    final step = Duration(minutes: 30);

    final times = getTimes(startTime, endTime, step)
        .map((tod) => tod.format(context))
        .toList();


    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    String getTime(double timeInt){
      String output = '';

      print(timeInt.toString());
      print(timeInt.round());

      double outputNumb = 0;

      outputNumb  = (timeInt * 60) % 60;

      output = timeInt.round().toString() + ':' +  outputNumb.toInt().toString();

      return output;
    }

    Widget activeTodoTile(int index){
      Color color = Colors.teal;
      return Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(toDos[index]["name"], style: GoogleFonts.montserrat(color: Color(0xFF26142a), fontSize: 24, fontWeight: FontWeight.w500)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(times[index], style: GoogleFonts.montserrat(color: Color(0xFF26142a), fontSize: 18, fontWeight: FontWeight.w200)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: false,
                    onChanged: (bool? value) {

                    },
                  )
                ],
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight,
              colors: [
                color,
                Colors.tealAccent,
              ],
            ),
            borderRadius: BorderRadius.circular(15)),
      );
    }

    Widget inActiveTodoTile(int index){
      Color color =  Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.3);
      return Container(
        child: Center(child: Text(times[index].toString(), style: GoogleFonts.montserrat(color: Color(0xFF26142a), fontSize: 24, fontWeight: FontWeight.w500))),

        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.white.withOpacity(0.2),
                color.withOpacity(0.1)
              ],
            ),
            borderRadius: BorderRadius.circular(15)),
      );
    }

    Widget inActiveDay(String day, int date){
      return Container(
        height: height*0.07,
        width: width / 11,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(day, style: GoogleFonts.montserrat(fontSize: 18, color: Colors.white.withOpacity(0.1)), ),
            Text((date).toString(), style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, fontSize: 18,  color: Colors.white)),
          ],
        ),
      );
    }

    Widget activeDay(String day, int date){
      return Container(
        height: height*0.07,
        width: width / 11,
        decoration:BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.tealAccent,
              Colors.teal,
            ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(day, style: GoogleFonts.montserrat(fontSize: 18, color: Color(0xFF26142a)), ),
            Text((date).toString(), style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, fontSize: 18,  color: Color(0xFF26142a))),
          ],
        ),
      );
    }





    return Scaffold(
      body: Container(
        color: Color(0xFF26142a),
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.start,
          alignment: Alignment.topLeft,
          children: <Widget>[
            Container(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: 30,
                  itemBuilder: (BuildContext ctx, index) {
                    // if(index % 3 == 0 || index % 5 == 0){
                    //   return inActiveTodoTile(times[index]);
                    // }
                    return inActiveTodoTile(index);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 128.0, left: 32, right: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Your Bloks', style: GoogleFonts.montserrat(fontSize: 42)),
                  Icon(Icons.settings_outlined, size: 28,),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF26142a),
                      borderRadius: BorderRadius.circular(50)),
                  height: height * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Today', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 24), ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.arrow_back_ios, color: Colors.white),
                                  SizedBox(width: 30,),
                                  Icon(Icons.arrow_forward_ios, color: Colors.white),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: height * 0.1,
                        // child: ListView.builder(
                        //   scrollDirection: Axis.horizontal,
                        //   itemCount: 7,
                        //   itemBuilder: (BuildContext context, int index){
                        //
                        //     List<String> days = [
                        //       'Su',
                        //       'Mo',
                        //       'Tu',
                        //       'We',
                        //       'Th',
                        //       'Fr',
                        //       'Sa',
                        //     ];
                        //
                        //     return  Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child:
                        //     );
                        //   },
                        // ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            inActiveDay('Su', 14),
                            inActiveDay('Mo', 15),
                            inActiveDay('Tu', 16),
                            activeDay('We', 17),
                            inActiveDay('Th', 18),
                            inActiveDay('Fr', 19),
                            inActiveDay('Sa', 20),

                          ],
                        ),
                      ),
                      Divider(thickness: 1,),
                    ],
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(

                onPressed: () { 
                  showCupertinoModalBottomSheet(context: context, builder: (BuildContext context){
                    return Container(
                      height: height,
                        decoration: BoxDecoration(
                        color: Color(0xFF26142a),
                            // borderRadius: BorderRadius.circular(50),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Divider(
                                thickness: 1.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
                },
                child: Icon(Icons.add, color: Color(0xFF26142a)),

              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

