import 'package:askme/AMChatListView.dart';
import 'package:askme/AMMessageBubble.dart';
import 'AMConstants.dart';
import 'package:askme/AMNetworkManager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AMChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<AMChatScreen> {
  final messageTextController = TextEditingController();
  String messageText = '';
  bool showLoading = false;
  List<AMMessageBubble> messageBubbles = [];

  @override
  void initState() {
    super.initState();
  }

  void setUpMessages() async {
    final messageBubble = AMMessageBubble(
      sender: 'Me',
      text: messageText,
      isMe: true,
    );
    setState(() {
      showLoading = true;
      messageBubbles.add(messageBubble);
    });
    messageTextController.clear();
    FocusManager.instance.primaryFocus?.unfocus();

    AMNetworkManager theAMNetworkMgr = AMNetworkManager();
    var res = await theAMNetworkMgr.getCompletion(text: messageText);
    String theResult = '';
    print('The response data: ${res}');
    if (res['choices'] != null) {
      var thePromtData = res['choices'];
      thePromtData = thePromtData[0];
      theResult = thePromtData['message']['content'];
    } else if (res['error'] != null) {
      theResult = res['error']['message'];
    }
    print('Msg from ChatGPT: ${theResult}');
    final responseBubble = AMMessageBubble(
      sender: 'Bot',
      text: theResult,
      isMe: false,
    );
    setState(() {
      showLoading = false;
      messageBubbles.add(responseBubble);
    });
    messageText = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text('AskMe'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AMMessageListView(
              messageBubbles: messageBubbles,
              showSpinner: showLoading,
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (messageText.length == 0) {
                        Fluttertoast.showToast(msg: 'Kindly enter the promt');
                        return;
                      } else {
                        setUpMessages();
                      }
                    },
                    child: Text(
                      'AskMe',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
