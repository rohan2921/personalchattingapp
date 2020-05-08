import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() async{
    FocusScope.of(context).unfocus();
    final user= await FirebaseAuth.instance.currentUser();
    final name=await Firestore.instance.collection('user').document(user.uid).get();
    Firestore.instance.collection('chat')
        .add({
          'text': _enteredMessage,
         'createdAt': Timestamp.now(),
         'username':name.data['username'],
        'userId':user.uid,
        'imageUrl':name.data['imageUrl']
         });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: TextField(
                autocorrect: true,
                textCapitalization: TextCapitalization.sentences,
                enableSuggestions: true,
                controller: _controller,
                decoration: InputDecoration(labelText: 'Type a mesage'),
                onChanged: (val) {
                  setState(() {
                    _enteredMessage = val;
                  });
                },
              ),
            )),
            IconButton(
                icon: Icon(Icons.send),
                color: Theme.of(context).primaryColor,
                onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage)
          ],
        ));
  }
}
