// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class helloRectangle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.deepOrange,
        height: 400.0,
        width: 300.0,
        child: Center(
          child: Text(
            "hello world",
            style: TextStyle(fontSize: 40.0),
          ),
        ),

      ),
    );

  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text("Hello Rectangle"),
      ),
      body: helloRectangle(),
    ),
  ));
}
