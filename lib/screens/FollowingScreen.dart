import 'package:flutter/material.dart';
import 'package:zwap_fyp1/Models/postsModel.dart';

import '../chats/models/chat_user.dart';

class FollowingScreenCard extends StatefulWidget {
  final PostModel postModel;
   FollowingScreenCard({Key? key,  required this.postModel,}) : super(key: key);

  @override
  State<FollowingScreenCard> createState() => _FollowingScreenCardState();
}

class _FollowingScreenCardState extends State<FollowingScreenCard> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final cardHeight = mq.size.height * 0.50;

    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(bottom: mq.size.height * 0.03),
        child: Container(
          height: cardHeight,
          color: Colors.black,
          child: Card(
            color: Colors.white,
            child: SizedBox(
              height: cardHeight * 0.2,
              width: mq.size.width * 0.3,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title:  Text(widget.postModel.userId,
                          style: const TextStyle(fontSize: 16)),
                      subtitle:  Text(widget.postModel.timestamp,
                          style: const TextStyle(fontSize: 16)),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_horiz),
                      ),
                    ),
                    
                    // Image.asset(
                    //   'Images/LOGO1.png',
                    //   height: cardHeight * 0.3,
                    //   width: cardHeight * 0.3,
                    // ),
                      ListTile(
                      title: Text(
                        widget.postModel.condition,
                        style: const TextStyle(
                            color: Colors.black87,
                            backgroundColor: Colors.blueAccent,
                            fontSize: 15),
                      ),
                      trailing: Text(
                        widget.postModel.location,
                        style: const TextStyle(color: Colors.black38, fontSize: 16),
                      ),
                    ),
                     Text(widget.postModel.timestamp,
                        style: const TextStyle(fontSize: 16)),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      // leading: Image.asset(
                      //   widget.postModel.imageUrls as String,
                      //   height: mq.size.height * 0.02,
                      //   width: mq.size.height * 0.02,
                      // ),
                      title: Text(
                        widget.postModel.description,
                        style: const TextStyle(fontSize: 14, color: Colors.black26),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
