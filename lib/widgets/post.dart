import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialapp/Services/Network/post_api_handler.dart';
import 'package:socialapp/utils/utils.dart';

import '../contant.dart';

class Post extends StatefulWidget {
  final id;
  final String image;
  int likeCount;
  int commentCount;
  final String username;
  final String location;
  final String profilePic;
  bool isLiked;
  Post(
      {Key key,
      this.id,
      this.image = 'https://i.imgur.com/E1zNNaX.jpg',
      this.likeCount,
      this.commentCount,
      this.username,
      this.profilePic,
      this.location,
      this.isLiked})
      : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  PostApiHelper _postApiHelper = PostApiHelper();

  @override
  Widget build(BuildContext context) {
    print(widget.isLiked);
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(widget.profilePic != null
                        ? widget.profilePic
                        : "https://cdn2.iconfinder.com/data/icons/instagram-ui/48/jee-74-512.png"),
                  ),
                  width(20.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.username,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        widget.location,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              CircleAvatar(
                backgroundColor: Colors.black,
                radius: 20,
                child: CircleAvatar(
                  radius: 19,
                  backgroundColor: kFeedBackgroundColor,
                  child: IconButton(
                      color: kFeedBackgroundColor,
                      splashRadius: 21,
                      onPressed: () => {},
                      splashColor: kPrimaryColor,
                      icon: Icon(
                        Icons.more_horiz_rounded,
                        color: Colors.black,
                      )),
                ),
              )
            ],
          ),
          height(15.0),
          InkWell(
            onDoubleTap: () => {print("Hello Double Tap")},
            onTap: () => {print("Hello Tap")},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.05,
                height: 250,
                child: Image(
                  image: NetworkImage(widget.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          height(10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      IconButton(
                        splashRadius: 20,
                        icon: Icon(
                          widget.isLiked
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: widget.isLiked
                              ? Colors.red.shade800
                              : Colors.black,
                          size: 28,
                        ),
                        onPressed: () async {
                          if (!widget.isLiked) {
                            var data = await _postApiHelper.likePost(
                                postId: widget.id);
                            setState(() {
                              if (data["error"] == null) {
                                widget.isLiked = true;
                                widget.likeCount += 1;
                              }
                            });
                          } else {
                            var data = await _postApiHelper.unLikePost(
                                postId: widget.id);
                            setState(() {
                              if (data["error"] == null) {
                                widget.isLiked = false;
                                widget.likeCount -= 1;
                              }
                            });
                          }
                        },
                      ),
                      Text(widget.likeCount.toString())
                    ],
                  ),
                  width(7.0),
                  Column(
                    children: [
                      IconButton(
                        splashRadius: 20,
                        icon: Icon(
                          Icons.chat_outlined,
                          size: 28,
                        ),
                        onPressed: () => {},
                      ),
                      Text(widget.commentCount.toString())
                    ],
                  ),
                  width(7.0),
                  Column(
                    children: [
                      IconButton(
                        splashRadius: 20,
                        icon: Icon(
                          Icons.send,
                          size: 28,
                        ),
                        onPressed: () => {},
                      ),
                      height(18.0)
                    ],
                  )
                ],
              ),
              IconButton(
                splashRadius: 20,
                icon: Icon(
                  Icons.download_outlined,
                  size: 28,
                ),
                onPressed: () => {},
              )
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
