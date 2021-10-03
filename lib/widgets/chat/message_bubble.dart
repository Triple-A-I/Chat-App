import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Key key;
  final String message;
  final String username;
  final bool isMe;
  final bool prevoisIsSimilarToNext;
  final String userIamge;
  const MessageBubble(this.message, this.username, this.isMe,
      this.prevoisIsSimilarToNext, this.userIamge,
      {this.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              !isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: !isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                  bottomLeft: isMe ? Radius.circular(14) : Radius.circular(0),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(14),
                ),
              ),
              width: MediaQuery.of(context).size.width * .59,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Column(
                crossAxisAlignment:
                    !isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  if (!isMe)
                    if (!prevoisIsSimilarToNext)
                      Text(
                        username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: !isMe
                              ? Colors.black
                              : Theme.of(context)
                                  .accentTextTheme
                                  .headline6
                                  .color,
                        ),
                      ),
                  Text(
                    message,
                    style: TextStyle(
                      color: !isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline6.color,
                    ),
                    textAlign: !isMe ? TextAlign.start : TextAlign.end,
                  ),
                ],
              ),
            )
          ],
        ),
        if (!isMe)
          if (!prevoisIsSimilarToNext)
            Positioned(
              top: -10,
              left: isMe ? 120 : null,
              right: !isMe ? 120 : null,
              child: CircleAvatar(
                // child: Image.network(),

                backgroundImage: NetworkImage(userIamge),
              ),
            ),
        // if (!isMe)
        //   if (prevoisIsSimilarToNext) Container()
      ],
      clipBehavior: Clip.none,
    );
  }
}
