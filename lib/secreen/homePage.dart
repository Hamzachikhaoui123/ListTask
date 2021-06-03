import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list2/api_call/auth_calls.dart';
import 'package:list2/secreen/widget.dart';
import 'package:list2/utils.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  var email = TextEditingController();
  var password = TextEditingController();

  bool _checkbox = false;
  bool isInCall = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/t3_ic_background.png',
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                  ),
                  Container(
                    margin: EdgeInsets.all(30),
                    child: Text(
                      'Inchallah\nList',
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                ],
              ),
              Container(
                transform: Matrix4.translationValues(25, -50, 0),
                margin: EdgeInsets.only(left: 160),
                child: Image.asset(
                  'assets/todo.png',
                  width: 120,
                ),
              ),
              myInput(
                'Email',
                email,
                Icons.email,
                false,
              ),
              SizedBox(
                height: 10,
              ),
              myInput(
                'Password',
                password,
                Icons.vpn_key,
                true,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                        value: _checkbox,
                        activeColor: Colors.green,
                        onChanged: (bool newValue) {
                          setState(() {
                            _checkbox = newValue;
                          });
                        }),
                    Text(
                      'Remember',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              MyButton(
                textContent: 'Sign In',
                onPressed: () {
                  setState(() {
                    isInCall = true;
                  });
                  AuthCalls.login(
                    email.text,
                    password.text,
                  ).then(
                    (result) {
                      setState(() {
                        isInCall = false;
                      });
                      if (result.statusCode == 200) {
                        // decode lel body : ken json wal dart
                        var body = jsonDecode(result.body);
                        // 5thina token mel body
                        String token = body['token'];
                        //save l token fi shared pref
                        Utils.saveTaken(token);
                        //mchina l main page
                        Navigator.pushReplacementNamed(context, '/thrid');
                      } else {
                        showMyDialog(
                          context,
                          "eroor !",
                          result.body,
                          () {
                            Navigator.pop(context);
                          },
                        );
                      }
                    },
                  );
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 60),
                      child: Text("Don't have an account?")),
                  GestureDetector(
                    child: new Text(
                      "Sign Up!",
                      style: new TextStyle(
                        color: Colors.orange,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/seconde');
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        inAsyncCall: isInCall,
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(),
      ),
    );
  }
}
