import 'package:app/pages/profile.dart';
import 'package:app/pages/sign-up.dart';
import 'package:app/services/Api_service.dart';
import 'package:app/services/Storage_service.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget{
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn>{
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final ApiService apiService = ApiService();
  final StorageService storageService = StorageService();

  String? status;
  String? message;
  String? jwtToken;

  void signIn() async{
    String email = _emailController.text;
    String password = _passwordController.text;

    final resp = await apiService.login(email, password);
    setState(() {
      if(resp != null){
        status = resp['status'];
        message = resp['message'];
        jwtToken = resp['token'];
        storageService.saveToken('JwtToken', jwtToken);
      }
      else{
        status = null;
        message = null;
      }
    });

    if(status == 'success'){
      Future.delayed(Duration(seconds: 3), (){
        if(mounted){
          onSuccessLogin(context);
        }
      });
    }
  }
  
  void onSuccessLogin(BuildContext context){
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => Profile(jwtToken: jwtToken))
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Soft background
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (status == 'success') _buildMessage(message, Colors.green),
                  if (status == 'error') _buildMessage(message, Colors.red),
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: signIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      minimumSize: Size(20, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text("Login", style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                  SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp())
                      );
                    },
                    child: Text("Don't have an account? Sign up"),
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