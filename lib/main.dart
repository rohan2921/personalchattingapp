import 'package:flutter/material.dart';
import 'package:personalchattingapp/screens/chat_screen.dart';
import 'package:personalchattingapp/screens/spash_screen.dart';
import './screens/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chatzz',
        theme: ThemeData(
            primaryColor: Color.fromARGB(0xFF, 0x49, 0x48, 0x9D),
            accentColor: Color.fromARGB(0xFF,0x6C,0x68,0xF5),//#84A5C60 xFF, 0xA7, 0xCE, 0xCB 6C68F5
            accentColorBrightness: Brightness.dark,
            backgroundColor: Colors.white,
            primarySwatch: Colors.blue,
            buttonTheme: ButtonTheme.of(context).copyWith(
                buttonColor: Colors.blue,
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)))),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (ctx, snapShot) {
              if(snapShot.connectionState==ConnectionState.waiting){
                return SplashScreen();
              }
              if (snapShot.hasData) {
                return ChatScreen();
              } else {
                return AuthScreen();
              }
            }));
  }
}
