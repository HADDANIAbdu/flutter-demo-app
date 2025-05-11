import 'package:flutter/material.dart';
import 'package:app/pages/sign-in.dart';

class SignUp extends StatelessWidget{
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text("Sign Up page")),
      body:
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: "full Name"),
              ),
              TextField(
                decoration: InputDecoration(labelText: "email"),
              ),
              TextField(
                decoration: InputDecoration(labelText: "password"),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Account created (mock)'))
                  );
                },
                child: Text("Sign Up")
              ),
              TextButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn())
                  );
                },
                child: Text("Already Have an account ? Sign In")
              )
            ],
          ),
        )
      ,
    );
  }
}