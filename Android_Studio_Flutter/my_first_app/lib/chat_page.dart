import 'dart:convert';
import 'dart:js_interop';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:my_first_app/login_page.dart';
import 'package:my_first_app/models/chat_message_entity.dart';
import 'package:my_first_app/models/image_model.dart';
import 'package:my_first_app/repo/image_repository.dart';
import 'package:my_first_app/services/auth_service.dart';
import 'package:my_first_app/widgets/chat_bubble.dart';
import 'package:my_first_app/widgets/chat_input.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {


  // final String username;

  // const ChatPage({Key? key,required this.username}) :super(key: key);
  ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatMessageEntity> _message = [];
  late Future<List<PixelformImage>> _imagesFuture;

  _loadInitialMessages() async {
    // final String response = await rootBundle.loadString('assets/mock_messages.json');
    rootBundle.loadString('assets/mock_messages.json').then((response) {
      final List<dynamic> decodedList = jsonDecode(response) as List;

      final List<ChatMessageEntity> _chatMessages = decodedList.map((listItem) {
        return ChatMessageEntity.fromJson(listItem);
      }).toList();

      print(_chatMessages.length);

      setState(() {
        _message = _chatMessages;
      });
    });
  }

  onMessageSent(ChatMessageEntity entity) {
    _message.add(entity);
    setState(() {});
  }





  @override
  void initState() {
    _loadInitialMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final username = context.watch<AuthService>().getUserName();
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        elevation: 10,
        title: Text('Hi  $username'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthService>().updateUserName('Hitman Agent 47 !');

              },
              icon: Icon(Icons.warning)),
          IconButton(
              onPressed: () {
                context.read<AuthService>().logoutUser();
                print('icon Pressed');
                Navigator.popAndPushNamed(context, '/');
              },
              icon: Icon(Icons.logout)),
          IconButton(
              onPressed: () {
                print(_message.length);
              },
              icon: Icon(Icons.login))
        ],
      ),
      body: Column(
        children: [


          Expanded(
            child: ListView.builder(
              itemCount: _message.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  alignment: _message[index].author.userName == context.read<AuthService>().getUserName()
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  entity: _message[index],
                );
              },
            ),
          ),
          ChatInput(
            onSubmit: onMessageSent,
          ), ],
      ),
    );
  }
}
