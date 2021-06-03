import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:list2/api_call/task_calls.dart';
import 'package:list2/models/task.dart';
import 'package:list2/secreen/list.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class meun extends StatefulWidget {
  @override
  _meunState createState() => _meunState();
}

class _meunState extends State<meun> {
  List<Task> myTasks = [];
  bool inAsyncall = false;
  //decralation global les tabel myTasks de type Task
  void callApi() {
    List<Task> myLocalTasks = []; // tabdel local
    setState(() {
      inAsyncall = true;
    });
    taskCalls.getAllTasks().then((value) {
      var mybody = jsonDecode(value.body);
      for (Map obj in mybody['data']) {
        Task objTask = Task.fromJson(obj);
        myLocalTasks.add(objTask);
      }
      setState(() {
        myTasks = myLocalTasks;
        inAsyncall = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    callApi();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              Row(
                children: [Icon(Icons.email)],
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
        body: Container(
          color: Colors.white,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) => Card(
              child: Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: CheckboxListTile(
                  value: myTasks[index].completed,
                  onChanged: (valeur) {
                    setState(() {
                      myTasks[index].completed = valeur;
                    });
                    //update fi base de donnees
                    taskCalls.updateTask(myTasks[index].id, valeur);
                  },
                  title: Text(
                    myTasks[index].description,
                    style: TextStyle(
                      decoration: (myTasks[index].completed)
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ),
                actions: <Widget>[
                  IconSlideAction(
                    caption: 'Archive',
                    color: Colors.blue,
                    icon: Icons.archive,
                    onTap: () => _showSnackBar('Archive'),
                  ),
                  IconSlideAction(
                    caption: 'Share',
                    color: Colors.indigo,
                    icon: Icons.share,
                    onTap: () => _showSnackBar('Share'),
                  ),
                ],
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'More',
                    color: Colors.black45,
                    icon: Icons.more_horiz,
                    onTap: () => _showSnackBar('More'),
                  ),
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () {
                      setState(() {
                        inAsyncall = true;
                      });
                      taskCalls.deletTasek(myTasks[index].id).then((value) {
                        if (value.statusCode == 200) {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('tfas5t'),
                            ),
                          );
                          setState(() {
                            inAsyncall = false;
                          });

                          myTasks.remove(myTasks[index]);
                        }
                      });
                    },
                  ),
                ],
              ),
            ), //card design mt3 iteam mT3 fi list
            itemCount: myTasks.length, //9adech men element fi list
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange,
          child: Icon(Icons.playlist_add),
          onPressed: () async {
            // Navigator.pushNamed(context, '/for');
            String melPagelokhra = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => listP(),
              ),
            );
            callApi();
          },
        ),
      ),
      inAsyncCall: inAsyncall,
      opacity: 0.5,
      progressIndicator: CircularProgressIndicator(),
    );
  }
}

_showSnackBar(String s) {}
