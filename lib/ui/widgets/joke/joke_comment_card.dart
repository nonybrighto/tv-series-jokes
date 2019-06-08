import 'package:flutter/material.dart';
import 'package:tv_series_jokes/models/comment.dart';
import 'package:tv_series_jokes/ui/widgets/user/user_profile_icon.dart';
import 'package:tv_series_jokes/ui/widgets/user/username_text.dart';
import 'package:tv_series_jokes/utils/date_formater.dart';

class JokeCommentCard extends StatelessWidget {
  final Comment comment;

  JokeCommentCard(this.comment);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserProfileIcon(
            user: comment.owner,
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    UsernameText(user: comment.owner, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(DateFormatter.dateToString(
                        comment.createdAt, DateFormatPattern.timeAgo), style: TextStyle(color: Colors.grey[500]),)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(comment.content, textAlign: TextAlign.justify,),
                ),
                Divider()
              ],
            ),
          )
        ],
      ),
    );
  }
}
