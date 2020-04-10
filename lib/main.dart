import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

void main() {

  runApp(MyApp());


}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Registration Page",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Sign up Page"),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}
// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final format = DateFormat("dd-MM-yyyy");
  bool _autoValidate = false;

  static String name;
  String email;
  String passWord;
  String dateOfBirth;


  void _submitCommand() {
    final form = _formKey.currentState;

    if (_formKey.currentState.validate()) {
      form.save();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecondRoute()),
      );
    }else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                child: TextFormField(
                decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Full Name',
                ),
                  validator: validateName,
                  onSaved: (value){
                  name = value;
                },
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email Address",
                  ),
                  validator: validateEmail,
                  onSaved: (value){
                    email = value;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                  ),
                  validator: (value){
                    return validatePassword(value);
                  },
                  onSaved: (value){
                  },

                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                  child: DateTimeField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[200],
                      labelText: "Select your date of birth",
                    ),
                    format: format,
                    validator: validateDateOfBirth,
                    onSaved: (value){
                      dateOfBirth = value.toString();
                    },
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: DateTime(1990),
                          lastDate: DateTime(2100));

                    },
                  ),

              ),
              Container(
                margin: EdgeInsets.all(20),
                child: RaisedButton(
                  onPressed: _submitCommand,
                    child: Text('Sign up'),
                ),
              ),

              // Add TextFormFields and RaisedButton here.
            ]
        )
    );
  }

  String validateName(String value) {
    if (value.length == 0)
      return 'Please enter your name';
    else if (value.length < 3){
      return "Name too short";
  }else{
      return null;
    }
  }

  String validateEmail(String value) {
    if (!EmailValidator.validate(value)){
      return "please enter email address that has the form of example@example.com";
    }
    return null;
  }

  String validatePassword(String value) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(pattern);

    if(value.isEmpty){
      return "please enter a password";
    }else if (!regex.hasMatch(value)) {
      return """Your Password should be at least 8 charatters and it has to contain:
                 Minimum 1 Upper case
                 Minimum 1 lowercase
                 Minimum 1 Numeric Number 
                 Minimum 1 Special Character 
                 Common Allow Character ( ! @ # \$ & * ~ )""";
    } else {
      return null;
    }
  }


  String validateDateOfBirth(value) {
    if(value == null ){
      return "Please select a date of birth";
    }else{
      return null;
    }
  }


}



class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration Successful!"),
      ),
      body: Center(
          child: Text(
              "Registration Successful!",
               style: TextStyle(
               fontSize: 50,
          ),
          )
      ),
    );
  }
}