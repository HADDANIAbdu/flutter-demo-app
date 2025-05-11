import 'package:app/sign-up.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget{
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In page'),),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: "email"),
              ),
              TextField(
                decoration: InputDecoration(labelText: "password"),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Sign In"),
                  onPressed: (){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Signed In (mock)'))
                    );
                  },
              ),
              TextButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SignUp())
                  );
                },
                child: Text("Don't have account ? SignUp")
              )
            ],
          ),
      ),
    );
  }

}