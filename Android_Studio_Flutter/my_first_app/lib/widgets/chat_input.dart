import 'package:flutter/material.dart';
import 'package:my_first_app/models/chat_message_entity.dart';
import 'package:my_first_app/widgets/picker_body.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class ChatInput extends StatefulWidget {
  final Function(ChatMessageEntity) onSubmit;

  ChatInput({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final chatMessageController = TextEditingController();

  String _selectedImageUrl = '';

  void onSendButtonPressed()  async{
    String? userNameFromCache=await context.read<AuthService>().getUserName();
    print('ChatMessage : ${chatMessageController.text}');

    final newChatMessage = ChatMessageEntity(
        text: chatMessageController.text,
        id: "244",
        CreatedAt: DateTime
            .now()
            .millisecondsSinceEpoch,
        author: Author(userName: userNameFromCache!));

    if (_selectedImageUrl.isNotEmpty) {
      newChatMessage.imageUrl = _selectedImageUrl;
    }


    widget.onSubmit(newChatMessage);
    chatMessageController.clear();
    _selectedImageUrl = '';
    setState(() {

    });
  }
  void onImagePicked(String newImageUrl) {
    setState(() {
      _selectedImageUrl = newImageUrl;
      print('New Image Url <============================================================================>');
      print(newImageUrl);
    });
    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    return Container(

        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            IconButton(
            onPressed: () {
    showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
    return NetworkImagePickerBody(
    onImageSelected: onImagePicked,
    );
    });
    },
        icon: Icon(Icons.add, color: Colors.white)),
    Expanded(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    TextField(
    keyboardType: TextInputType.multiline,
    maxLines: 5,
    minLines: 3,
    controller: chatMessageController,
    textCapitalization: TextCapitalization.sentences,
    textAlign: TextAlign.center,
    style: TextStyle(
    color: Color(0xFF8D0900),
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w500,
    fontSize: 18),
    decoration: InputDecoration(
    hintText: "Type Your Message",
    hintStyle: TextStyle(
    color: Colors.white, fontWeight: FontWeight.w300),
    border: InputBorder.none,
    ),
    ),

      if (_selectedImageUrl.isNotEmpty && _selectedImageUrl.startsWith('http'))
        Image.network(_selectedImageUrl, height: 50,)


    ],
    )),
    IconButton(
    onPressed: () {
    onSendButtonPressed();
    },
    icon: Icon(Icons.send, color: Colors.white))
    ],
    ),
    decoration: BoxDecoration(
    color: Colors.black,
    borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
    ),
    );
  }
}
