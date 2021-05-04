import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final _formKey = GlobalKey<FormState>();
  bool _isValid = false;

  void _saveForm() {
    setState(() {
      _isValid = _formKey.currentState.validate();
    });
  }
  bool isLoggedin= false;

  Future signInWithGoogle () async{
    setState(() {
      isLoggedin=true;
    });
    final user= await googleSignIn.signIn();
    if (user== null){
      isLoggedin=false;
      return;
    }else{
      GoogleSignInAccount googleUser= await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication = await googleUser.authentication;
      AuthCredential credential =GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
      Fluttertoast.showToast(msg: "Log in was successful");

      CollectionReference users= FirebaseFirestore.instance.collection('sellers');
      final firestoreInstance = FirebaseFirestore.instance;
      firestoreInstance.collection("sellers").add(
          {
            "username" : googleUser.displayName,
            "email" : googleUser.email,
          });
    }
    if(isLoggedin){
      Navigator.popAndPushNamed(context, 'homepage');
    }
  }

  String email="";
  String password="";
  Future signInWithEmail () async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      setState(() {
        isLoggedin=true;
      });
      if(isLoggedin){
        Navigator.popAndPushNamed(context, 'homepage');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg:'No user found registered with that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg:'Wrong password for that user.');
      }
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
                    child: Container(
                        width: MediaQuery.of(context).size.width*0.9, margin: EdgeInsets.symmetric(vertical: 10),
                        child: Image.asset('assets/logo.png',height: 150,color: Theme.of(context).primaryColor,)),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.9, margin: EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            onChanged: (val){setState(()=>password=val);},
                            style: TextStyle(fontSize: 20,),
                            decoration: InputDecoration(hintStyle: TextStyle( fontSize: 20), hintText: 'Password', enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2,),), border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 3,),), prefixIcon: Padding(child: Icon(Icons.lock,color: Theme.of(context).primaryColor), padding: EdgeInsets.only(left: 30, right: 10),)),
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
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: Text('Login',style: TextStyle(fontSize: 20,color: Colors.white),),
                      onPressed: (){
                        _saveForm();
                        signInWithEmail();
                      },),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.red,width: 3),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),),
                        icon: Icon(FontAwesomeIcons.google,color: Colors.red,),
                        label: Text('Log in with Google',style: TextStyle(fontSize: 20,color: Colors.red)),
                        onPressed: (){
                          signInWithGoogle();
                        },
                      )
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.2),
                    child: Row(
                      children: [
                        Text("Don't have an account?"),
                        FlatButton(child: Text('Sign Up',style: TextStyle(color: Theme.of(context).primaryColor),),onPressed: (){
                          Navigator.pushNamed(context, 'register');
                        },),
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
