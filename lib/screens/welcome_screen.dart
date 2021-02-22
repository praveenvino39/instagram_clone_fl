import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialapp/contant.dart';
import 'package:socialapp/screens/login_screen.dart';
import 'package:socialapp/screens/signup_screen.dart';
import 'package:socialapp/utils/utils.dart';
import 'package:socialapp/widgets/intro_index_indicator.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  child: SvgPicture.asset(
                    'assets/svg/message.svg',
                    width: 300,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            "CONNECT ON THE FLY",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 50),
                            child: Text(
                              "Spend your quality time with your loved one.",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    height: 1.5),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IntroIndexIndicator(
                                isActive: false,
                              ),
                              IntroIndexIndicator(
                                isActive: false,
                              ),
                              IntroIndexIndicator(
                                isActive: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                      height(50.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            height: 50,
                            minWidth: 150,
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupScreen())),
                            child: Text(
                              "Sign up",
                              style: kButtonTextStyle,
                            ),
                            color: Color(0xFF256BEE),
                          ),
                          Container(
                            width: 150,
                            height: 50,
                            child: OutlineButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              borderSide: BorderSide(
                                color: Color(0xFF256BEE),
                              ),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              ),
                              child: Text(
                                "Log in",
                                style: kButtonTextStyle.copyWith(
                                    color: Color(0xFF256BEE)),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              width(MediaQuery.of(context).size.width)
            ],
          ),
        ),
      ),
    );
  }
}
