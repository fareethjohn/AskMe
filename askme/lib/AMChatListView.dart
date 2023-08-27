import 'package:askme/AMMessageBubble.dart';
import 'package:flutter/material.dart';


class AMMessageListView extends StatelessWidget {
  AMMessageListView({required this.messageBubbles, required this.showSpinner});
  List<AMMessageBubble> messageBubbles = [];
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(height: showSpinner?40:0,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.orangeAccent,
              ),
            ),
          ),
          Expanded(child: ListView(
            children: messageBubbles,
          ),)
        ],
      ),
    ));
  }
}
