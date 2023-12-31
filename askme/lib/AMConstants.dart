import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.orangeAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Enter you prompt',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.orangeAccent, width: 2.0),
  ),
);

const String kChatGPTKey = '<Your API Key>';

