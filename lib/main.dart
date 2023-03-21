import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(LoginUI());
}

class LoginUI extends StatelessWidget {
  const LoginUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login UI',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final blueColor = Color(0XFF5e92f3);
  final yellowColor = Color(0XFFfdd835);
  TapGestureRecognizer? _tapGestureRecognizer;
  late bool _showSignIn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showSignIn = true;
    _tapGestureRecognizer = TapGestureRecognizer()
    ..onTap = (){
      setState(() {
        _showSignIn =! _showSignIn;
        print("hello world");
      });
    };
  }

  @override
  void dispose() {
    _tapGestureRecognizer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
         buildBackgroundTopCircle(),

         buildBackgroundBottomCircle(),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 16, right: 16, top: 50, bottom: 40),
                child: Column(
                  children: [
                    Text(
                      _showSignIn? "SIGN IN" : "CREATE ACCOUNT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),),
                    buildAvatarContainer(),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOutBack,
                      height: _showSignIn? 240 : 390,
                      margin: EdgeInsets.only(top: _showSignIn? 40 : 30),
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 2,
                            spreadRadius: 1,
                            offset: Offset(0, 1)
                          )
                        ]
                      ),
                      child: SingleChildScrollView(
                        child: _showSignIn? buildSignInTextFieldSection() : buildSignUpTextFieldSection(),
                      ),
                    ),
                    _showSignIn? buildSignInBottomSection() : buildSignUpBottomSection(),
                  ],
                ),
              ),
            ),
          )

        ],
      ),
    );
  }

  Positioned buildBackgroundTopCircle() {
    return  Positioned(
        top: 0,
        child: Transform.translate(
          offset: Offset(0.0, -MediaQuery.of(context).size.width / 1.3),
          child: Transform.scale(
            scale: 1.35,
            child: Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: _showSignIn? Colors.grey[800] : blueColor,
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width)),
            ),
          ),
        )
    );
  }

  Positioned buildBackgroundBottomCircle() {

    return Positioned(
      top: MediaQuery.of(context).size.height-MediaQuery.of(context).size.width,
      right: MediaQuery.of(context).size.width/2,
      child: Container(
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: blueColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.width)),
      ),
    );
  }

  Container buildAvatarContainer() {
    return Container(
      margin: EdgeInsets.only(top: 24),
      height: 130,
      width: 130,
      decoration: BoxDecoration(
        color: _showSignIn? yellowColor : Colors.grey[800],
        //shape: BoxShape.circle
        borderRadius: BorderRadius.circular(65),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 4,
            blurRadius: 20,
          )
        ],
      ),
      child: Center(child: Stack(
          children: [
            Positioned(
                left: 32.0,
                top: 18.0,
                child: Icon(Icons.arrow_forward,color: Colors.white,)
            ),
            Icon(Icons.person_outlined, size: 60, color: Colors.white,)
          ]),
      ),
    );
  }

  Container buildTextField(String labelText, String placeholder, bool isPassword) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText,style: TextStyle(
              color: blueColor, fontSize: 12
          )),
          SizedBox(height: 5,),
          TextField(
            obscureText: isPassword,
            decoration: InputDecoration(
              fillColor: Colors.grey[200],
              hintText: placeholder,
              filled: true,
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide:BorderSide(color: Colors.grey),
              ),
            ),
          )
        ],
      ),

    );
  }

  Column buildSignInTextFieldSection() {

    return Column(
      children: [
        buildTextField("Email Address", "test123@gmail.com", false),
        SizedBox(height: 30,),
        buildTextField("Password", "*******", true),
      ],
    );
  }
  Column buildSignUpTextFieldSection() {

    return Column(
      children: [
        buildTextField("USERNAME", "test123", false),
        SizedBox(height: 20,),
        buildTextField("EMAIL ADDRESS", "test123@gmai.com", false),
        SizedBox(height: 20,),
        buildTextField("MOBILE NUMBER", "01717......", false),
        SizedBox(height: 20,),
        buildTextField("PASSWORD", "*******", true),
      ],
    );
  }

  Container buildSignInBottomSection() {

    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Text("Forgot Password",
            style: TextStyle(
              color: blueColor,
              decoration: TextDecoration.underline,
            ),),
          SizedBox(height: 25,),

          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: blueColor,
                  elevation: 10,
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 12)
              ),
              onPressed: () {

              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Login", style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 5,),
                  Icon(Icons.arrow_right, color: yellowColor,)
                ],
              )
          ),

          SizedBox(height: 40,),
          RichText(
            text: TextSpan(
                text: "Don't have account? ",
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                      text: "Create an account",
                      recognizer: _tapGestureRecognizer,
                      style: TextStyle(
                          color: blueColor,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold
                      )
                  )
                ]
            ),
          ),
        ],
      ),
    );
  }
  Container buildSignUpBottomSection() {

    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: yellowColor,
                  elevation: 10,
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 12)
              ),
              onPressed: () {

              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "SUBMIT", style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(width: 5,),
                  Icon(Icons.arrow_right, color: Colors.black,)
                ],
              )
          ),

          SizedBox(height: 20,),
          RichText(
            text: TextSpan(
                text: "Already have an account? ",
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                      text: "Sign in",
                      recognizer: _tapGestureRecognizer,
                      style: TextStyle(
                          color: blueColor,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold
                      )
                  )
                ]
            ),
          ),
        ],
      ),
    );
  }
}
