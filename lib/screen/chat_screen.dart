import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/api_chatbot.dart';

class ChatScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatUser user1 = ChatUser(id: "1", firstName: "me");
  ChatUser user2 = ChatUser(id: "2", firstName: "bot");
 
  List<ChatUser> _typingUsers = [];
  List<ChatMessage> massageList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DashChat(
        typingUsers: _typingUsers,
        
        messageOptions: MessageOptions(
          avatarBuilder: (p0, onPressAvatar, onLongPressAvatar) {
            return Image.network(
              "https://media.discordapp.net/attachments/1544648774100459611/1546216449863843991/1280px-Google_Gemini_icon_2025.svg.png?ex=6a9ef9c8&is=6a9da848&hm=01b45075aedd015085ef761058894a82b4384fbbd4a8e705e198fbc997c9a8b0&=&format=webp&quality=lossless&width=700&height=700",
              height: 30,
              width: 30,
            );
          },
        ),
        
        currentUser: user1,
        onSend: (messages) async {
          _typingUsers.add(user2);
          setState(() {});
          massageList.insert(0, messages);
          setState(() {});

          String botMessge = await ApiChatbot().sendReq(messages.text);

          ChatMessage reply = ChatMessage(
            user: user2,
            createdAt: DateTime.now(),
            text: botMessge,
          );

         

          massageList.insert(0, reply);
          _typingUsers.remove(user2);
          setState(() {});
        },
        messages: massageList,
      ),
    );
  }
}
