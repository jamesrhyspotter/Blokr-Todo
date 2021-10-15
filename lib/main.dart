import 'package:flutter/cupertino.dart';
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


    Widget activeTodoTile(int index, String title){
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
                  Text(title, style: GoogleFonts.montserrat(color: Color(0xFF26142a), fontSize: 24, fontWeight: FontWeight.w500)),
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
                  itemCount: 35,
                  itemBuilder: (BuildContext ctx, index) {
                    // if(index % 3 == 0 || index % 5 == 0){
                    //   return inActiveTodoTile(times[index]);
                    // }
                    if(index == 0 || index >= 32 || index == 1){
                      return Container(
                        height: height * .6,
                      );
                    }
                    else if(index == 10){
                      return activeTodoTile(index, 'Brush Teeth');
                    }
                    else{
                      return inActiveTodoTile(index-2);
                    }

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
                    return Scaffold(
                      body: Container(
                        height: height,
                          decoration: BoxDecoration(
                          color: Color(0xFF26142a),
                              // borderRadius: BorderRadius.circular(50),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Regular Todo', style: GoogleFonts.montserrat(fontSize: 32)),
                                  IconButton(
                                    icon: Icon(Icons.done_outline, color: Colors.amber),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Create a new todo', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w200)),
                                ],
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Habit Name',
                                ),
                              ),
                              Container(
                                height: height * 0.1,
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.red,
                                ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Select color indicator', style: GoogleFonts.montserrat(color: Color(0xFF26142a), fontSize: 16)),
                                      ),
                                    ],
                                  ),
                              ),
                              Text("Repeat", style: GoogleFonts.montserrat(color: Colors.white30, fontSize: 16, fontWeight: FontWeight.w200)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Daily", style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400)),
                                  Text("Weekly", style: GoogleFonts.montserrat(color: Colors.white30, fontSize: 16, fontWeight: FontWeight.w200)),
                                  Text("Monthly", style: GoogleFonts.montserrat(color: Colors.white30, fontSize: 16, fontWeight: FontWeight.w200)),
                                ],
                              ),
                              Text("During These Days", style: GoogleFonts.montserrat(color: Colors.white30, fontSize: 16, fontWeight: FontWeight.w200)),
                              Row(
                                children: [
                                  OutlinedButton(onPressed: (){}, child: Text('Su', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w200)),),
                                  OutlinedButton(onPressed: (){}, child: Text('Mo', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w200)),),
                                  OutlinedButton(onPressed: (){}, child: Text('Tu', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w200)),),
                                  OutlinedButton(onPressed: (){}, child: Text('We', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w200)),),
                                  OutlinedButton(onPressed: (){}, child: Text('Th', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w200)),),
                                  OutlinedButton(onPressed: (){}, child: Text('Fr', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w200)),),
                                  OutlinedButton(onPressed: (){}, child: Text('Sa', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w200)),),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Everyday", style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w200)),
                                  CupertinoSwitch(
                                    value: false,
                                    onChanged: (bool value) {  },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Remind at a specific time", style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w200)),
                                  CupertinoSwitch(
                                    value: false,
                                    onChanged: (bool value) {  },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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

