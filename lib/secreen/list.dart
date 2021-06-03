import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list2/api_call/task_calls.dart';
import 'package:list2/secreen/widget.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class listP extends StatefulWidget {
  @override
  _listPState createState() => _listPState();
}

class _listPState extends State<listP> {
  var Task = TextEditingController();
  bool isInCall = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      child: Scaffold(
          drawer: Drawer(
            child: Column(
              children: [
                Container(
                  color: Colors.deepOrange,
                  margin: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home),
                      SizedBox(
                        width: 6,
                      ),
                      Text('Home Page')
                    ],
                  ),
                )
              ],
            ),
            elevation: 16.0,
            semanticLabel: 'Inchallah List',
          ),
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            //leading: Icon(Icons.menu),
            title: Text('Inchallah List'),
          ),
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 18),
                child: Text(
                  'Inchallah I will : ',
                  style: TextStyle(color: Colors.black45, fontSize: 35),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 18),
                child: myInput(
                  'Text',
                  Task,
                  Icons.text_fields,
                  false,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              MyButton(
                textContent: "Add",
                onPressed: () {
                  setState(() {
                    isInCall = true;
                  });
                  // Navigator.pop
                  //context,
                  taskCalls.addTask(Task.text).then((res) {
                    setState(() {
                      isInCall = false;
                    });
                    if (res.statusCode == 201) {
                      Navigator.pop(context);
                      print(res.body);
                    } else {
                      showMyDialog(
                        context,
                        "eroor !",
                        res.body,
                        () {
                          Navigator.pop(context);
                        },
                      );
                    }
                  });
                },
              )
            ],
          )),
      inAsyncCall: isInCall,
      opacity: 0.5,
      progressIndicator: CircularProgressIndicator(),
    );
  }
}
