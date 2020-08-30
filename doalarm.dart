//quiver: ^2.1.3を追加せよ

import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

class CountDown extends StatefulWidget{
  CountDown({Key key}): super(key:key);

  @override
  _CountDown createState() => _CountDown();
}

class _CountDown extends State<CountDown>{
  int _start = 10;
  int _current = 10;

  void startTimer(){
    CountdownTimer countdownTimer = new CountdownTimer(
      new Duration(seconds: _start), //初期値
      new Duration(seconds: 1),      //減らす幅
    );

    var sub = countdownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _current = _start - duration.elapsed.inSeconds; //毎秒減らしていく
      });
    });

    //終了時の処理
    sub.onDone(() {
      print("finish!!");
      sub.cancel();
      _current = 10;
    });
  }

  @override

  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //現在のカウントを表示
            Text(
              "$_current秒",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            RaisedButton(
              onPressed: (){
                startTimer();
              },
              child: Text("start"),
            ),

          ],
        ),
      ),
    );
  }

}