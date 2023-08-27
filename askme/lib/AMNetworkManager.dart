import 'dart:convert';
import 'package:http/http.dart' as http;
import 'AMConstants.dart';

class AMNetworkManager{
  Future getCompletion({required String text}) async {
    var client = http.Client();
    try {
      final theUri = Uri.https('api.openai.com', 'v1/chat/completions');
      print('The Request URL: ${theUri}');
      var headers = {
        'Authorization': 'Bearer $kChatGPTKey',
        'Content-Type': 'application/json'
      };
      List<dynamic> queryData = [{'role': 'user', 'content':'${text}'}];
      var theBody = json.encode({'model':'gpt-3.5-turbo', 'temperature' : '0.7', 'messages' : queryData});
      print('Request body $theBody');
      var response = await http.post(theUri,headers: headers, body:theBody);
      print('Response status: ${response.statusCode}');
      return jsonDecode(response.body);
    } catch (e) {
      print('some error $e');
      return null;
    } finally {
      client.close();
    }
  }
}