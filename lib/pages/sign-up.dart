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
    if(status == 'success'){
      Future.delayed(Duration(seconds: 3), (){
        if(mounted){
          onSuccessRegister(context);
        }
      });
    }
  }

  void onSuccessRegister(BuildContext context){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignIn())
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (status == 'success') _buildMessage(message, Colors.green),
                  if (status == 'error') _buildMessage(message, Colors.red),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: signUp,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    child: Text("Sign Up"),
                  ),
                  SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      );
                    },
                    child: Text("Already have an account? Sign In"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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