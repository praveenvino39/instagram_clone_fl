import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/Services/Network/post_api_handler.dart';
import 'package:socialapp/contant.dart';
import 'package:socialapp/screens/welcome_screen.dart';
import 'package:socialapp/utils/utils.dart';
import 'package:text_editor/text_editor.dart';

class AddPost extends StatefulWidget {
  AddPost({Key key, image, devHeight}) : super(key: key);
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  double devheight;
  int currentIndex = 0;
  Uint8List imageToRender;
  String caption;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<Uint8List> readImage() async {
    var args = ModalRoute.of(context).settings.arguments as Map;
    // print(args["picked_file"].readAsBytes());
    return args["picked_file"].readAsBytes();
  }

  Future<PickedFile> getImage() async {
    var args = ModalRoute.of(context).settings.arguments as Map;
    // print(args["picked_file"].readAsBytes());
    return args["picked_file"];
  }

  @override
  Widget build(BuildContext context) {
    double mqheight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kFeedBackgroundColor,
        // bottomNavigationBar: BottomNavigationBar(
        //   items: [
        //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.search), label: 'Search'),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.person), label: 'My Profile'),
        //   ],
        //   onTap: (index) => setState(() => currentIndex = index),
        //   currentIndex: currentIndex,
        // ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                FutureBuilder(
                    future: readImage(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Image(
                            image: MemoryImage(snapshot.data),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: mqheight / 1.06);
                      }
                      if (snapshot.hasError) {
                        return Text(snapshot.error);
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
                Positioned(
                  bottom: 0,
                  child: Container(
                    color: Colors.white.withAlpha(200),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width / 1.4,
                          child: Theme(
                            data: ThemeData(primaryColor: kPrimaryColor),
                            child: TextField(
                              onChanged: (value) => {caption = value},
                              minLines: 1,
                              maxLines: 3,
                            ),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () async {
                            var data = await PostApiHelper().addPost(
                                image: await getImage(), caption: caption);
                          },
                          child: Text(
                            "Add Post",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: kPrimaryColor,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
