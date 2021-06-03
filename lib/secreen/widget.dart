import 'package:flutter/material.dart';

Padding myInput(String hintText, TextEditingController controller,
    IconData myicon, bool inPassword) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
    child: TextFormField(
      controller: controller,
      obscureText: inPassword,
      style: TextStyle(fontSize: 10),
      cursorColor: Colors.deepOrange,
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: Colors.black12, width: 0.0)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: Colors.black12, width: 0.0)),
        fillColor: Colors.black12,
        filled: true,
        hintText: hintText,
        labelStyle: TextStyle(color: Colors.deepOrange),
        prefixIcon: Icon(
          myicon,
          color: Colors.deepOrange,
        ),
      ),
    ),
  );
}

class MyButton extends StatefulWidget {
  var textContent;
  VoidCallback onPressed;
  MyButton({@required this.textContent, @required this.onPressed});
  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 50,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
          ),
        ),
        child: Center(
          child: Text(
            widget.textContent,
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}

Future<void> showMyDialog(BuildContext context, String title, String message,
    Function onPressed) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Text(message),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: onPressed,
          ),
        ],
      );
    },
  );
}
