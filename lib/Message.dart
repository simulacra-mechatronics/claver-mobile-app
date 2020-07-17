import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

part 'Message.g.dart';

@JsonSerializable()
class Message {
    final String subject;
    final String body;

    Message(this.subject, this.body);

    factory Message.fromJson(Map<String, dynamic> json)
  //      :subject = json['subject'],
  //       body = json['body'];
        => _$MessageFromJson(json);

    static Future<List<Message>> browse() async {
//        String content = await rootBundle.loadString('data/message.json');
        http.Response response = await http.get('https://run.mocky.io/v3/cdc6bd40-3c6b-4190-a2f6-be6c4ae9aa26');

        await Future.delayed(Duration(seconds: 3));

        String content = response.body;
        List collection = json.decode(content);
        List<Message> _messages = collection.map((json) => Message.fromJson(json)).toList();

        return _messages;
    }
}