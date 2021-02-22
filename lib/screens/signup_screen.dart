import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:socialapp/Services/Network/auth_api_handler.dart';
import 'package:socialapp/contant.dart';
import 'package:socialapp/screens/login_screen.dart';
import 'package:socialapp/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialapp/widgets/Alerts/auth_alerts.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool showPassword = false;
  bool acceptPolicy = false;
  String username = '';
  String password = '';
  bool isLoading = false;
  ApiHelper _apiHelper = ApiHelper();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    'Create',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600)),
                  ),
                  Text(
                    'Account',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600)),
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
                          validator: MinLengthValidator(1,
                              errorText: "Username shoudn\'t be empty."),
                          onChanged: (value) => username = value,
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
                          validator: passwordValidator,
                          obscureText: !showPassword,
                          onChanged: (value) => password = value,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                splashRadius: 10,
                                onPressed: () => setState(
                                    () => showPassword = !showPassword),
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
                  height(30.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: acceptPolicy,
                        onChanged: (value) =>
                            setState(() => acceptPolicy = value),
                      ),
                      GestureDetector(
                        onTap: () =>
                            setState(() => acceptPolicy = !acceptPolicy),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.39,
                          child: RichText(
                            text: TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'I agreed to the ',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(fontSize: 15),
                                  ),
                                ),
                                TextSpan(
                                  text: 'Terms & Conditions',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 15, color: kPrimaryColor),
                                      decoration: TextDecoration.underline),
                                ),
                                TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Privacy & Policy',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 15, color: kPrimaryColor),
                                      decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  height(30.0),
                  FlatButton(
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    height: 50,
                    color: kPrimaryColor,
                    onPressed: acceptPolicy
                        ? () async {
                            if (_formKey.currentState.validate() &&
                                acceptPolicy) {
                              setState(() => isLoading = true);
                              Map response = await _apiHelper.registration(
                                  username: username,
                                  password: password,
                                  context: context);
                              print(response);
                              if (response["status_code"] == 201) {
                                setState(() => {isLoading = false});
                                showDialog(
                                  context: context,
                                  builder: (context) => AccountCreatedAlert(),
                                );
                                setState(() {
                                  username = '';
                                  password = '';
                                  acceptPolicy = false;
                                });
                              }
                              if (response["status_code"] == 500) {
                                setState(() => {isLoading = false});
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      UsernameAlreadyTakenAlert(
                                    context: context,
                                  ),
                                );
                              }
                            }
                          }
                        : null,
                    disabledColor: kSecondaryColor,
                    child: !isLoading
                        ? Text(
                            'Create Account',
                            style: acceptPolicy
                                ? kButtonTextStyle
                                : kButtonTextStyle.copyWith(
                                    color: Colors.black26),
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
                            "Sign up with Google",
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
                        "Already have an account?",
                        style: GoogleFonts.montserrat(),
                      ),
                      width(7.0),
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        ),
                        child: Text(
                          "Login",
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

var passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'password is required'),
  MinLengthValidator(8, errorText: "Password must be atleast 8 characted long"),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText: 'Passwords must have at least one special characters')
]);
