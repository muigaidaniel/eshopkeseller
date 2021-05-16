import 'package:eshopkeseller/components/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:eshopkeseller/business_logic/user_provider.dart';
import 'home.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  String _email="";
  String _password="";

  @override
  Widget build(BuildContext context) {
    final user= Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      body: user.status == Status.Authenticating ? Loading()
          : user.status == Status.Authenticated ? Home()
          :  SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Padding(padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/logo.png',height: 150,color: Theme.of(context).primaryColor,)),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.9, margin: EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            onChanged: (val){setState(()=>_email=val);},
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
                            onChanged: (val){setState(()=>_password=val);},
                            style: TextStyle(fontSize: 20,),
                            decoration: InputDecoration(hintStyle: TextStyle( fontSize: 20), hintText: 'Password', enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2,),), border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 3,),), prefixIcon: Padding(child: Icon(Icons.lock,color: Theme.of(context).primaryColor), padding: EdgeInsets.only(left: 30, right: 10),)),
                            obscureText: true,
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
                      onPressed: ()async{
                        if(_formKey.currentState.validate()){
                          if(!await user.signIn(_email, _password))
                            _key.currentState.showSnackBar(SnackBar(content: Text("Sign In failed")));
                        }
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
                          user.signInWithGoogle();
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
