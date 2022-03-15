// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:crypto_wallet/ui/home_view.dart';
import 'package:flutter/material.dart';


class Authentication extends StatefulWidget {


  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final _emailField = TextEditingController();
  final _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.pink,
          ),
          child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [   
          Container(
        width: MediaQuery.of(context).size.width/ 1.3,
        child:  TextFormField(
        style: const TextStyle(color: Colors.white),
           controller: _emailField,
            decoration: const InputDecoration(
             hintText: "something@email.com",
             hintStyle: TextStyle(
               color: Colors.white,
             ),
             labelText: 'Email',
             labelStyle: TextStyle(
               color: Colors.white,
             ),
            ),
            ),
          ),
      SizedBox(height: MediaQuery.of(context).size.height / 35),
         Container(
        width: MediaQuery.of(context).size.width /1.3,
         child: TextFormField(
      style: const TextStyle(color: Colors.white),
            controller: _passwordField,
            obscureText: true,
            decoration: const InputDecoration(
             hintText: "password",
             hintStyle: TextStyle(
               color: Colors.white,
             ),
             labelText: 'password',
             labelStyle: TextStyle(
               color: Colors.white,
             )
            )
            ),
          ),
         SizedBox(height: MediaQuery.of(context).size.height / 35), 
          Container(
          width: MediaQuery.of(context).size.width / 1.4,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
              ),
              child: MaterialButton(
                onPressed: () async{
            bool shouldNavigate =
        await register(_emailField.text, _passwordField.text);
            if (shouldNavigate) {
              Navigator.push(context,
               MaterialPageRoute(
                builder: (context) => const HomeView(),
                ),
              );
            }  
                },
           child: const Text('Register'),
                ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 35),
            Container(
          width: MediaQuery.of(context).size.width / 1.4,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
              ),
              child: MaterialButton(
                onPressed: () async{
                  bool shouldNavigate =
        await signIn(_emailField.text, _passwordField.text);
            if (shouldNavigate) {
              Navigator.push(context,
               MaterialPageRoute(
                builder: (context) => const HomeView(),
                ),
              );
             }
              },
           child: const Text('Login'),
                ),
            ),
          ],
          ),
      ),
      
    );
  }
}