import 'package:flutter/material.dart';
import 'package:app/pages/sign-in.dart';
import 'package:app/services/Api_service.dart';

class SignUp extends StatefulWidget{
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>{
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final ApiService apiService = ApiService();

  String? status ;
  String? message;

  void signUp() async{
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    final resp = await apiService.register(username, email, password);
    setState(() {
      if(resp != null){
        status = resp['status'];
        message = resp['message'];
      }
      else{
        status = null;
        message = null;
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text("Sign Up page")),
      body:
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(status == 'success')
              _buildMessage(message, Colors.green),
            if(status == 'error')
              _buildMessage(message, Colors.red),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: "full Name"),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "email"),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: signUp,
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

  Widget _buildMessage(String? text, Color color) {
    if(text != null){
      String message = text;
      return Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(Icons.info, color: color),
            SizedBox(width: 10),
            Expanded(child: Text(message, style: TextStyle(color: color))),
          ],
        ),
      );
    }
    return SizedBox.shrink();
  }
}