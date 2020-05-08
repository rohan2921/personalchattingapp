import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personalchattingapp/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, futureSnapahot) {
          if (futureSnapahot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return StreamBuilder(
              stream: Firestore.instance
                  .collection('chat')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (ctx, snapshots) {
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  final use = snapshots.data.documents;

                  return ListView.builder(
                    reverse: true,
                    itemBuilder: (ctx, ind) {
                      return MessageBubble(
                          use[ind]['text'] != null ? use[ind]['text'] : ' No',
                          use[ind]['username'],
                          use[ind]['imageUrl'],
                          use[ind]['userId'] == futureSnapahot.data.uid,
                          ValueKey(use[ind].documentID) 
                          );
                    },
                    itemCount: use.length,
                  );
                }
              });
        });
  }
}
