import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_with_goggle/chat/Chat_service.dart';
import 'package:login_with_goggle/text_field.dart';

class ChatPage extends StatefulWidget {
  final String reciverUserEmail;
  final String reciverUserID;

  const ChatPage(
      {super.key, required this.reciverUserEmail, required this.reciverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.reciverUserID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.reciverUserEmail),
        ),
        body: Column(
          children: [
            Expanded(child: _buildMessageList()),
            _buildMessafeInput(),
          ],
        ));
  }
  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessages(widget.reciverUserID, _firebaseAuth.currentUser!.uid),
        builder: (context,snapshot)
    {
      if(snapshot.hasError)
        {
          return Text('Error: ${snapshot.error}');
        }
      if(snapshot.connectionState == ConnectionState.waiting)
        {
          return Text('Loading....');
        }
      return ListView(
        children: snapshot.data!.docs.map((document)
        => _buildMessageItem(document)).toList(),
      );
    }
    );
  }
  Widget _buildMessageItem(DocumentSnapshot document)
  {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (
        data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(data['senderEmail']),
            Text(data['message'])
          ],
        ),
      ),
    );


  }

  Widget _buildMessafeInput() {
    return Row(
      children: [
        Expanded(
            child: MyTxtfield(
          controller: _messageController,
          hintText: 'Enter message',
          obscureText: false,
        )),
        IconButton(
            onPressed: sendMessage,
            icon: Icon(Icons.arrow_upward))
      ],
    );
  }
}
