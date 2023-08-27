import 'package:flutter/material.dart';
import 'package:askme/AMChatScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SafeArea(
      child: AMChatScreen(),
    ),
  ));
}

