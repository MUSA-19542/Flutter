import 'package:flutter/material.dart';
import 'package:my_first_app/models/chat_message_entity.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';


class ChatBubble extends StatelessWidget
{

  final ChatMessageEntity entity;
  final Alignment alignment;

  ChatBubble({Key? key,required this.alignment, required this.entity}):super(key: key);
  @override
  Widget build(BuildContext context) {

    bool isAuthor=entity.author.userName ==context.read<AuthService>().getUserName();
    // TODO: implement build
    return Align(
      alignment:alignment ,
      child:Container(
        constraints:
        BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.6),
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${entity.text}',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            if(entity.imageUrl !=null)
              Container(
                height: 200,
                width:MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(entity.imageUrl!)),
                    borderRadius: BorderRadius.circular(12)),
                child: Image.network(
                  '${entity.imageUrl}',
                  // 'assets/img.png',

                ),
              )
          ],
        ),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: isAuthor? Colors.green : Color(0xFF8D0900),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12))),
      ),
    );
  }

}
