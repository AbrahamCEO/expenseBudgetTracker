import 'package:budgetmap/screens/dashboard.dart';
import 'package:budgetmap/screens/sign_up.dart';
import 'package:budgetmap/utils/appvalidator.dart';
import 'package:budgetmap/utils/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
 
// ignore_for_file: prefer_const_constructors

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  var authService = AuthService();
  var isLoader = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Form submission logic
      setState(() {
      isLoader = true;
     });
      var data = {
        "email": _emailController.text,
        "password": _passwordController.text,
      };

   await authService.login(data, context);

   setState(() {
   isLoader = false;
   });

    }
  }

var appValidator = AppValidator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF252634),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 80,
              ),
              SizedBox(
                width: 250,
                child: Text(
                  "Login Account",
                  textAlign: TextAlign.center, 
                  style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)
                )
              ),
              
              const SizedBox(height: 16,),
         
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  color: Colors.white,),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: _buildInputDecoration("Email", Icons.email),
                validator: appValidator.validateEmail, // add the _validateEmail function as the validator
              ),
         
             const SizedBox(height: 16,),

             TextFormField(
              controller: _passwordController,
              style: TextStyle(
                  color: Colors.white,),
                keyboardType: TextInputType.phone,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: _buildInputDecoration("Password", Icons.lock),
                validator: appValidator.validatePassword,
              ),
         
              const SizedBox(height: 40),

              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF15900)),
                  onPressed: () {
                    isLoader ? print("Loading") : _submitForm();
                  },
                  
                  child: isLoader ? 
                  Center(child: CircularProgressIndicator()):

                  Text("Login", 
                  style: TextStyle(color: Colors.white ,fontSize: 20)),
                ),
              ),
              const SizedBox(height: 30), 
              
              TextButton(onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  SignUpView()),
               );
              }, child: Text(
                "Create new account",
                style: TextStyle(color: Color(0xFFF15900), fontSize: 20),
              ))
              
            ],
          ),
        ),
      )
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData suffixIcon) {
    return InputDecoration(
      fillColor: Color(0xAA494A59),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0x35949494))
      ),
        focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      filled: true,
      labelStyle: TextStyle(color: Color(0xFF949494)),
      labelText: label, 
      suffixIcon: Icon(suffixIcon, color: Color(0xFF949494),),
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0))
      );
  }
}