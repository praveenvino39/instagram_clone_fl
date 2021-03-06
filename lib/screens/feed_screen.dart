import 'package:animated_float_action_button/animated_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/Services/File/image_picker_helper.dart';
import 'package:socialapp/Services/Network/post_api_handler.dart';
import 'package:socialapp/contant.dart';
import 'package:socialapp/screens/add_post.dart';
import 'package:socialapp/screens/user_profile_screen.dart';
import 'package:socialapp/screens/welcome_screen.dart';
import 'package:socialapp/utils/utils.dart';
import 'package:socialapp/widgets/post.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        duration: const Duration(microseconds: 200), vsync: this);
    animation = Tween<double>(begin: 0, end: 25).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  final GlobalKey<AnimatedFloatingActionButtonState> fabKey =
      GlobalKey<AnimatedFloatingActionButtonState>();
  bool isFabShowing = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: kPrimaryColor,
            child: Icon(Icons.add),
            onPressed: () {
              print("working");
              if (isFabShowing) {
                animationController.reverse();
                isFabShowing = !isFabShowing;
              } else {
                animationController.forward();
                isFabShowing = !isFabShowing;
              }
            },
          ),
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.send),
                color: Colors.black,
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen())),
              )
            ],
            title: Text(
              "Clubhouse",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: Colors.black)),
            ),
            backgroundColor: kFeedBackgroundColor,
          ),
          backgroundColor: kFeedBackgroundColor,
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'My Profile'),
            ],
            onTap: (index) => setState(() => currentIndex = index),
            currentIndex: currentIndex,
          ),
          body: FutureBuilder(
            future: PostApiHelper().getHome(),
            builder: (context, snapshot) => snapshot.hasData
                ? Stack(children: [
                    ListView.builder(
                      itemBuilder: (context, index) => Post(
                        id: snapshot.data[index]["post"]["id"],
                        username: snapshot.data[index]["post"]["user"]
                            ["username"],
                        profilePic: snapshot.data[index]["profile"]
                                    ["profile_picture"] !=
                                null
                            ? snapshot.data[index]["profile"]["profile_picture"]
                            : null,
                        image:
                            '$baseUrl${snapshot.data[index]["post"]["post_image"].substring(1)}',
                        likeCount: snapshot.data[index]["post"]["likes"].length,
                        isLiked: snapshot.data[index]["is_current_user_liked"],
                        commentCount:
                            snapshot.data[index]["post"]["comments"].length,
                        location: snapshot.data[index]["post"]["caption"],
                      ),
                      itemCount: snapshot.data.length,
                    ),
                    Positioned(
                      bottom: 80,
                      right: 18,
                      child: CircleAvatar(
                        radius: animation.value,
                        backgroundColor: kPrimaryColor,
                        child: IconButton(
                            icon: Icon(
                              Icons.camera,
                              color: Colors.white,
                            ),
                            onPressed: () => {
                                  FlutterSecureStorage()
                                      .delete(key: "authToken")
                                }),
                      ),
                    ),
                    Positioned(
                      bottom: 135,
                      right: 18,
                      child: CircleAvatar(
                        backgroundColor: kPrimaryColor,
                        radius: animation.value,
                        child: IconButton(
                            icon: Icon(
                              Icons.photo,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              PickedFile image = await pickImageFromGallery();
                              // if (image != null)
                              Navigator.pushNamed(context, '/add_post',
                                  arguments: {"picked_file": image});
                            }),
                      ),
                    )
                  ])
                : width(10.0),
          )),
    );
  }
}
