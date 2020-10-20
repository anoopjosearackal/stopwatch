import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stop_watch/stateManagement/centiSecondsCubit.dart';
import 'package:stop_watch/stateManagement/secondsCubit.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool timerOn = false;
  Timer t;
  var centiSeconds = CentiSecondsCubit();
  var seconds = SecondsCubit();
  bool blink = false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    t.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              fit: StackFit.passthrough,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 300,
                    width: 300,


                    child: CircularProgressIndicator(
                      value: seconds.state/60,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      backgroundColor: Colors.transparent,

                      strokeWidth: 30,


                    ),
                  ),
                ),


                Center(child: Container(
                    height: 300,
                    child: timeDisplay())),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: buttonDisplay(),
            ),
          ],
        ),
      ),
    );
  }

  //--Components------------------//

  Widget timeDisplay() {
    return Container(
      width: 275,
      child: Row(
        children: [
          Expanded(child: Center(child: secondsDisplay())),
          Text(" : ", style: TextStyle(fontSize: 80, color: Colors.grey)),
          Expanded(child: Center(child: centiSecondsDisplay())),
        ],
      ),
    );
  }

  Widget secondsDisplay() {
    return Text(
      (seconds.state < 10)
          ? "0" + (seconds.state).toString()
          : (seconds.state).toString(),
      style: TextStyle(fontSize: 80, color: Colors.grey),
    );
  }

  Widget centiSecondsDisplay() {
    return Text(
      (centiSeconds.state < 10)
          ? "0" + (centiSeconds.state).toString()
          : (centiSeconds.state).toString(),
      style: TextStyle(fontSize: 80, color: Colors.grey),
    );
  }

  Widget buttonDisplay() {
    return Container(
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (seconds.state != 60)? GestureDetector(
              onTap: () {
                if (timerOn) {
                  stopTimer();
                } else
                  startTimer();
              },
              child: startStopButton()): Container(),
          GestureDetector(onTap: reset, child: resetButton())
        ],
      ),
    );
  }

  Widget startStopButton() {
    return Container(
      height: 50,
      width: 150,
      color: (timerOn) ? Colors.red : Colors.green,
      child: Center(
        child: Text(
          (timerOn) ? "STOP" : (seconds.state == 0 && centiSeconds.state == 0)? "START" : "RESUME",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
    );
  }

  Widget resetButton() {
    return Container(
      height: 50,
      width: 150,
      color: Colors.orange,
      child: Center(
        child: Text(
          "RESET",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
    );
  }

  //--Functions----------------//

  startTimer() {

      setState(() {
        timerOn = true;
      });
      t = Timer.periodic(Duration(milliseconds: 10), (timer) {
        if (seconds.state < 60 && centiSeconds.state <= 99) {
          setState(() {
            blink = true;
          });

          if (centiSeconds.state < 99) {
            centiSeconds.increment();
          } else {
            seconds.increment();
            centiSeconds.reset();
          }
        }


      });


  }

  stopTimer() {
    setState(() {
      timerOn = false;
    });
    if (t != null) t.cancel();
  }

  reset() {
    setState(() {
      timerOn = false;
    });
    if (t != null) t.cancel();
    seconds.reset();
    centiSeconds.reset();
  }
}
