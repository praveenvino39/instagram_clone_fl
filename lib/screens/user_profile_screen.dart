import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialapp/contant.dart';
import 'package:socialapp/utils/utils.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isPopularTab = true;
  ScrollController _singleChildScrollController = ScrollController();
  ScrollController _gridViewScrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _gridViewScrollController
      ..addListener(() {
        if (_gridViewScrollController.offset < 300) {
          _singleChildScrollController.jumpTo(_gridViewScrollController.offset);
        }
        if (_gridViewScrollController.offset > 300) {
          _singleChildScrollController.animateTo(300,
              duration: Duration(milliseconds: 50), curve: Curves.easeIn);
        }
      });
    _singleChildScrollController
      ..addListener(() {
        print(_singleChildScrollController.offset);
        if (_singleChildScrollController.offset >= 300) {
          _singleChildScrollController.jumpTo(300);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            splashRadius: 20,
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => {},
            color: kPrimaryColor,
          ),
          actions: [
            IconButton(
              splashRadius: 20,
              icon: Icon(Icons.more_vert),
              onPressed: () => {},
              color: kPrimaryColor,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SingleChildScrollView(
            controller: _singleChildScrollController,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  width(MediaQuery.of(context).size.width),
                  height(20.0),
                  Container(
                    width: double.infinity,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "4356",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              height(5.0),
                              Container(
                                  width: 120,
                                  child: Center(child: Text("FOLLOWERS")))
                            ],
                          ),
                          CircleAvatar(
                            radius: 57,
                            backgroundColor: kPrimaryColor,
                            child: Stack(children: [
                              Positioned(
                                left: 80,
                                bottom: 80,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                      'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixid=MXwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZmlsZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80'),
                                ),
                              ),
                            ]),
                          ),
                          Column(
                            children: [
                              Text(
                                "734",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              height(5.0),
                              Container(
                                  width: 120,
                                  child: Center(child: Text("POSTS"))),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  height(20.0),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "SAM MARTIN",
                      style: GoogleFonts.poppins(
                          textStyle:
                              TextStyle(fontSize: 20, letterSpacing: -.5)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  height(7.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.pin_drop_outlined,
                        size: 17,
                      ),
                      width(7.0),
                      Text(
                        "Los Angeles",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  height(20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        minWidth: 150,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        height: 40,
                        color: kPrimaryColor,
                        onPressed: () async {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 14,
                            ),
                            width(7.0),
                            Text('FOLLOW',
                                style: kButtonTextStyle.copyWith(fontSize: 11)),
                          ],
                        ),
                      ),
                      width(16.0),
                      Container(
                        width: 150,
                        height: 40,
                        child: OutlineButton(
                          borderSide: BorderSide(color: kPrimaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          onPressed: () => {},
                          child: Text(
                            "MESSAGE",
                            style: kButtonTextStyle.copyWith(
                                fontSize: 11, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  height(20.0),
                  GestureDetector(
                    onVerticalDragCancel: () => {},
                    onVerticalDragDown: (e) => {},
                    onVerticalDragEnd: (e) => {},
                    onVerticalDragStart: (e) => {},
                    child: StickyHeader(
                      content: Container(
                          padding: EdgeInsets.only(
                              right: 5, left: 5, top: 5, bottom: 150),
                          height: MediaQuery.of(context).size.height + 10,
                          child: GridView.builder(
                              shrinkWrap: true,
                              controller: _gridViewScrollController,
                              itemCount: 20,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5),
                              itemBuilder: (context, index) => ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image(
                                      image: NetworkImage(
                                          'https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixid=MXwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZmlsZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80'),
                                      fit: BoxFit.cover,
                                    ),
                                  ))),
                      header: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => setState(() => isPopularTab = false),
                              child: Stack(children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 250),
                                  height: 35,
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  color: !isPopularTab
                                      ? kPrimaryColor
                                      : Colors.white,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child: Text(
                                      "POSTS",
                                      style: TextStyle(
                                          color: !isPopularTab
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () => {
                                setState(() {
                                  isPopularTab = true;
                                }),
                              },
                              child: Stack(children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 250),
                                  height: 35,
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  color: isPopularTab
                                      ? kPrimaryColor
                                      : Colors.white,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child: Text(
                                      "POPULARS",
                                      style: TextStyle(
                                          color: isPopularTab
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
