import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool isRegistered= false;
  bool _isValid = false;

  void _saveForm() {
    setState(() {
      _isValid = _formKey.currentState.validate();
    });
  }
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users= FirebaseFirestore.instance.collection('sellers');
  final firestoreInstance = FirebaseFirestore.instance;
  String username="";
  String email="";
  String phoneNumber="";
  String password="";

  Future RegWithEmail() async{
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email,password: password,);
    firestoreInstance.collection("sellers").add(
        {
          "username" : username,
          "email" : email,
          "phoneNumber" : phoneNumber,
          "password" : password,
        });
    setState(() {
      isRegistered=true;
    });
    if(isRegistered){
      Navigator.pop(context);
      Fluttertoast.showToast(msg:'Registered successfully');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Sign Up', style: TextStyle(fontSize: 50,color: Theme.of(context).primaryColor),),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.9, margin: EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            onChanged: (val){setState(()=>username=val);},
                            style: TextStyle(fontSize: 20,),
                            decoration: InputDecoration(
                                hintStyle: TextStyle( fontSize: 20),
                                hintText: 'Username',
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2,),),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 3,),),
                                prefixIcon: Padding(child: Icon(Icons.person,color: Theme.of(context).primaryColor), padding: EdgeInsets.only(left: 30, right: 10),)),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This field is required';
                              }return null;
                            },
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.9, margin: EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            onChanged: (val){setState(()=>email=val);},
                            style: TextStyle(fontSize: 20,),
                            decoration: InputDecoration(
                                hintStyle: TextStyle( fontSize: 20),
                                hintText: 'Email',
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2,),),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 3,),),
                                prefixIcon: Padding(child: Icon(Icons.email,color: Theme.of(context).primaryColor), padding: EdgeInsets.only(left: 30, right: 10),)),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This field is required';
                              }
                              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return "Please enter a valid email address";
                              }return null;
                            },
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.9, margin: EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            onChanged: (val){setState(()=>phoneNumber=val);},
                            style: TextStyle(fontSize: 20,),
                            decoration: InputDecoration(
                                hintStyle: TextStyle( fontSize: 20),
                                hintText: 'Phone Number',
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2,),),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 3,),),
                                prefixIcon: Padding(child: Icon(Icons.phone,color: Theme.of(context).primaryColor), padding: EdgeInsets.only(left: 30, right: 10),)),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "This field is required";
                              } else if (value.length < 10) {
                                return "Please enter a valid phone number";
                              }
                              if (!RegExp (r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$').hasMatch(value)) {
                                return "Please enter a valid phone number";
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.9, margin: EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            obscureText: true,
                            onChanged: (val){setState(()=>password=val);},
                            style: TextStyle(fontSize: 20,),
                            decoration: InputDecoration(
                                hintStyle: TextStyle( fontSize: 20),
                                hintText: 'Password',
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2,),),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 3,),),
                                prefixIcon: Padding(child: Icon(Icons.lock,color: Theme.of(context).primaryColor), padding: EdgeInsets.only(left: 30, right: 10),)),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "This field is required";
                              } else if (value.length < 8) {
                                return "The password should be more than 8 characters";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                  ,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: Text('Sign up',style: TextStyle(fontSize: 20,color: Colors.white),),onPressed: (){
                      _saveForm();
                      RegWithEmail();},),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.2),
                    child: Row(
                      children: [
                        Text('Have an account?'),
                        FlatButton(child: Text('Log in',style: TextStyle(color: Theme.of(context).primaryColor),),onPressed: (){
                          Navigator.pop(context);},),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
