// ignore_for_file: unused_field, unnecessary_new, unused_local_variable, prefer_const_constructors, body_might_complete_normally_nullable

import 'package:splash_screen/screens/addvehicle.dart';
import 'package:splash_screen/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required String title});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();

  //editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;

  //login function
    void signIn(String email, String password) async {
      if (_formKey.currentState!.validate()) {
        try {
          await _auth.signInWithEmailAndPassword(email: email, password: password)
              .then((uid) => {
                    Fluttertoast.showToast(msg: 'Login Successful'),
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: ((context) => AddVehicle())))
                  });
        } on FirebaseAuthException catch (error) {
          Fluttertoast.showToast(msg: error.message!);
          // print(error.code);
        }
      }
    }

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter the Email");
        }
        //reg expression for email
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.mail,
          color: Color.fromRGBO(75, 57, 239, 0.911),
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ('Password is required for login');
        }
        if (!regex.hasMatch(value)) {
          return ('Please Enter Valid Password (Min. 6 character)');
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.key,
          color: Color.fromRGBO(75, 57, 239, 0.911),
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromRGBO(75, 57, 239, 0.911),
      child: MaterialButton(
        onPressed: () {
          signIn(emailController.text, passwordController.text);
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
        textColor: Colors.white,
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        child: Text(
          'Login',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(75, 57, 239, 0.911),
        title: Title(
            color: Colors.white,
            child: Center(
              child: Text(
                'Breakdown Buddy',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                ),
              ),
            )),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      "assets/logo.jpg",
                      fit: BoxFit.contain,
                    ),
                  ),
                  // SizedBox(height: 25,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  emailField,
                  SizedBox(
                    height: 25,
                  ),
                  passwordField,
                  SizedBox(
                    height: 50,
                  ),
                  loginButton,
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Dont have an account? '),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => SignUpScreen())));
                        },
                        child: Text(
                          'SignUp',
                          style: TextStyle(
                            color: Color.fromRGBO(75, 57, 239, 0.911),
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                      ),
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