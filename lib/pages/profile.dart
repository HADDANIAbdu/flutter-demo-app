import 'package:app/pages/sign-in.dart';
import 'package:app/services/Api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget{
  final String? jwtToken;

  const Profile({super.key, this.jwtToken});


  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile>{

  final ApiService apiService = ApiService();
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    me(widget.jwtToken);
  }

  void me(String? jwtToken) async{
    if(jwtToken != null){
      final resp = await apiService.me(jwtToken);
      if(resp != null){
        isLoading = false;
        userData = resp['data'];
      }
    }
    else{
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignIn()));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return CircularProgressIndicator();

    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Text("Hello, ${userData?['username']}"),
    );
  }
}