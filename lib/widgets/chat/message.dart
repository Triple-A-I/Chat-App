import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final docs = snapshot.data.docs;
        final user = FirebaseAuth.instance.currentUser;
        bool prevoisIsSimilarToNext;
        return ListView.builder(
            reverse: true,
            itemCount: docs.length,
            itemBuilder: (ctx, index) {
              if (index == 0) {
                prevoisIsSimilarToNext = false;
              }
              // else if (index == 1) {
              //   prevoisIsSimilarToNext = true;
              // }
              else {
                prevoisIsSimilarToNext =
                    docs[index]['username'] == docs[index - 1]['username'];
                // ValueKey(docs[index].id) == ValueKey(docs[index - 1].id);
              }
              return MessageBubble(
                docs[index]['text'],
                docs[index]['username'],
                docs[index]['userId'] == user.uid,
                prevoisIsSimilarToNext,
                docs[index]['userImage'],
                key: ValueKey(docs[index].id),
              );
            });
      },
    );
  }
}
