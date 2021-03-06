import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/Services/Network/auth_api_handler.dart';
import 'package:socialapp/contant.dart';
import 'package:socialapp/providers/user_provider.dart';
import 'package:socialapp/screens/signup_screen.dart';
import 'package:socialapp/screens/user_profile_screen.dart';
import 'package:socialapp/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = false;
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  FlutterSecureStorage _storage = FlutterSecureStorage();
  bool isLoading = false;
  ApiHelper _apiHelper = ApiHelper();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldkey,
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  height(30.0),
                  FloatingActionButton(
                    disabledElevation: 0,
                    focusElevation: 0,
                    hoverElevation: 0,
                    highlightElevation: 0,
                    elevation: 0,
                    backgroundColor: kSecondaryColor,
                    onPressed: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: kPrimaryColor,
                    ),
                  ),
                  height(30.0),
                  Text(
                    'Welcome,',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600)),
                  ),
                  Text(
                    'Login to your account',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w600)),
                  ),
                  height(50.0),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(fontWeight: FontWeight.w500),
                              fontSize: 18),
                        ),
                        height(5.0),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "This field is requried."),
                          controller: _username,
                          decoration: InputDecoration(
                              fillColor: kSecondaryColor,
                              filled: true,
                              border: InputBorder.none),
                        )
                      ],
                    ),
                  ),
                  height(20.0),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Password',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(fontWeight: FontWeight.w500),
                              fontSize: 18),
                        ),
                        height(5.0),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: "This field is required"),
                          controller: _password,
                          obscureText: !showPassword,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                splashRadius: 10,
                                onPressed: () => {
                                  print(userProvider.get()),
                                  setState(() => showPassword = !showPassword)
                                },
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: showPassword
                                      ? kPrimaryColor
                                      : Colors.blueGrey,
                                ),
                              ),
                              fillColor: kSecondaryColor,
                              filled: true,
                              border: InputBorder.none),
                        )
                      ],
                    ),
                  ),
                  height(40.0),
                  FlatButton(
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    height: 50,
                    color: kPrimaryColor,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() => isLoading = true);
                        Map response = await _apiHelper.login(
                            username: _username.text,
                            password: _password.text,
                            context: context);
                        if (response["status_code"] == 200) {
                          userProvider.addToken(
                              token: response["data"]["token"]);
                          await _storage.write(
                              key: "authToken", value: userProvider.token);
                          setState(() => {
                                _password.text = "",
                                _username.text = "",
                                isLoading = false,
                              });
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/home', (route) => false);
                        }
                        if (response["status_code"] == 400) {
                          setState(() => {isLoading = false});
                          _scaffoldkey.currentState.removeCurrentSnackBar();
                          _scaffoldkey.currentState.showSnackBar(
                            SnackBar(
                              content: Text(
                                "Username or password incorrect, Kindly double check it and try again!",
                                style: GoogleFonts.poppins(),
                              ),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      }
                    },
                    child: !isLoading
                        ? Text(
                            'Login',
                            style: kButtonTextStyle,
                          )
                        : CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(kSecondaryColor),
                          ),
                  ),
                  height(20.0),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: OutlineButton(
                      borderSide: BorderSide(color: kPrimaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      onPressed: () => {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/google.svg',
                            width: 22,
                          ),
                          width(20.0),
                          Text(
                            "Login in with Google",
                            style:
                                kButtonTextStyle.copyWith(color: kPrimaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  height(20.0),
                  Row(
                    children: [
                      Text(
                        "Don\'t have an account?",
                        style: GoogleFonts.montserrat(),
                      ),
                      width(7.0),
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                        ),
                        child: Text(
                          "Signup",
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(color: kPrimaryColor),
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
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
