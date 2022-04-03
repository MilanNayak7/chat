import 'package:flutter/material.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';


class ChatScreen extends StatefulWidget {
  final User user;

  ChatScreen({required this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  _chatBubble(Message message, bool isMe, bool isSameUser) {
    if (isMe) {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          !isSameUser
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      message.time,
                      style: TextStyle(
                        fontSize: 12,
                    color: Colors.black45,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage(message.sender.imageUrl),
                      ),
                    ),
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          !isSameUser
              ? Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage(message.sender.imageUrl),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      message.time,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    }
  }
  _sendMessageArea() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10,10,10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color:Colors.grey),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8),
        height: 50,

        child: Row(
          children: <Widget>[
            IconButton(
              icon: Image.asset("assets/icons/camera.png"),
              iconSize: 25,
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
            const Expanded(
              child: TextField(
                decoration: InputDecoration.collapsed(
                  hintText: 'Send a message..',
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            IconButton(
              icon:  Image.asset("assets/icons/mic.png"),
              iconSize: 25,
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
            IconButton(
              icon:  Image.asset("assets/icons/img.png"),
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
            IconButton(
              icon:  Image.asset("assets/icons/sticker.png"),
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int prevUserId = 0;
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.cyan,
        centerTitle: false,
         title: Row(
           children: [
             const CircleAvatar(
               radius: 15,
              // backgroundImage: AssetImage(message.sender.imageUrl),
             ),
             SizedBox(width:10,),
             Column(
               children: [
                 RichText(
                   textAlign: TextAlign.start,
                   text: TextSpan(
                     children: [
                       TextSpan(
                           text: widget.user.name,
                           style: const TextStyle(
                             fontSize: 16,
                             fontWeight: FontWeight.w800,color: Colors.black
                           )),
                       const TextSpan(text: '\n'),
                       widget.user.isOnline ?
                       const TextSpan(
                         text: 'Online',
                         style: TextStyle(
                           fontSize: 11,
                           fontWeight: FontWeight.w400,color: Colors.black
                         ),
                       )
                           :
                       const TextSpan(
                         text: 'Offline',
                         style: TextStyle(
                           fontSize: 11,
                           fontWeight: FontWeight.w400,
                         ),
                       )
                     ],
                   ),
                 ),
               ],
             ),
           ],
         ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          IconButton(onPressed: (){}, icon:Image.asset("assets/icons/telephone.png",height:30,)),
          IconButton(onPressed: (){}, icon:Image.asset("assets/icons/video_camera.png",height:30,)),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(20),
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final Message message = messages[index];
                final bool isMe = message.sender.id == currentUser.id;
                final bool isSameUser = prevUserId  == message.sender.id;
                prevUserId = message.sender.id;
                return _chatBubble(message, isMe, isSameUser);
              },
            ),
          ),
          _sendMessageArea(),
        ],
      ),
    );
  }
}
