
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String username;
  final String url;
  final bool isMe;
  final Key key;
  MessageBubble(this.message, this.username,this.url,this.isMe,this.key);
  @override
  Widget build(BuildContext context) {
    return  Row(
        mainAxisAlignment: isMe? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          if(!isMe) CircleAvatar(backgroundImage: NetworkImage(url)),
          Container(
            decoration: BoxDecoration(
                
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topLeft: isMe? Radius.circular(20):Radius.circular(0),
                  topRight: isMe? Radius.circular(0):Radius.circular(20)
                  ,),
                color: isMe?Theme.of(context).accentColor:Colors.black12),
            width: 140,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Column(
              crossAxisAlignment: isMe? CrossAxisAlignment.end:CrossAxisAlignment.start,
              children: <Widget>[
                
                       Text(username,style:
                      TextStyle(color: isMe? Theme.of(context).accentTextTheme.title.color:Colors.black45),),
                
                SizedBox(height:2),
                Text(
                  message,
                  style:
                      TextStyle(color: isMe? Theme.of(context).accentTextTheme.title.color:Colors.black45),
                ),
              ],
            ),
          ),
          if(isMe) CircleAvatar(backgroundImage: NetworkImage(url),),
        ],
      
      
    );
  }
}
