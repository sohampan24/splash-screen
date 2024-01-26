// ignore_for_file: unused_field, unnecessary_new, prefer_const_constructors, unused_local_variable, body_might_complete_normally_nullable, use_build_context_synchronously

import 'package:splash_screen/models/userModel.dart';
import 'package:splash_screen/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //form key
  final _formKey = GlobalKey<FormState>();

  //editing controller
  final nameEditingController = new TextEditingController();
  final phoneEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  final _auth = FirebaseAuth.instance;

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()});
            
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(msg: e.message!);
      }
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    userModel users = userModel();

    users.uid = user!.uid;
    users.name = nameEditingController.text;
    users.phoneNo = phoneEditingController.text;
    users.email = user!.email;
    users.password = passwordEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(users.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(
            builder: (context) => LoginScreen(title: 'Account Created')),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    //name field
    final nameField = TextFormField(
      autofocus: false,
      controller: nameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        // RegExp regex = new RegExp(r'^.{15,}$');
        if (value!.isEmpty) {
          return ("Name cannot be Empty");
        }
        // if (!regex.hasMatch(value)) {
        //   return ("Enter Valid name(Min. 15 Character)");
        // }
        return null;
      },
      onSaved: (value) {
        nameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.account_circle,
          color: Color.fromRGBO(75, 57, 239, 0.911),
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    //phone field
    final phoneField = TextFormField(
      autofocus: false,
      controller: phoneEditingController,
      keyboardType: TextInputType.phone,
      validator: (value) {
        // RegExp regex = new RegExp('^[0-9]{10}');
        if (value!.isEmpty) {
          return ("Please Enter Your Phone Number");
        }
        if (!RegExp("^[0-9]{10}").hasMatch(value)) {
          return ("Please enter a valid number");
        }
      },
      onSaved: (value) {
        phoneEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.phone,
          color: Color.fromRGBO(75, 57, 239, 0.911),
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Phone Number',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailEditingController.text = value!;
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
      controller: passwordEditingController,
      // keyboardType: TextInputType.emailAddress,
      obscureText: true,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
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

    //confirm password
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      // keyboardType: TextInputType.emailAddress,
      obscureText: true,
      validator: (value) {
        if (confirmPasswordEditingController.text !=
                passwordEditingController.text) {
          return "Password don't match";
        }
        return null;
      },
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.key,
          color: Color.fromRGBO(75, 57, 239, 0.911),
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Confirm Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    //sign up button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromRGBO(75, 57, 239, 0.911),
      child: MaterialButton(
        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        textColor: Colors.white,
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        child: Text(
          'SignUp',
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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Breakdown Buddy',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28.0,
          ),
        ),
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
                      'Create an Account',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Let\'s get started by filling out the form below',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  nameField,
                  SizedBox(
                    height: 25,
                  ),
                  phoneField,
                  SizedBox(
                    height: 25,
                  ),
                  emailField,
                  SizedBox(
                    height: 25,
                  ),
                  passwordField,
                  SizedBox(
                    height: 25,
                  ),
                  confirmPasswordField,
                  SizedBox(
                    height: 50,
                  ),
                  signUpButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}