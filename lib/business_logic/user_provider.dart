import 'package:eshopkeseller/database/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum Status{Uninitialized,Authenticated,Authenticating, Unauthenticated}

class UserProvider with ChangeNotifier{
  FirebaseAuth _auth;
  User _user;
  Status _status= Status.Uninitialized;
  Status get status => _status;
  User get user=> _user;

  UserServices _userServices=UserServices();

  UserProvider.initialize(): _auth= FirebaseAuth.instance{
    _auth.authStateChanges().listen((_onStateChanged) { });
  }
  Future<bool> signIn(String email, String password)async{
    try{
      _status =Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _status =Status.Authenticated;
      notifyListeners();
      return true;
    }on FirebaseAuthException catch (e) {
      _status=Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      if (e.code == 'user-not-found') {
        return  Fluttertoast.showToast(msg:"There is no user with that email");
      }else if (e.code == 'wrong-password') {
        return Fluttertoast.showToast(msg: "Incorrect password");
      } else {
        return Fluttertoast.showToast(msg: "Something Went Wrong");
      }
      return false;
    }
  }
  Future<bool> signInWithGoogle () async{
    try{
      _status =Status.Authenticating;
      notifyListeners();
      final GoogleSignIn googleSignIn = new GoogleSignIn();
      final user= await googleSignIn.signIn();
      GoogleSignInAccount googleUser= await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication = await googleUser.authentication;
      AuthCredential credential =GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      await FirebaseAuth.instance.signInWithCredential(credential);

      CollectionReference users= FirebaseFirestore.instance.collection('sellers');
      final firestoreInstance = FirebaseFirestore.instance;
      firestoreInstance.collection("sellers").add(
          {
            "name" : googleUser.displayName,
            "email" : googleUser.email,
            'userId': _auth.currentUser.uid,
          });
      _status =Status.Authenticated;
      notifyListeners();
      return true;
    }catch(e){
      _status=Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }

  }

  Future<bool> signUp(String name, String email, String password, String phoneNumber)async{
    try{
      _status =Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((user){
        Map<String, dynamic> values={
          'name':name,
          'email':email,
          'userId':user.user.uid,
          'phoneNumber':phoneNumber,
          'password':password,
        };
        _userServices.createUser(values);
      } );
      return true;
    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return  Fluttertoast.showToast(msg:"The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        return Fluttertoast.showToast(msg: "The account already exists for that email.");
      } else {
        return Fluttertoast.showToast(msg: "Something Went Wrong.");
      }
    }
    catch(e){
      _status=Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut()async{
    _auth.signOut();
    _status= Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onStateChanged(User user)async{
    if(user == null){
      _status=Status.Unauthenticated;
    }else{
      _user=user;
      _status=Status.Authenticated;
    }
    notifyListeners();
  }

}