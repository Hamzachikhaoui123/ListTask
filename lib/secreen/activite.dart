import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:list2/api_call/auth_calls.dart';
import 'package:list2/secreen/widget.dart';
import 'package:list2/utils.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class activite extends StatefulWidget {
  @override
  _activiteState createState() => _activiteState();
}

class _activiteState extends State<activite> {
  var email = TextEditingController();
  var password = TextEditingController();
  var person = TextEditingController();
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
                    margin: EdgeInsets.all(10),
                    child: Text(
                      'Inchallah\n list',
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  )
                ],
              ),
              Container(
                transform: Matrix4.translationValues(20, -50, 0),
                margin: EdgeInsets.only(left: 160),
                child: Image.asset(
                  'assets/todo.png',
                  width: 120,
                ),
              ),
              myInput(
                'Person',
                person,
                Icons.person,
                false,
              ),
              SizedBox(
                height: 10,
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
              MyButton(
                textContent: 'Sign Up',
                onPressed: () {
                  setState(() {
                    isInCall = true;
                  });
                  AuthCalls.Register(
                    email.text,
                    password.text,
                    person.text,
                  ).then(
                    (result) {
                      setState(() {
                        isInCall = false;
                      });
                      if (result.statusCode == 201) {
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
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  GestureDetector(
                    child: new Text(
                      "Sign In!",
                      style: new TextStyle(
                        color: Colors.orange,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/');
                    },
                  ),
                ],
              ),
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
