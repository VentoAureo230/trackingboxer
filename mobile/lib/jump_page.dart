// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';


class JumpPage extends StatefulWidget {
  const JumpPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<JumpPage> createState() => _JumpPageState();
}

class _JumpPageState extends State<JumpPage> {
  UserAccelerometerEvent? _userAccelerometerEvent;
  int? _jump = 0;
  int? _time = 0;
  late Timer _timer;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  Duration sensorInterval = SensorInterval.normalInterval;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saut à la corde')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Temps : ${_time.toString()}'),
            Text('Nombre de saut : ${_jump?.toString()}'),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {StopTime();},
              child: Text('Fin de session'),
            )
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }
  @override
  void initState() {
    Time();
    super.initState();
    _streamSubscriptions.add(
      userAccelerometerEventStream(samplingPeriod: sensorInterval).listen(
            (UserAccelerometerEvent event) {
          setState(() {
            _userAccelerometerEvent = event;
            if (_userAccelerometerEvent!.y.abs() > 10){
              _jump = _jump !+ 1;
              _jump = (_jump !/ 2) as int?;
            }
          });
        },
        onError: (e) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text("Sensor Not Found"),
                content: Text(
                    "It seems that your device doesn't support Accelerometer Sensor"),
              );
            });
        },
        cancelOnError: true,
      ),
    );
  }
  Time(){
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _time = timer.tick;
    });
  }
  
  StopTime(){
    _timer.cancel();
  }
}